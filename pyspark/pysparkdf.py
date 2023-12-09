import pyspark
from pyspark.sql import SparkSession
from pyspark.sql import functions as F

def pysparkdata():
    spark = SparkSession.builder \
        .config("spark.executor.memory", "4g") \
        .config("spark.jars", "postgresql-42.6.0.jar") \
        .appName("PySpark_Postgres") \
        .master("local[*]") \
        .getOrCreate()

    url = "jdbc:postgresql://host.docker.internal:5432/ny_taxi"

    properties = {
        "user": "root",
        "password": "root",
        "driver": "org.postgresql.Driver",
    }

    table_name = "dbtschema.fact_trips"

    df = spark.read.jdbc(url, table_name, properties=properties)

    df2 = df.withColumn('year', F.year('pickup_datetime')) \
        .withColumn('month', F.date_format('pickup_datetime', 'MMMM')) \
        .withColumn('dow', F.date_format('pickup_datetime', 'EEEE'))

    col_to_fill = ['service_type', 'ratecode_description', 'payment_type_description', 'store_and_fwd_flag']

    for col_name in col_to_fill:
        df = df.na.fill('Unknown', [col_name])

    df = df.withColumn('vendorid', F.when(F.col('vendorid') == 1, 'cm_tech').otherwise('verifone'))

    df3 = df2.groupBy('year', 'month', 'dow', F.col('vendorid').alias('vendor'), 'service_type',
                      F.col('ratecode_description').alias('rate'), F.col('pickup_borough').alias('borough'),
                      F.col('pickup_zone').alias('zone'), F.col('payment_type_description').alias('payment_type'),
                      'store_and_fwd_flag').agg(
                      F.count('tripid').alias('trip_count'), F.sum('passenger_count').alias('passenger_count'),
                      F.sum('trip_distance').alias('trip_distance'), F.sum('fare_amount').alias('fare_amount'),
                      F.sum('extra').alias('extra'), F.sum('mta_tax').alias('mta_tax'), F.sum('tip_amount').alias('tip_amount'),
                      F.sum('tolls_amount').alias('tolls_amount'), F.sum('improvement_surcharge').alias('improvement_surcharge'),
                      F.sum('congestion_surcharge').alias('congestion_surcharge'), F.sum('total_amount').alias('revenue'))

    df3.write \
        .jdbc(url=url, table="DBdata", mode="append", properties=properties)

    df.coalesce(19).write.parquet('result', mode='overwrite')

    spark.stop()
