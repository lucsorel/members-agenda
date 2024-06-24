from os import environ
from fastapi.testclient import TestClient
from pymysql.connections import Connection
from testcontainers.mysql import MySqlContainer

from members_agenda_api.__main__ import app
from members_agenda_api.services import get_connection

VENUES_TABLE_QUERY = '''
CREATE TABLE `venues` (
  `id` int UNSIGNED NOT NULL,
  `name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `rank` tinyint UNSIGNED NOT NULL,
  `bg_color_hex` varchar(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
'''

ADD_2_VENUES_QUERY = '''
INSERT INTO `venues` (`id`, `name`, `rank`, `bg_color_hex`) VALUES
(1, 'Accueil BreizhCamp', 1, '005F73'),
(2, 'Goodies', 2, '2D8289');
'''

def create_2_test_venues(connection: Connection):
    with connection.cursor() as cursor:
        cursor.execute(VENUES_TABLE_QUERY)
        cursor.execute(ADD_2_VENUES_QUERY)
        connection.commit()

def test_get_2_venues():
    with MySqlContainer() as container:
        environ["MYSQL_HOST"] = container.get_container_host_ip()
        environ["MYSQL_PORT"] = container.get_exposed_port(3306)
        environ["MEMBERS_AGENDA_USER"] = container.username
        environ["MEMBERS_AGENDA_PASSWORD"] = container.password
        environ["MEMBERS_AGENDA_DATABASE"] = container.dbname

        create_2_test_venues(get_connection())

        client = TestClient(app)
        response = client.get('/api/venues')

        assert response.status_code == 200
        venues = response.json()
        assert len(venues) == 2
        assert venues[1] == {
          'id': 2, 'name': 'Goodies', 'rank': 2, 'bg_color_hex': '2D8289'
        }
