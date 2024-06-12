from pydantic import BaseModel

class Event(BaseModel):
    id: str
    name: str
    start: str
    end: str
    format: str
    venue: str
    venue_id: str|None
    speakers: list[str]

class Venue(BaseModel):
    id: int
    name: str
    rank: int
    bg_color_hex: str
