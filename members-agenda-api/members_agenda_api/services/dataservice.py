from datetime import datetime
from typing import Dict, Iterable

from psycopg.connection import Connection

from members_agenda_api.domain import Assignment, Event, Person, Slot, Venue


ALL_VENUES_QUERY = 'SELECT "id", "name", "rank", "bg_color_hex" FROM venue;'

# event-centric queries
_EVENTS_FIELDS = '"id", "title", "start", "end", "venue_id"'

# slot-centric queries
_SLOTS_FIELDS = '"id", "title", "start", "end", "venue_id", "needed_members_nb"'
ALL_SLOTS_QUERY = f'SELECT {_SLOTS_FIELDS} FROM "slot";'
SLOTS_IN_PERIOD_QUERY = f'SELECT {_SLOTS_FIELDS} FROM "slot" WHERE "start" >= %(start)s AND "end" <= %(end)s;'
INTERSECTING_SLOTS_QUERY = f'SELECT {_SLOTS_FIELDS} FROM "slot" WHERE "start" < %(end)s AND "end" > %(start)s;'

SLOT_WITH_MEMBERS_QUERY = '''
SELECT slot."id", slot."title", slot."start", slot."end", slot."venue_id", slot."needed_members_nb",
  "person"."id" as people_id, "person"."fullname" as people_fullname, "person"."is_member" as people_is_member
FROM slot
    LEFT JOIN "slot__member" ON slot.id = slot__member.slot_id
    LEFT JOIN "person" ON slot__member.person_id = person.id
WHERE slot."id" = %(slot_id)s;
'''

# person-centric queries
PERSON_BY_ID_QUERY = 'SELECT "id", "fullname", "is_member" FROM person WHERE "id" = %(person_id)s;'
ALL_MEMBERS_QUERY = 'SELECT "id", "fullname", "is_member" FROM person WHERE is_member = 1::bit;'

MEMBER_SLOTS_QUERY = '''
SELECT slot."id", slot."title", slot."start", slot."end", slot."venue_id", slot."needed_members_nb"
FROM person
    LEFT JOIN slot__member ON person.id = slot__member.person_id
    JOIN slot ON slot__member.slot_id = slot.id
WHERE person."id" = %(person_id)s AND slot."start" < %(end)s AND slot."end" > %(start)s
ORDER BY slot."start" ASC;
'''

SPEAKER_EVENTS_QUERY = '''
SELECT event."id", event."title", event."start", event."end", event."venue_id"
FROM person
  LEFT JOIN events_speakers ON person.id = events_speakers.person_id
  JOIN event ON events_speakers.event_id = event.id
WHERE person."id" = %(person_id)s AND event."start" < %(end)s AND event."end" > %(start)s
ORDER BY event."start" ASC;
'''
# slot-member centric queries
SLOTS_MEMBERS_IN_PERIOD_QUERY = '''
SELECT slot."id" as slot_id, person."id" as member_id
FROM person
    LEFT JOIN slot__member ON person.id = slot__member.person_id
    JOIN slot ON slot__member.slot_id = slot.id
WHERE slot."start" >= %(start)s AND slot."end" <= %(end)s
ORDER BY slot."start" ASC;
'''

REMOVE_SLOT_MEMBER_QUERY = 'DELETE FROM slot__member WHERE slot__member."slot_id" = %(slot_id)s AND slot__member."person_id" = %(person_id)s;'

class DataService:
    def __init__(self, db_connection: Connection):
        self.db_connection = db_connection

    def _query(self, query: str) -> Iterable[Dict]:
        return self._prepared_query(query, None)

    def _prepared_query(self, prepared_query: str, query_args: tuple|Iterable|dict|None) -> Iterable[Dict]:
        """
        Execute a prepared query on database
        Example:
        >>> prepared_query = "SELECT * FROM slot WHERE `start` > %(start)s;"
        >>> query_args = {'start': '2024-06-25T09:30:00'}
        """
        with self.db_connection.cursor() as cursor:
            cursor.execute(prepared_query, query_args)
            return cursor.fetchall()

    def _prepared_insert(self, prepared_query: str, query_args: tuple|Iterable|dict|None) -> int:
        with self.db_connection.cursor() as cursor:
            affected_rows_nb = cursor.execute(prepared_query, query_args).rowcount
            self.db_connection.commit()
        return affected_rows_nb


    def get_venues(self) -> list[Venue]:
        return [
            Venue(**venue_dict)
            for venue_dict in self._query(ALL_VENUES_QUERY)
        ]

    def get_slots(self, period: tuple[datetime, datetime] | None) -> list[Slot]:
        if period is None:
            return [
                Slot(**slot_dict)
                for slot_dict in self._query(ALL_SLOTS_QUERY)
            ]
        else:
            (start, end) = period
            return [
                Slot(**slot_dict)
                for slot_dict in self._prepared_query(SLOTS_IN_PERIOD_QUERY, {"start": start, "end": end})
            ]

    def get_intersecting_slots(self, start: datetime, end: datetime) -> list[Slot]:
        return [
            Slot(**slot_dict)
            for slot_dict in self._prepared_query(INTERSECTING_SLOTS_QUERY, {"start": start, "end": end})
        ]

    def get_person(self, person_id: int) -> Person:
        person_dicts = self._prepared_query(PERSON_BY_ID_QUERY, {"person_id": person_id})
        if person_dicts:
            person_dict = person_dicts[0]

            return Person(
                id=person_dict['id'],
                fullname=person_dict['fullname'],
                is_member=person_dict['is_member'] == '1',
            )
        else:
            return None

    def get_members(self) -> list[Person]:
        return [
            Person(
                id=person_dict['id'],
                fullname=person_dict['fullname'],
                is_member=person_dict['is_member'] == b'\x01',
            )
            for person_dict in self._query(ALL_MEMBERS_QUERY)
        ]

    def get_slot_with_members(self, slot_id: int) -> tuple[Slot, tuple[Person]]:
        slot_with_members = self._prepared_query(SLOT_WITH_MEMBERS_QUERY, {"slot_id": slot_id})

        if len(slot_with_members) == 0:
            return None, ()
        
        first_row = slot_with_members[0]
        slot = Slot(
            id=first_row['id'],
            title=first_row['title'],
            start=first_row['start'],
            end=first_row['end'],
            venue_id=first_row['venue_id'],
            needed_members_nb=first_row['needed_members_nb'],
        )
        return slot, tuple(
            Person(
                id=person_id,
                fullname=slot_member['people_fullname'],
                is_member=slot_member['people_is_member'] == b'\x01',
            )
            for slot_member in slot_with_members
            if (person_id := slot_member.get('people_id')) is not None
        )

    def get_active_slots_and_events(self, person_id: int, start: datetime, end: datetime) -> tuple[tuple[Slot], tuple[Event]]:
        return (
            tuple(Slot(**slot_dict) for slot_dict in self._prepared_query(MEMBER_SLOTS_QUERY, {'person_id': person_id, 'end': end, 'start': start})),
            tuple(Event(**event_dict) for event_dict in self._prepared_query(SPEAKER_EVENTS_QUERY, {'person_id': person_id, 'end': end, 'start': start})),
        )
    
    def add_member_to_slot(self, person_id: int, slot_id: int) -> int:
        return self._prepared_insert('INSERT INTO "slot__member" ("person_id", "slot_id") VALUES (%(person_id)s, %(slot_id)s);', {'person_id': person_id, 'slot_id': slot_id})

    def get_assignments(self, period: tuple[datetime, datetime]) -> list[Assignment]:
        start, end = period
        return [
            Assignment(**assignment_dict)
            for assignment_dict in self._prepared_query(SLOTS_MEMBERS_IN_PERIOD_QUERY, {"start": start, "end": end})
        ]

    def remove_assignment(self, slot_id: int, member_id: int) -> int:
        return self._prepared_insert(REMOVE_SLOT_MEMBER_QUERY, {"slot_id": slot_id, "person_id": member_id})
