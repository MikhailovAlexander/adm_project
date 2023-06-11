import random

import pyodbc

from init_src import *
from init_src.common_db_methods import init_db, insert_employees, \
    insert_prices, insert_new_client
from init_src.generate_methods import gen_phone, gen_email


def init_riding_db():
    connection = pyodbc.connect(RIDING_CONN_STRING, autocommit=True)
    cursor = connection.cursor()
    keeping_connection = pyodbc.connect(KEEPING_CONN_STRING, autocommit=True)
    keeping_cursor = keeping_connection.cursor()
    try:
        init_db(cursor, RIDING_INIT_SCRIPT_PATH, RIDING_FUNCTIONS,
                RIDING_PROCEDURES, RIDING_VIEWS)
        insert_employees(cursor)
        insert_prices(cursor, 500, 50)
        __insert_clients(cursor, keeping_cursor)
    except Exception as ex:
        print(ex)
    finally:
        cursor.close()
        connection.close()
        keeping_cursor.close()
        keeping_connection.close()


def __insert_clients(cursor, keeping_cursor):
    client_cnt = 150
    keeping_cursor.execute(SELECT_CLIENT_DATA_QUERY)
    keeping_client_data = [row for row in keeping_cursor.fetchall()]
    for _ in range(client_cnt):
        if len(keeping_client_data) > 0 and random.random() < 0.33:
            idx = random.randint(0, len(keeping_client_data) - 1)
            data = list(keeping_client_data[idx])
            if random.random() < 0.1:
                data[3] = gen_phone()
            if random.random() < 0.05:
                data[4] = gen_email()
            cursor.execute(INSERT_CLIENT_QUERY, data)
            keeping_client_data.pop(idx)
        else:
            insert_new_client(cursor)


if __name__ == "__main__":
    init_riding_db()
