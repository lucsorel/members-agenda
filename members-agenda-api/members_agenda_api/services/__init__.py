from os import getenv

from pymysql.connections import Connection

from members_agenda_api.services.dataservice import DataService
from members_agenda_api.services.personservice import PersonService

MYSQL_HOST = getenv('MYSQL_HOST', 'localhost')
MYSQL_PORT = int(getenv('MYSQL_PORT', '6033'))
MEMBERS_AGENDA_DATABASE = getenv('MEMBERS_AGENDA_DATABASE')
MEMBERS_AGENDA_USER = getenv('MEMBERS_AGENDA_USER')
MEMBERS_AGENDA_PASSWORD = getenv('MEMBERS_AGENDA_PASSWORD')

def get_connection() -> Connection:
    return Connection(
        host=MYSQL_HOST,
        port=MYSQL_PORT,
        user=MEMBERS_AGENDA_USER,
        password=MEMBERS_AGENDA_PASSWORD,
        database=MEMBERS_AGENDA_DATABASE,
    )

def get_data_service() -> DataService:
    return DataService(get_connection())

def get_person_service() -> PersonService:
    return PersonService(get_data_service())
