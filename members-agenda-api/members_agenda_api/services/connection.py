from os import getenv

from pymysql.connections import Connection

def get_connection() -> Connection:
    MYSQL_HOST = getenv('MYSQL_HOST')
    MYSQL_PORT = int(getenv('MYSQL_PORT'))
    MEMBERS_AGENDA_DATABASE = getenv('MEMBERS_AGENDA_DATABASE')
    MEMBERS_AGENDA_USER = getenv('MEMBERS_AGENDA_USER')
    MEMBERS_AGENDA_PASSWORD = getenv('MEMBERS_AGENDA_PASSWORD')
    
    return Connection(
        host=MYSQL_HOST,
        port=MYSQL_PORT,
        user=MEMBERS_AGENDA_USER,
        password=MEMBERS_AGENDA_PASSWORD,
        database=MEMBERS_AGENDA_DATABASE,
    )
