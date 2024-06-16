from fastapi.testclient import TestClient

from members_agenda_api.__main__ import app
from members_agenda_api.dataservice import DataService

from tests.containers.sql_helper import SqlTestHelper
from tests.containers.sql_files import SQL_FILES_FOLDER


def test_api_get_venues(monkeypatch, sql_test_helper: SqlTestHelper):
    sql_test_helper.setup_with_sql_filepath(SQL_FILES_FOLDER / 'venues_samples.sql')
    monkeypatch.setattr('members_agenda_api.api.get_data_service', lambda: DataService(sql_test_helper.connection))

    client = TestClient(app)
    response = client.get('/api/venues')
    assert response.status_code == 200
    assert len(response.json()) == 4
