import random

import pyodbc

from init_src import *
from init_src.common_db_methods import init_db, insert_employees, \
    insert_prices, insert_new_client, get_services
from init_src.generate_methods import gen_phone, gen_email, gen_horse_data


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
        __insert_empl_serv_link(cursor)
        __insert_schedule(cursor)
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


def __insert_empl_serv_link(cursor):
    professions = ['Concours coach', 'Dressage coach', 'Hippotherapist',
                   'Riding instructor']
    prof_serv_dict = {'Concours coach': ['Concours  workout',
                                         'Horseback riding workout'],
                      'Dressage coach': ['Dressage workout', 'Pony riding'],
                      'Hippotherapist': ['Hippotherapy'],
                      'Riding instructor': ['Horseback riding outing',
                                            'Excursion', 'Celebration event',
                                            'Photo session'],
                      'Stableman': ['Photo session', 'Excursion',
                                    'Celebration event']}
    for prof_name in professions:
        cursor.execute(SELECT_EMPLOYEE_QUERY, prof_name)
        employee_ids = [row[0] for row in cursor.fetchall()]
        for employee_id in employee_ids:
            service_name = random.choice(prof_serv_dict[prof_name])
            cursor.execute(SELECT_SERVICE_ID_QUERY, service_name)
            service_id = cursor.fetchone()[0]
            data = [START_DATE, employee_id, service_id]
            cursor.execute(INSERT_EMPL_SERVICE_LINK_QUERY, data)
            cursor.execute(INSERT_HORSE_QUERY, gen_horse_data())
            horse_id = cursor.fetchone()[0]
            data = [START_DATE, horse_id, service_id]
            cursor.execute(INSERT_HORSE_SERVICE_LINK_QUERY, data)


def __insert_schedule(cursor):
    cursor.execute(SELECT_EMPLOYEE_QUERY, 'Manager')
    manager_ids = [row[0] for row in cursor.fetchall()]
    for service_id in get_services(cursor):
        manager_id = random.choice(manager_ids)
        cursor.execute(SELECT_EMPL_LINKS_QUERY, service_id)
        empl_link_ids = [row[0] for row in cursor.fetchall()]
        if len(empl_link_ids) == 0:
            continue
        cursor.execute(SELECT_HORSE_LINKS_QUERY, service_id)
        horse_link_ids = [row[0] for row in cursor.fetchall()]
        start_dt = (datetime.datetime(year=START_DATE.year,
                                      month=START_DATE.month,
                                      day=START_DATE.day) +
                    datetime.timedelta(hours=9))
        while start_dt < datetime.datetime.now():
            idx = random.randint(0, len(empl_link_ids) - 1)
            empl_link_id = empl_link_ids[idx]
            horse_link_id = horse_link_ids[idx]
            for i in range(4):
                row_dt = start_dt + datetime.timedelta(hours=i*2)
                data = [row_dt, empl_link_id, horse_link_id, manager_id]
                cursor.execute(INSERT_SCHEDULE_ROW_QUERY, data)
            start_dt += datetime.timedelta(days=1)


if __name__ == "__main__":
    init_riding_db()
