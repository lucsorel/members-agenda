from members_agenda_api.services.connection import get_connection
from members_agenda_api.services.dataservice import DataService
from members_agenda_api.services.personservice import PersonService

def get_data_service() -> DataService:
    return DataService(get_connection())

def get_person_service() -> PersonService:
    return PersonService(get_data_service())
