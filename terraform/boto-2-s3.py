import boto3
import pandas as pd
import pyarrow
import pyarrow.parquet as pq
import os

s3 = boto3.client('s3')
parquet_files = [f for f in os.listdir() if f.endswith('.parquet')]

bucket_name = "brighttaxitrips3bucket"

for file_name in parquet_files:
    local_file_path = os.path.join(os.getcwd(), file_name)
    s3_key = f'taxitrip/{file_name}'

    table = pd.read_parquet(local_file_path)

    arrow_table = pyarrow.Table.from_pandas(table)

    pq.write_table(arrow_table, f's3://{bucket_name}/{s3_key}')

