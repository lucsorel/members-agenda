from fastapi.testclient import TestClient
from pymysql.connections import Connection
from testcontainers.mysql import MySqlContainer

from members_agenda_api.__main__ import app

from tests.members_agenda_api.test_1_get_venues_envvars import create_2_test_venues

def test_get_2_venues_mkp(monkeypatch):
    with MySqlContainer() as container:
        connection = Connection(
            host=container.get_container_host_ip(),
            port=int(container.get_exposed_port(3306)),
            user=container.username,
            password=container.password,
            database=container.dbname,
        )
        create_2_test_venues(connection)

        monkeypatch.setattr('members_agenda_api.services.get_connection', lambda: connection)

        client = TestClient(app)
        response = client.get('/api/venues')

        assert response.status_code == 200
        venues = response.json()
        assert len(venues) == 2
        assert venues[1] == {
            'id': 2, 'name': 'Goodies', 'rank': 2, 'bg_color_hex': '2D8289'
        }
