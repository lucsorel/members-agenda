from os import getenv

from psycopg.connection import Connection
from psycopg.rows import dict_row

def get_connection() -> Connection:
    POSTGRES_HOST = getenv('POSTGRES_HOST', 'localhost')
    POSTGRES_PORT = int(getenv('POSTGRES_PORT', '5432'))
    MEMBERS_AGENDA_DATABASE = getenv('MEMBERS_AGENDA_DATABASE')
    MEMBERS_AGENDA_USER = getenv('MEMBERS_AGENDA_USER')
    MEMBERS_AGENDA_PASSWORD = getenv('MEMBERS_AGENDA_PASSWORD')
    connection_url = f'postgresql://{MEMBERS_AGENDA_USER}:{MEMBERS_AGENDA_PASSWORD}@{POSTGRES_HOST}:{POSTGRES_PORT}/{MEMBERS_AGENDA_DATABASE}'
    
    return Connection.connect(
        conninfo=connection_url,
        autocommit=True,
        row_factory=dict_row,
    )
