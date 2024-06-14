import pandas as pd
from sqlalchemy import create_engine
import os

#koneksi
DATABASE_TYPE = 'postgresql'
DBAPI = 'psycopg2'
ENDPOINT = '172.27.159.86'
USER = 'postgres'
PASSWORD = 'ilhamganteng'
PORT = 5432
DATABASE = 'project2_dbt'

# jika beda direktori
source_folder = os.path.join(os.path.dirname(__file__), '..','source')

# url koneksi
DATABASE_URL = f"{DATABASE_TYPE}+{DBAPI}://{USER}:{PASSWORD}@{ENDPOINT}:{PORT}/{DATABASE}"

# engine SQLAlchemy
engine = create_engine(DATABASE_URL)

# nama file dan table nya
csv_files = {
    os.path.join(source_folder, 'categories.csv'): 'categories',
    os.path.join(source_folder, 'customers.csv'): 'customers',
    os.path.join(source_folder, 'employee_territories.csv'): 'employee_territories',
    os.path.join(source_folder, 'employees.csv'): 'employees',
    os.path.join(source_folder, 'orders.csv'): 'orders',
    os.path.join(source_folder, 'order_details.csv'): 'order_details',
    os.path.join(source_folder, 'products.csv'): 'products',
    os.path.join(source_folder, 'regions.csv'): 'regions',
    os.path.join(source_folder, 'shippers.csv'): 'shippers',
    os.path.join(source_folder, 'suppliers.csv'): 'suppliers',
    os.path.join(source_folder, 'territories.csv'): 'territories'
}

# Function untuk import
def import_csv_to_postgres(file_path, table_name):
    df = pd.read_csv(file_path)
    df.to_sql(table_name, engine, if_exists='replace', index=False)
    print(f"Data from {file_path} has been imported to table {table_name}")

# Import semua file CSV
for file_path, table_name in csv_files.items():
    import_csv_to_postgres(file_path, table_name)
