import os
import datetime
from mimesis.enums import Gender

__host = os.environ['PGHOST']
__db = os.environ['POSTGRES_DB']
__user = os.environ['POSTGRES_USER']
__pwd = os.environ['POSTGRES_PASSWORD']
KEEPING_CONN_STRING = f'Driver={{PostgreSQL Unicode}};Server={__host};' \
                      f'Port=5432;Database={__db};Uid={__user};Pwd={__pwd};'
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
YEAR = datetime.datetime.now().year
START_DATE = datetime.date(YEAR, 1, 1)
GENDER_DICT = {1: Gender.MALE, 2: Gender.FEMALE}
SELECT_PROFS_QUERY = 'SELECT profession_id FROM public.profession'
INSERT_EMPLOYEE_QUERY = 'CALL public.add_employee(?, ?, ?, ?, ?, ?, ?, NULL);'
INSERT_CLIENT_QUERY = 'CALL public.add_client(?, ?, ?, ?, ?, NULL);'
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
