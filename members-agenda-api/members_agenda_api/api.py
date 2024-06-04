from fastapi import APIRouter
from pydantic import BaseModel

from niquests import get


class Event(BaseModel):
    id: str
    name: str
    start: str
    end: str
    format: str
    venue: str
    venue_id: str|None
    speakers: list[str]

API_ROUTER = APIRouter(prefix='/api')

@API_ROUTER.get('/agenda')
def get_agenda():
    return [
        Event(
            id=raw_event['id'],
            name=raw_event['name'],
            start=raw_event['event_start'],
            end=raw_event['event_end'],
            format=raw_event['format'],
            venue=raw_event['venue'],
            venue_id=raw_event['venue_id'],
            speakers=raw_event['speakers'].split(','),
        )
        for raw_event in get('https://www.breizhcamp.org/json/schedule.json').json()
    ]