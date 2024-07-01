"""
This module is detected by pytest and registers the fixtures defined in it.
"""
from subprocess import run

from pymysql.connections import Connection
from pytest import fixture, mark
from testcontainers.mysql import MySqlContainer

from tests.containers.sql_helper import SqlTestHelper

@fixture(scope="session")
def sql_test_helper() -> SqlTestHelper:
    db_name = 'members_agenda'

    # Docker container creation
    with MySqlContainer(
        image="mysql:8.0",
        dbname=db_name,
    ) as sql_container:
        # database connection (for direct use or monkeypatching in tests)
        connection = Connection(
            user=sql_container.username,
            password=sql_container.password,
            host=sql_container.get_container_host_ip(),
            port=int(sql_container.get_exposed_port(sql_container.port)),
            database=db_name,
        )

        yield SqlTestHelper(connection)

        # you could write post-tests code here

def _is_docker_available() -> bool:
    """
    Checks whether docker is installed and running using subprocesses.

    Do not use directly, use the IS_DOCKER_AVAILABLE constant instead.
    """
    is_docker_installed_process = run(("which", "docker"), capture_output=True)
    if is_docker_installed_process.returncode != 0:
        return False

    is_docker_running_process = run(("docker", "ps"), capture_output=True)
    return is_docker_running_process.returncode == 0


def _is_docker_available() -> bool:
    """
    Checks whether docker is installed and running using subprocesses.
    """
    is_docker_installed_process = run(("which", "docker"), capture_output=True)
    if is_docker_installed_process.returncode != 0:
        return False

    is_docker_running_process = run(("docker", "ps"), capture_output=True)
    return is_docker_running_process.returncode == 0

# déclaration programmatique du marker
mark.skipifnodocker = mark.skipif(
    not _is_docker_available(),
    reason="Requires docker to spin a container"
)
