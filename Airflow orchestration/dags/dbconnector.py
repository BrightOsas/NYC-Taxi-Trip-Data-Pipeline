from airflow.providers.postgres.hooks.postgres import PostgresHook

def dbconnectiontest():
    try:
        hook = PostgresHook(postgres_conn_id='postgres_localhost')
        conn = hook.get_conn()
        conn.close()
        print("PostgreSQL connection successful")
    except Exception as e:
        print("PostgreSQL connection failed:", str(e))