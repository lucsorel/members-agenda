from datetime import datetime

from fastapi import APIRouter, HTTPException, Response, status
from requests import get

from members_agenda_api.domain import Event, Slot, Venue
from members_agenda_api.dataservice import get_data_service
from members_agenda_api.validation import validate_positive_int

API_ROUTER = APIRouter(prefix='/api')

@API_ROUTER.get('/agenda')
def get_agenda() -> list[Event]:
    return [
        Event(
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
def add_member_to_slot(slot_id: int, member_id: int, response: Response):
    validate_positive_int(slot_id)
    validate_positive_int(member_id)

    data_service = get_data_service()
    slot, existing_members = data_service.get_slot_with_members(slot_id)
    if slot is None:
        raise HTTPException(status_code=404, detail=f'No slot with id {slot_id}')

    already_member = any(slot_member.id == member_id for slot_member in existing_members)
    if already_member:
        response.status_code = status.HTTP_200_OK

    # TODO check if slot intersects events in which the person is a speaker
    return slot, existing_members
