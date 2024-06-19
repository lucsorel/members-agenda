from os import getenv

from pymysql.connections import Connection

from members_agenda_api.services.dataservice import DataService
from members_agenda_api.services.personservice import PersonService

MYSQL_HOST = getenv('MYSQL_HOST', 'localhost')
MYSQL_PORT = int(getenv('MYSQL_PORT', '6033'))
MEMBERS_AGENDA_DATABASE = getenv('MEMBERS_AGENDA_DATABASE')
MEMBERS_AGENDA_USER = getenv('MEMBERS_AGENDA_USER')
MEMBERS_AGENDA_PASSWORD = getenv('MEMBERS_AGENDA_PASSWORD')


_DATA_SERVICE: DataService = None
_PERSON_SERVICE: PersonService = None

def get_person_service() -> PersonService:
    return _PERSON_SERVICE

def get_data_service() -> DataService:
    return _DATA_SERVICE

def load_services():
    # instantiates the application services once for all
    global _DATA_SERVICE, _PERSON_SERVICE

    if not _DATA_SERVICE:
        _DATA_SERVICE = DataService(
            Connection(
                host=MYSQL_HOST,
                port=MYSQL_PORT,
                user=MEMBERS_AGENDA_USER,
                password=MEMBERS_AGENDA_PASSWORD,
                database=MEMBERS_AGENDA_DATABASE,
            )
        )

    if not _PERSON_SERVICE:
        _PERSON_SERVICE = PersonService(_DATA_SERVICE)