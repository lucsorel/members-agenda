from datetime import datetime
from typing import Iterable

from pydantic import BaseModel

class AgendaEvent(BaseModel):
    id: str
    name: str
    start: str
    end: str
    format: str
    venue: str
    venue_id: str|None
    speakers: list[str]

class Event(BaseModel):
    id: int
    title: str
    start: datetime
    end: datetime
    venue_id: int

class Venue(BaseModel):
    id: int
    name: str
    rank: int
    bg_color_hex: str

class Slot(BaseModel):
    id: int
    title: str
    start: datetime
    end: datetime
    venue_id: int
    needed_members_nb: int

class Person(BaseModel):
    id: int
    fullname: str
    is_member: bool

class Assignment(BaseModel):
    slot_id: int
    member_id: int

class AlreadyInvolvedResponse(BaseModel):
    message: str
    member_slots: Iterable[Slot]
    speaker_events: Iterable[Event]
