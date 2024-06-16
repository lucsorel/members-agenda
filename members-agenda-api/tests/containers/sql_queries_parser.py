"""
pymysql cannot execute several SQL queries within a single string.
This module:
- parses a StringIO into text lines
- removes the comment lines
- groups the lines into queries that span accross multiple lines
- executes the queries within an SQL transaction
"""

from io import StringIO
from re import compile as re_compile
from typing import Iterable, Iterator

from pymysql.connections import Connection
from pymysql.err import ProgrammingError

# the line starts with comment characters ("--" or "/*"), (possibly preceded by space characters)
IS_SQL_COMMENT_LINE_PATTERN = re_compile(r'^\s*(?:(?:--)|(?:/\*)|(?:\n))')
# the line ends with a ";" (possibly followed by space characters)
HAS_QUERY_END_PATTERN = re_compile(r'^(.*;)\s*$')

def filter_out_comments(sql_lines: Iterable[str]) -> Iterator[str]:
    for sql_line in sql_lines:
        if not IS_SQL_COMMENT_LINE_PATTERN.match(sql_line):
            yield sql_line

def group_parts_by_query(query_lines: Iterable[str]) -> Iterator[str]:
    query_parts = []
    for query_line in query_lines:
        if (query_end_match := HAS_QUERY_END_PATTERN.match(query_line)):
            query_parts.append(query_end_match.group(1))
            yield "".join(query_parts)
            query_parts = []

        else:
            query_parts.append(query_line)

def execute_sql_queries(sql_contents: StringIO, connection: Connection):
    """
    Detects the queries in an opened sql file and performs them on the given connection.
    - comments are ignored (lines starting with '--')
    - a query ends when a line ends with ';' (potentially followed by blank characters)
    """
    
    with connection.cursor() as cursor:
        for query in group_parts_by_query(filter_out_comments(sql_contents)):
            try:
                cursor.execute(query, None)
            except ProgrammingError as programming_error:
                error_code, hint = programming_error.args
                print(f'A {error_code} Pymysql occurred while executing query:\n{query}')
                print(f'Hint: {hint}')
                raise

    connection.commit()
