from fastapi.testclient import TestClient
from pymysql.cursors import DictCursor

from members_agenda_api.__main__ import app

from tests.containers.sql_helper import SqlTestHelper
from tests.containers.sql_files import SQL_FILES_FOLDER

def test_add_member_to_slot_fixture(monkeypatch, sql_test_helper: SqlTestHelper):
    sql_test_helper.setup_with_sql_filepath(SQL_FILES_FOLDER / 'add-member-to-slot.sql')
    monkeypatch.setattr(
        'members_agenda_api.services.get_connection',
        lambda: sql_test_helper.connection
    )

    client = TestClient(app)
    slot_id = 44
    member_id = 70 # bénévole disponible

    query = "SELECT count(*) AS assignments_nb FROM slots_members WHERE slot_id = %(slot_id)s and person_id = %(person_id)s;"
    query_params = {'slot_id': slot_id, 'person_id': member_id}
    with sql_test_helper.connection.cursor(cursor=DictCursor) as cursor:
        cursor.execute(query, query_params)
        assert cursor.fetchone()['assignments_nb'] == 0, 'bénévole pas encore assigné·e'

    response = client.post(f'/api/slots/{slot_id}/add-member?member_id={member_id}')
    assert response.status_code == 201
    assert response.json() == 1, 'une ligne insérée dans slots_members'


    with sql_test_helper.connection.cursor(cursor=DictCursor) as cursor:
        cursor.execute(query, query_params)
        assert cursor.fetchone()['assignments_nb'] == 1, 'bénévole assigné·e'
        
