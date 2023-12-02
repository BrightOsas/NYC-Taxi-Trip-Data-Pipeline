import pandas as pd
from sqlalchemy import create_engine
from multiprocessing import Pool
import time
import logging



def gtrip_data_load(**kwargs):
    pg_user = kwargs['pg_user']
    pg_password = kwargs['pg_password']
    pg_host = kwargs['pg_host']
    pg_db = kwargs['pg_db']
    pg_table = kwargs['pg_table']
    gtripfile = kwargs['gtripfile']
    pg_port = kwargs['pg_port']

    engine = create_engine(f"postgresql://{pg_user}:{pg_password}@{pg_host}:{pg_port}/{pg_db}")
    con = engine.connect()

    gtrip = pd.read_parquet(gtripfile)
    logging.info(f" {gtripfile} imported")

    gtrip.columns = map(str.lower, gtrip.columns)

    batch_size = 100000
    data_batches = [gtrip[i:i + batch_size] for i in range(0, len(gtrip), batch_size)]   
    start_time = time.time()
    try:
        for chunk in data_batches:
            chunk.to_sql(con=con, name=pg_table, if_exists='replace', index=False)
            logging.info(f"Added {len(chunk)} rows to the database.")
    except Exception as e:
        kwargs['ti'].xcom_push(key='error_message', value=str(e))
        raise e  
    end_time = time.time()
    kwargs['ti'].xcom_push(key='import_duration', value=end_time - start_time)
