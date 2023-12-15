import os
from airflow import DAG
from datetime import datetime, timedelta
from airflow.operators.bash_operator import BashOperator
from airflow.operators.python_operator import PythonOperator
from airflow.providers.postgres.operators.postgres import PostgresOperator
from airflow.providers.postgres.hooks.postgres import PostgresHook



from yellowtrip import ytrip_data_load
from greentrip import gtrip_data_load
from dbconnector import dbconnectiontest


default_args = {
    "owner": 'bright',
    "retries": 1,
}

AIRFLOW_HOME = os.environ.get("AIRFLOW_HOME", "/opt/airflow/")

PG_HOST = os.getenv('PG_HOST')
PG_USER = os.getenv('PG_USER')
PG_PASSWORD = os.getenv('PG_PASSWORD')
PG_PORT = int(os.getenv('PG_PORT'))
PG_DATABASE = os.getenv('PG_DATABASE')


URL_PREFIX = "https://d37ci6vzurychx.cloudfront.net/trip-data"
Y_URL_TEMPLATE = URL_PREFIX + "/yellow_tripdata_{{execution_date.strftime('%Y-%m')}}.parquet"
Y_OUTPUT_TEMPLATE = AIRFLOW_HOME + r"/output_{{execution_date.strftime('%Y-%m')}}.parquet"
Y_TABLE_NAME = "yellow_taxi_{{execution_date.strftime('%Y-%m')}}.parquet"


URL_PREFIX = "https://d37ci6vzurychx.cloudfront.net/trip-data"
G_URL_TEMPLATE = URL_PREFIX + "/green_tripdata_{{execution_date.strftime('%Y-%m')}}.parquet"
G_OUTPUT_TEMPLATE = AIRFLOW_HOME + r"/output_{{execution_date.strftime('%Y-%m')}}.parquet"
G_TABLE_NAME = "green_taxi_{{execution_date.strftime('%Y-%m')}}.parquet"




with DAG(
    dag_id = 'ingestingnyctripdata',
    default_args=default_args,
    description = 'ingesting yellow and green trip data into postgresql',
    start_date=datetime(2023, 1, 1),
    schedule_interval='0 6 2 * *',

)as dag:
    connection2db = PythonOperator(
        task_id="test_db_connection",
        python_callable=dbconnectiontest,
    )

    downloadydata = BashOperator(
        task_id='downloading_yellow_data',
        bash_command = f'curl -sSL {Y_URL_TEMPLATE} > {Y_OUTPUT_TEMPLATE}'
    )

    downloadgdata = BashOperator(
        task_id='downloading_green_data',
        bash_command = f'curl -sSL {G_URL_TEMPLATE} > {G_OUTPUT_TEMPLATE}'
    )

    importydata= PythonOperator(
        task_id = "importingyellowdata",
        python_callable = ytrip_data_load,
        op_kwargs=dict(
            pg_user=PG_USER,
            pg_password=PG_PASSWORD,
            pg_host=PG_HOST,
            pg_db=PG_DATABASE,
            pg_table=Y_TABLE_NAME,
            ytripfile=Y_OUTPUT_TEMPLATE,
            pg_port=PG_PORT

        )
    )

    importgdata= PythonOperator(
        task_id = "importinggreendata",
        python_callable = gtrip_data_load,
        op_kwargs=dict(
            pg_user=PG_USER,
            pg_password=PG_PASSWORD,
            pg_host=PG_HOST,
            pg_db=PG_DATABASE,
            pg_table=G_TABLE_NAME,
            gtripfile=G_OUTPUT_TEMPLATE,
            pg_port=PG_PORT

        )
    )

    


    connection2db >> downloadydata >> importydata >> downloadgdata >>  importgdata 
