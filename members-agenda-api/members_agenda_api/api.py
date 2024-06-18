from datetime import datetime

from fastapi import APIRouter, HTTPException, Response, status
from fastapi.responses import JSONResponse
from fastapi.encoders import jsonable_encoder
from requests import get

from members_agenda_api.domain import AgendaEvent, AlreadyInvolvedResponse, Person, Slot, Venue
from members_agenda_api.dataservice import get_data_service
from members_agenda_api.validation import validate_positive_int


API_ROUTER = APIRouter(prefix='/api')

@API_ROUTER.get('/agenda')
def get_agenda() -> list[AgendaEvent]:
    return [
        AgendaEvent(
            id=raw_event['id'],
            name=raw_event['name'],
            start=raw_event['event_start'],
            end=raw_event['event_end'],
            format=raw_event['format'],
            venue=raw_event['venue'],
            venue_id=raw_event['venue_id'],
            speakers=raw_event['speakers'].split(', '),
        )
        for raw_event in get('https://www.breizhcamp.org/json/schedule.json').json()
    ]

@API_ROUTER.get('/people/{person_id}')
def get_person(person_id: int) -> Person:
    validate_positive_int(person_id)
    person = get_data_service().get_person(person_id)
    if person is None:
        raise HTTPException(status_code=404, detail=f'Nobody with id {person_id}')
    else:
        return person

@API_ROUTER.get('/venues')
def get_venues() -> list[Venue]:
    return get_data_service().get_venues()

@API_ROUTER.get('/slots')
def get_slots() -> list[Slot]:
    return get_data_service().get_slots()

@API_ROUTER.get('/slots/intersect')
def get_intersecting_slots(start: datetime, end: datetime) -> list[Slot]:
    return get_data_service().get_intersecting_slots(start, end)

@API_ROUTER.post('/slots/{slot_id}/add-member', status_code=status.HTTP_201_CREATED)
def add_member_to_slot(slot_id: int, member_id: int, response: Response) -> int:
    validate_positive_int(slot_id)
    validate_positive_int(member_id)

    data_service = get_data_service()

    person = data_service.get_person(member_id)
    if person is None:
        raise HTTPException(status_code=404, detail=f'Nobody with id {member_id}')
    if not person.is_member:
        raise HTTPException(status_code=405, detail=f'Person of id {member_id} is not a member')

    slot, existing_members = data_service.get_slot_with_members(slot_id)
    if slot is None:
        raise HTTPException(status_code=404, detail=f'No slot with id {slot_id}')

    # exits here if the member is already added to the slot
    already_member = any(slot_member.id == member_id for slot_member in existing_members)
    if already_member:
        response.status_code = status.HTTP_200_OK
        return 0

    # verifies that the person is not a speaker in an event nor a member in another slot during the period
    member_slots, speaker_events = data_service.get_active_slots_and_events(member_id, slot.start, slot.end)
    if member_slots or speaker_events:
        return JSONResponse(
            content=jsonable_encoder(AlreadyInvolvedResponse(
                message="person already involved during this period",
                member_slots=member_slots,
                speaker_events=speaker_events
            )),
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR
        )

    # adds the member to the slot
    return data_service.add_member_to_slot(member_id, slot_id)
