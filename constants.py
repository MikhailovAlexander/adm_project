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
                     'db/horse_keeping/functions/get_client_debt.sql']
KEEPING_PROCEDURES = ['db/horse_keeping/procedures/add_client.sql',
                      'db/horse_keeping/procedures/add_contract.sql',
                      'db/horse_keeping/procedures/add_employee.sql',
                      'db/horse_keeping/procedures/add_invoice.sql',
                      'db/horse_keeping/procedures/add_payment.sql',
                      'db/horse_keeping/procedures/add_service_to_contract.sql',
                      'db/horse_keeping/procedures/distribute_payment.sql']
