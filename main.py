import pyodbc

from init_src import CONN_STRING, CREATE_DB_SCRIPTS
from init_src.keeping_init import init_keeping_db
from init_src.riding_init import init_riding_db


def main():
    connection = pyodbc.connect(CONN_STRING, autocommit=True)
    cursor = connection.cursor()
    try:
        for script_path in CREATE_DB_SCRIPTS:
            with open(script_path, 'r') as func_file:
                func_script = func_file.read()
            cursor.execute(func_script)
    except Exception as ex:
        print(ex)
    finally:
        cursor.close()
        connection.close()

    init_keeping_db()
    init_riding_db()


if __name__ == "__main__":
    main()
