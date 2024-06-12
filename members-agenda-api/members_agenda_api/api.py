from fastapi import APIRouter

from niquests import get

from members_agenda_api.domain import Event, Venue
from members_agenda_api.dataservice import get_data_service

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
