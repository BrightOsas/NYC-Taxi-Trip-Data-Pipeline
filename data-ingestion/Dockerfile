FROM python:3.9

WORKDIR /app
RUN pip install pandas sqlalchemy psycopg2 pyarrow
COPY green_tripdata_2023-01.parquet green_tripdata_2023-01.parquet
COPY ingestion.py ingestion.py

ENTRYPOINT [ "python", "ingestion.py" ]