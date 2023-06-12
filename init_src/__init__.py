import os
import datetime
from mimesis.enums import Gender

__host = os.environ['PGHOST']
__db = os.environ['POSTGRES_DB']
__user = os.environ['POSTGRES_USER']
__pwd = os.environ['POSTGRES_PASSWORD']
__keeping_db = 'horse_keeping_center'
__riding_db = 'horse_riding_center'
CONN_STRING = f'Driver={{PostgreSQL Unicode}};Server={__host};' \
              f'Port=5432;Database={__db};Uid={__user};Pwd={__pwd};'

YEAR = datetime.datetime.now().year
START_DATE = datetime.date(YEAR, 1, 1)
GENDER_DICT = {1: Gender.MALE, 2: Gender.FEMALE}
SELECT_PROFS_QUERY = 'SELECT profession_id FROM public.profession'
INSERT_EMPLOYEE_QUERY = 'CALL public.add_employee(?, ?, ?, ?, ?, ?, ?, NULL);'
INSERT_CLIENT_QUERY = 'CALL public.add_client(?, ?, ?, ?, ?, NULL);'
SELECT_CLIENT_DATA_QUERY = 'SELECT person_name, person_birth_date, sex_id, client_phone, client_email FROM public.v_client'

CREATE_DB_SCRIPTS = ['db/horse_keeping/horse_keeping_create.sql',
                     'db/horse_riding/horse_riding_create.sql']

KEEPING_CONN_STRING = f'Driver={{PostgreSQL Unicode}};Server={__host};' \
                      f'Port=5432;Database={__keeping_db};Uid={__user};' \
                      f'Pwd={__pwd};'
KEEPING_INIT_SCRIPT_PATH = 'db/horse_keeping/horse_keeping_init.sql'
KEEPING_FUNCTIONS = ['db/horse_keeping/functions/'
                     'get_unpaid_invoice_details_by_client.sql',
                     'db/horse_keeping/functions/get_client_debt.sql',
                     'db/horse_keeping/functions/get_managers_employee_id.sql']
KEEPING_PROCEDURES = ['db/horse_keeping/procedures/add_client.sql',
                      'db/horse_keeping/procedures/add_contract.sql',
                      'db/horse_keeping/procedures/add_employee.sql',
                      'db/horse_keeping/procedures/add_invoice.sql',
                      'db/horse_keeping/procedures/add_payment.sql',
                      'db/horse_keeping/procedures/add_service_to_contract.sql',
                      'db/horse_keeping/procedures/distribute_payment.sql',
                      'db/horse_keeping/procedures/create_invoice.sql']
KEEPING_VIEWS = ['db/horse_keeping/views/v_client.sql']
INSERT_CONTRACT_QUERY = 'CALL public.add_contract(?, ?, ?, ?, ?, NULL);'
SELECT_SERVICES_QUERY = 'SELECT service_id FROM public.service'
INSERT_PRICE_QUERY = 'INSERT INTO public.service_price (service_price, service_price_active_from, service_id) VALUES (?, ?, ?);'
SELECT_MANAGERS_QUERY = 'SELECT employee_id FROM public.get_managers_employee_id()'
ADD_SERVICE_TO_CONTRACT_QUERY = 'CALL public.add_service_to_contract(?, ?, NULL);'
CREATE_INVOICES_QUERY = 'CALL public.create_invoices(?, ?);'
SELECT_CLIENTS_QUERY = 'SELECT client_id FROM public.client'
SELECT_CLIENT_DEBT_QUERY = 'SELECT public.get_client_debt(?)'
INSERT_PAYMENT_QUERY = 'CALL public.add_payment(?, ?, ?, NULL);'
DISTRIBUTE_PAYMENT_QUERY = 'CALL public.distribute_payment(?);'

RIDING_CONN_STRING = f'Driver={{PostgreSQL Unicode}};Server={__host};' \
                     f'Port=5432;Database={__riding_db};Uid={__user};' \
                     f'Pwd={__pwd};'
RIDING_INIT_SCRIPT_PATH = 'db/horse_riding/horse_riding_init.sql'
RIDING_FUNCTIONS = ['db/horse_riding/functions/get_employees_id_by_profession.sql',
                    'db/horse_riding/functions/get_service_id_by_schedule_day.sql',
                    'db/horse_riding/functions/get_schedule_id_by_day_and_service.sql']
RIDING_PROCEDURES = ['db/horse_riding/procedures/add_client.sql',
                     'db/horse_riding/procedures/add_employee.sql',
                     'db/horse_riding/procedures/add_horse.sql',
                     'db/horse_riding/procedures/add_schedule_row.sql',
                     'db/horse_riding/procedures/add_client_to_schedule.sql']
RIDING_VIEWS = ['db/horse_riding/views/v_client.sql']
SELECT_EMPLOYEE_QUERY = 'SELECT employee_id FROM public.get_employees_id_by_profession(?)'
SELECT_SERVICE_ID_QUERY = 'SELECT service_id FROM public.service WHERE service_name  = ?'
INSERT_EMPL_SERVICE_LINK_QUERY = 'INSERT INTO public.employee_service_link(employee_service_link_active_from, employee_id, service_id) VALUES(?, ?, ?)'
INSERT_HORSE_QUERY = 'CALL public.add_horse(?, ?, NULL);'
INSERT_HORSE_SERVICE_LINK_QUERY = 'INSERT INTO public.horse_service_link(horse_service_link_active_from, horse_id, service_id) VALUES(?, ?, ?)'
SELECT_EMPL_LINKS_QUERY = 'SELECT employee_service_link_id FROM public.employee_service_link WHERE service_id = ?'
SELECT_HORSE_LINKS_QUERY = 'SELECT horse_service_link_id FROM public.horse_service_link WHERE service_id = ?'
INSERT_SCHEDULE_ROW_QUERY = 'CALL public.add_schedule_row(?, ?, ?, ?)'
SELECT_SERVICES_BY_DAY_QUERY = 'SELECT service_id FROM public.get_service_id_by_schedule_day(?)'
SELECT_SCHEDULE_BY_DAY_SERVICE_QUERY = 'SELECT schedule_id FROM public.get_schedule_id_by_day_and_service(?, ?)'
INSERT_CLIENT_TO_SCHEDULE_QUERY = 'CALL public.add_client_to_schedule(?, ?, ?, ?);'
