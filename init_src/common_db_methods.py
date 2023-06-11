import datetime
import random

from init_src import SELECT_PROFS_QUERY, START_DATE, INSERT_EMPLOYEE_QUERY, \
    INSERT_PRICE_QUERY, SELECT_SERVICES_QUERY, INSERT_CLIENT_QUERY
from init_src.generate_methods import gen_person_data


def init_db(cursor, init_script_path, functions, procedures, views):
    with open(init_script_path, 'r') as init_file:
        init_script = init_file.read()
    cursor.execute(init_script)
    for db_obj_list in [functions, procedures, views]:
        for db_obj_path in db_obj_list:
            with open(db_obj_path, 'r') as file:
                script = file.read()
            cursor.execute(script)


def insert_employees(cursor):
    employee_cnt = 10
    cursor.execute(SELECT_PROFS_QUERY)
    for prof_row in cursor.fetchall():
        for _ in range(employee_cnt):
            data = gen_person_data()
            data.append(START_DATE)
            data.append(prof_row[0])
            cursor.execute(INSERT_EMPLOYEE_QUERY, data)


def insert_prices(cursor, start_price, mult):
    for service_id in get_services(cursor):
        price = start_price + 100*random.randint(1, mult)
        data = [price, START_DATE, service_id]
        cursor.execute(INSERT_PRICE_QUERY, data)


def insert_new_client(cursor):
    data = gen_person_data()
    cursor.execute(INSERT_CLIENT_QUERY, data)
    return cursor.fetchone()[0]


def get_services(cursor):
    cursor.execute(SELECT_SERVICES_QUERY)
    return [row[0] for row in cursor.fetchall()]
