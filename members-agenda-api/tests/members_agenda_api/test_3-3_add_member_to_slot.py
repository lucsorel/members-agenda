from fastapi.testclient import TestClient
from pytest import mark

from members_agenda_api.__main__ import app

from tests.containers.sql_helper import SqlTestHelper
from tests.containers.sql_files import SQL_FILES_FOLDER

@mark.parametrize(
    ['slot_id', 'member_id', 'expected_status_code', 'expected_json'],
    [
        (44, 70, 201, 1), # Johanna dispo pour aider
        (43, 7, 200, 0),  # Alex est déjà sur ce créneau
        (44, 666, 404, {'detail': 'nobody with id 666'}), # personne n'est 666
        (99, 70, 404, {'detail': 'no slot with id 99'}),  # pas de slot 99
        (44, 7, 500, {
            'message': 'person already involved during this period',
            'member_slots': [{'id': 43, 'title': 'Accueil', 'start': '2024-06-27T10:15:00', 'end': '2024-06-27T12:30:00', 'venue_id': 1, 'needed_members_nb': 3}],
            'speaker_events': []
        }), # Alex est déjà dans un autre slot
        (44, 95, 405, {'detail': 'person of id 95 is not a member'}), # Nailya n'est pas bénévole
        (47, 79, 500, {
            'message': 'person already involved during this period',
            'member_slots': [],
            'speaker_events': [{'id': 22, 'title': 'Testcontainers : tu ne douteras plus de tes fonctionnalités, jeune Pydawan·e', 'start': '2024-06-27T10:30:00', 'end': '2024-06-27T11:25:00', 'venue_id': 4}]
        }), # Luc intervient déjà dans ce créneau
        (44, 25, 405, {'detail': 'person of id 25 is not a member'}), # Cécilia (405 ou 500 ?)
    ]
)
def test_add_member_to_slot_doctrace(
    # fixtures
    monkeypatch, sql_test_helper: SqlTestHelper,
    # test params
    slot_id, member_id, expected_status_code, expected_json
):
    sql_test_helper.setup_with_sql_filepath(SQL_FILES_FOLDER / 'add-member-to-slot.sql')
    monkeypatch.setattr(
        'members_agenda_api.services.get_connection',
        lambda: sql_test_helper.connection
    )

    client = TestClient(app)
    response = client.post(f'/api/slots/{slot_id}/add-member?member_id={member_id}')
    # print(f'{response.status_code=}')
    # print(f'{response.json()=}')
    
    assert response.status_code == expected_status_code
    assert response.json() == expected_json
