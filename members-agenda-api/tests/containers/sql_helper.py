from pathlib import Path
from typing import NamedTuple

from pymysql.connections import Connection

from tests.containers.sql_queries_parser import execute_sql_queries

class SqlTestHelper(NamedTuple):
    connection: Connection

    def setup_with_sql_filepath(self, sql_filepath: Path):
        """
        Executes the queries in the given sql file against the database in the connection
        """
        with open(sql_filepath, encoding='utf8') as sql_file:
            execute_sql_queries(sql_file, self.connection)
