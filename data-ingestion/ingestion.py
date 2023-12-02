import pandas as pd
from sqlalchemy import create_engine
import psycopg2
from time import time
import argparse


def main(params):
    pg_user=params.user
    pg_password=params.password
    pg_host=params.host
    pg_port=params.port
    pg_db=params.db
    pg_table=params.table
    csv_path=params.csv_path


    engine = create_engine(f"postgresql://{pg_user}:{pg_password}@{pg_host}:{pg_port}/{pg_db}")
    con = engine.connect()
    gtrip = pd.read_parquet(csv_path)
    print("Data imported")
    
    t_start = time()
    gtrip.head(0).to_sql(con = con, name= pg_table, if_exists= "replace")
    gtrip.to_sql(con = con, name= pg_table, if_exists= "append")

    end_time = time()
    print("Time used: {:.2f} seconds".format(end_time - t_start))
    print("Data ingested successfully")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description = "Ingesting data into pgdatabase")
    parser.add_argument("--user", help="Database user")
    parser.add_argument("--password", help="Database password")
    parser.add_argument("--host", help="Database host")
    parser.add_argument("--port", help="Database port")
    parser.add_argument("--db", help="Database name")
    parser.add_argument("--table", help="Database table")
    parser.add_argument("--csv_path", help="Database CSV Path")
    
    params=parser.parse_args()
    main(params)