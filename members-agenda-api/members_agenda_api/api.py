from datetime import datetime

from fastapi import APIRouter, Response, status
from requests import get

from members_agenda_api.domain import AgendaEvent, Person, Slot, Venue
from members_agenda_api.services.dataservice import get_data_service
from members_agenda_api.services.personservice import get_person_service
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
    return get_person_service().get_person(person_id)

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

    return get_person_service().add_member_to_slot(member_id, slot_id, response)
