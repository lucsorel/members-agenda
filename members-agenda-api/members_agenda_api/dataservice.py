from datetime import datetime
from os import getenv
from typing import Dict, Iterable, Tuple

from pymysql.connections import Connection
from pymysql.cursors import DictCursor

from members_agenda_api.domain import Slot, Venue


MYSQL_HOST = getenv('MYSQL_HOST', 'localhost')
MYSQL_PORT = int(getenv('MYSQL_PORT', '6033'))
MEMBERS_AGENDA_DATABASE = getenv('MEMBERS_AGENDA_DATABASE')
MEMBERS_AGENDA_USER = getenv('MEMBERS_AGENDA_USER')
MEMBERS_AGENDA_PASSWORD = getenv('MEMBERS_AGENDA_PASSWORD')

ALL_VENUES_QUERY = 'SELECT `id`, `name`, `rank`, `bg_color_hex` FROM `venues`;'

_SLOTS_FIELDS = '`id`, `title`, `start`, `end`, `venue_id`, `needed_members_nb`'
ALL_SLOTS_QUERY = f'SELECT {_SLOTS_FIELDS} FROM `slots`;'
INTERSECTING_SLOTS_QUERY = f'SELECT {_SLOTS_FIELDS} FROM `slots` WHERE `start` < %(end)s AND `end` > %(start)s;'

class DataService:
    def __init__(self, mysql_connection: Connection):
        self.mysql_connection = mysql_connection

    def _query(self, query: str) -> Iterable[Dict]:
        return self._prepared_query(query, None)

    def _prepared_query(self, prepared_query: str, query_args: Tuple|Iterable|Dict|None) -> Iterable[Dict]:
        """
        Execute a prepared query on database
        Example:
        >>> prepared_query = "SELECT * FROM slots WHERE `start` > %(start)s;"
        >>> query_args = {'start': '2024-06-25T09:30:00'}
        """
        
        with self.mysql_connection.cursor(cursor=DictCursor) as cursor:
            cursor.execute(prepared_query, query_args)
            return cursor.fetchall()

    def get_venues(self) -> list[Venue]:
        return [
            Venue(**venue_dict)
            for venue_dict in self._query(ALL_VENUES_QUERY)
        ]

    def get_slots(self) -> list[Slot]:
        return [
            Slot(**slot_dict)
            for slot_dict in self._query(ALL_SLOTS_QUERY)
        ]

    def get_intersecting_slots(self, start: datetime, end: datetime) -> list[Slot]:
        return [
            Slot(**slot_dict)
            for slot_dict in self._prepared_query(INTERSECTING_SLOTS_QUERY, {"start": start, "end": end})
        ]

_DATA_SERVICE : DataService = None

def get_data_service() -> DataService:
    global _DATA_SERVICE
    if _DATA_SERVICE is None:
        _DATA_SERVICE = DataService(
            Connection(
                host=MYSQL_HOST,
                port=MYSQL_PORT,
                user=MEMBERS_AGENDA_USER,
                password=MEMBERS_AGENDA_PASSWORD,
                database=MEMBERS_AGENDA_DATABASE,
            )
        )
    
    return _DATA_SERVICE