
  
    

  create  table "ny_taxi"."dbtschema"."fact_trips2__dbt_tmp"
  
  
    as
  
  (
    

with green_data as (
    select *, 'Green' as service_type
    from "ny_taxi"."dbtschema"."green_tripdata01"
    union all
    select *, 'Green' as service_type
    from "ny_taxi"."dbtschema"."green_tripdata06"
    union all
    select *, 'Green' as service_type
    from "ny_taxi"."dbtschema"."green_tripdata07"
    union all
    select *, 'Green' as service_type
    from "ny_taxi"."dbtschema"."green_tripdata08"
    union all
    select *, 'Green' as service_type
    from "ny_taxi"."dbtschema"."green_tripdata02"
    union all
    select *, 'Green' as service_type
    from "ny_taxi"."dbtschema"."green_tripdata03"
    union all
    select *, 'Green' as service_type
    from "ny_taxi"."dbtschema"."green_tripdata04"
    union all
    select *, 'Green' as service_type
    from "ny_taxi"."dbtschema"."green_tripdata05"
),
yellow_data as (
    select *, 'Yellow' as service_type
    from "ny_taxi"."dbtschema"."yellow_tripdata01"
    union all
    select *, 'Yellow' as service_type
    from "ny_taxi"."dbtschema"."yellow_tripdata02"
    union all
    select *, 'Yellow' as service_type
    from "ny_taxi"."dbtschema"."yellow_tripdata03"
    union all
    select *, 'Yellow' as service_type
    from "ny_taxi"."dbtschema"."yellow_tripdata04"
    union all
    select *, 'Yellow' as service_type
    from "ny_taxi"."dbtschema"."yellow_tripdata05"
    union all
    select *, 'Yellow' as service_type
    from "ny_taxi"."dbtschema"."yellow_tripdata06"
    union all
    select *, 'Yellow' as service_type
    from "ny_taxi"."dbtschema"."yellow_tripdata07"
    union all
    select *, 'Yellow' as service_type
    from "ny_taxi"."dbtschema"."yellow_tripdata08"
),
trips_unioned as (
    select * from yellow_data
    union all
    select * from green_data
),
dim_zones as (
    select *
    from "ny_taxi"."dbtschema"."taxi+_zone_lookup"
    where "Borough" != 'Unknown'
)
select
    trips_unioned.tripid,
    trips_unioned.vendorid,
    trips_unioned.service_type,
    trips_unioned.ratecodeid,
    trips_unioned.pulocationid,
    pickup_zone."Borough" as pickup_borough,
    pickup_zone."Zone" as pickup_zone,
    trips_unioned.dolocationid,
    dropoff_zone."Borough" as dropoff_borough,
    dropoff_zone."Zone" as dropoff_zone,
    trips_unioned.pickup_datetime,
    trips_unioned.dropoff_datetime,
    trips_unioned.store_and_fwd_flag,
    trips_unioned.passenger_count,
    trips_unioned.trip_distance,
    trips_unioned.trip_type,
    trips_unioned.fare_amount,
    trips_unioned.extra,
    trips_unioned.mta_tax,
    trips_unioned.tip_amount,
    trips_unioned.tolls_amount,
    trips_unioned.ehail_fee,
    trips_unioned.improvement_surcharge,
    trips_unioned.total_amount,
    trips_unioned.payment_type,
    trips_unioned.payment_type_description,
    trips_unioned.congestion_surcharge
from trips_unioned
inner join dim_zones as pickup_zone
on trips_unioned.pulocationid = pickup_zone."LocationID"
inner join dim_zones as dropoff_zone
on trips_unioned.dolocationid = dropoff_zone."LocationID"
  );
  