

with green_data as (
    select *, 'Green' as service_type
    from "ny_taxi"."dbtschema"."green_tripdata"
 
),
yellow_data as (
    select *, 'Yellow' as service_type
    from "ny_taxi"."dbtschema"."yellow_tripdata"
),
trips_unioned as (
    select * from yellow_data
    union all
    select * from green_data
),
dim_zones as (
    select *
    from "ny_taxi"."dbtschema"."taxi_zone_lookup"
    where "borough" != 'Unknown'
)
select
    trips_unioned.tripid,
    trips_unioned.vendorid,
    trips_unioned.service_type,
    --trips_unioned.ratecodeid,
    trips_unioned.ratecode_description,
    trips_unioned.pulocationid,
    pickup_zone."borough" as pickup_borough,
    pickup_zone."zone" as pickup_zone,
    trips_unioned.dolocationid,
    dropoff_zone."borough" as dropoff_borough,
    dropoff_zone."zone" as dropoff_zone,
    trips_unioned.pickup_datetime,
    trips_unioned.dropoff_datetime,
    trips_unioned.store_and_fwd_flag,
    trips_unioned.passenger_count,
    trips_unioned.trip_distance,
    trips_unioned.fare_amount,
    trips_unioned.extra,
    trips_unioned.mta_tax,
    trips_unioned.tip_amount,
    trips_unioned.tolls_amount,
    trips_unioned.improvement_surcharge,
    trips_unioned.total_amount,
    trips_unioned.payment_type_description,
    trips_unioned.congestion_surcharge
from trips_unioned
inner join dim_zones as pickup_zone
on trips_unioned.pulocationid = pickup_zone.locationid
inner join dim_zones as dropoff_zone
on trips_unioned.dolocationid = dropoff_zone.locationid