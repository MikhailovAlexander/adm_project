import pyodbc
import random

from init_src import *
from init_src.date_methods import get_random_date, get_month_end, add_months
from init_src.generate_methods import gen_horse_data
from init_src.common_db_methods import init_db, insert_employees, \
    insert_prices, get_services, insert_new_client, get_clients


def init_keeping_db():
    connection = pyodbc.connect(KEEPING_CONN_STRING, autocommit=True)
    cursor = connection.cursor()
    try:
        init_db(cursor, KEEPING_INIT_SCRIPT_PATH, KEEPING_FUNCTIONS,
                KEEPING_PROCEDURES, KEEPING_VIEWS)
        insert_employees(cursor)
        insert_prices(cursor, 1000, 200)
        __insert_business_data(cursor)
    except Exception as ex:
        print(ex)
    finally:
        cursor.close()
        connection.close()


def __insert_business_data(cursor):
    prev_date = START_DATE
    start_date = START_DATE
    end_date = get_month_end(start_date)

    while start_date < datetime.date.today():
        cursor.execute(CREATE_INVOICES_QUERY, [prev_date, start_date])
        __insert_payments(cursor, start_date, end_date)
        for _ in range(10, 20):
            __insert_client_and_contracts(cursor, start_date, end_date)

        prev_date = start_date
        start_date = add_months(start_date, 1)
        end_date = get_month_end(start_date)


def __insert_payments(cursor, start_date, end_date):
    for client_id in get_clients(cursor):
        debt = __get_client_debt(cursor, client_id)
        if debt == 0:
            continue
        if random.random() < 0.8:
            pay_sum = debt
        elif random.random() < 0.9:
            pay_sum = random.randint(1, int(debt))
        else:
            continue
        pay_date = get_random_date(start_date, end_date)
        data = [pay_date, pay_sum, client_id]
        cursor.execute(INSERT_PAYMENT_QUERY, data)
        payment_id = cursor.fetchone()[0]
        cursor.execute(DISTRIBUTE_PAYMENT_QUERY, payment_id)


def __insert_client_and_contracts(cursor, start_date, end_date):
    contract_date = get_random_date(start_date, end_date)
    client_id = insert_new_client(cursor)
    cursor.execute(SELECT_MANAGERS_QUERY)
    manager_ids = [row[0] for row in cursor.fetchall()]
    manager_id = random.choice(manager_ids)
    if random.random() < 0.8:
        contract_cnt = 1
    elif random.random() < 0.95:
        contract_cnt = 2
    else:
        contract_cnt = 3
    for _ in range(contract_cnt):
        __insert_contract(cursor, client_id, contract_date, manager_id)


def __insert_contract(cursor, client_id, contract_date, employee_id):
    data = gen_horse_data()
    data.append(contract_date)
    data.append(client_id)
    data.append(employee_id)
    cursor.execute(INSERT_CONTRACT_QUERY, data)

    contract_id = cursor.fetchone()[0]
    service_ids = get_services(cursor)
    for _ in range(random.randint(1, len(service_ids) - 1)):
        service_id = random.choice(service_ids)
        service_ids.remove(service_id)
        data = [contract_id, service_id]
        cursor.execute(ADD_SERVICE_TO_CONTRACT_QUERY, data)

    return contract_id


def __get_client_debt(cursor, client_id):
    cursor.execute(SELECT_CLIENT_DEBT_QUERY, client_id)
    return cursor.fetchone()[0]


if __name__ == "__main__":
    init_keeping_db()
