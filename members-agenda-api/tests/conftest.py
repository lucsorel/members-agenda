"""
This module is detected by pytest and registers the fixtures defined in it.
"""
from pymysql.connections import Connection
from pytest import fixture
from testcontainers.mysql import MySqlContainer

from tests.containers.sql_helper import SqlTestHelper

@fixture(scope="session")
def sql_test_helper() -> SqlTestHelper:
    db_name = 'members_agenda'
    test_user = 'members_agenda_test'
    test_user_password = 'I_l0v3_t35t5'
    # Docker container creation
    with MySqlContainer(
        image="mysql:8.0",
        username=test_user,
        password=test_user_password,
        dbname=db_name,
    ) as sql_container:
        # database connection (for direct use or monkeypatching in tests)
        connection = Connection(
            user=test_user,
            password=test_user_password,
            host=sql_container.get_container_host_ip(),
            port=int(sql_container.get_exposed_port(sql_container.port)),
            database=db_name,
        )

        yield SqlTestHelper(connection)

        # you could write post-tests code here