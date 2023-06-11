import pyodbc
import random

from constants import *


def init_riding_db():
    connection = pyodbc.connect(RIDING_CONN_STRING, autocommit=True)
    cursor = connection.cursor()
    try:
        __init_db(cursor)
    except Exception as ex:
        print(ex)
    finally:
        cursor.close()
        connection.close()


def __init_db(cursor):
    with open(RIDING_INIT_SCRIPT_PATH, 'r') as init_file:
        init_script = init_file.read()
    cursor.execute(init_script)
    for func_path in RIDING_FUNCTIONS:
        with open(func_path, 'r') as func_file:
            func_script = func_file.read()
        cursor.execute(func_script)
    for proc_path in RIDING_PROCEDURES:
        with open(proc_path, 'r') as proc_file:
            proc_script = proc_file.read()
        cursor.execute(proc_script)


if __name__ == "__main__":
    init_riding_db()
