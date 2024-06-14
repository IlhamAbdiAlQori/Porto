python -m venv C:\Users\RnD\dbt
C:\Users\RnD\dbt\Scripts\activate
git clone https://github.com/graphql-compose/graphql-compose-examples.git
cd graphql-compose-examples/examples/northwind/data
xcopy csv C:\Users\RnD\dbt\source /E /I
cd C:\Users\RnD\dbt
docker run --name postgres-container -e POSTGRES_PASSWORD=ilhamganteng -d -p 5432:5432 postgres
docker exec -it postgres-container psql -U postgres
CREATE DATABASE project2_dbt;
pip install dbt
pip install dbt-core
pip install dbt-postgres
pip install pandas sqlalchemy psycopg2
python data.py
dbt debug --profiles-dir C:\Users\RnD\dbt\project2_dbt_dskola --project-dir C:\Users\RnD\dbt\project2_dbt_dskola
dbt docs generate --profiles-dir C:\Users\RnD\dbt\project2_dbt_dskola --project-dir C:\Users\RnD\dbt\project2_dbt_dskola