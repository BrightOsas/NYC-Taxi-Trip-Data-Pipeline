

with tripdata as 
(
  select *,
    row_number() over(partition by vendorid, tpep_pickup_datetime) as rn
  from "ny_taxi"."public"."yellow_tripdata"
  where vendorid is not null 
)

select 
--renaming both yellow and green trip tables to match
--identifiers
    md5(cast(coalesce(cast(vendorid as 
    varchar
), '') || '-' || coalesce(cast(tpep_pickup_datetime as 
    varchar
), '') as 
    varchar
)) as tripid,
    cast("vendorid" as integer) as vendorid,
    cast("ratecodeid" as integer) as ratecodeid,
    
    case ratecodeid
        when 1 then 'Standard rate'
        when 2 then 'JFK'
        when 3 then 'Newark'
        when 4 then 'Nassau or Westchester'
        when 5 then 'Negotiated fare'
        when 6 then 'Group ride'
    end
 as ratecode_description, 
    cast("pulocationid" as integer) as pulocationid,
    cast("dolocationid" as integer) as dolocationid,

--timestamps
    cast("tpep_pickup_datetime" as timestamp) as pickup_datetime,
    cast("tpep_dropoff_datetime" as timestamp) as dropoff_datetime,

--trip info
    cast("passenger_count" as integer) as passenger_count,
    cast("trip_distance" as numeric) as trip_distance,
    store_and_fwd_flag,

--payment info
    cast("payment_type" as integer) as payment_type,
    
    case payment_type
        when 1 then 'Credit card'
        when 2 then 'Cash'
        when 3 then 'No charge'
        when 4 then 'Dispute'
        when 5 then 'Unknown'
        when 6 then 'Voided trip'
    end
 as payment_type_description,
    cast("fare_amount" as numeric) as fare_amount,
    cast("extra" as numeric) as extra,
    cast("mta_tax" as numeric) as mta_tax,
    cast("tip_amount" as numeric) as tip_amount,
    cast("tolls_amount" as numeric) as tolls_amount,
    cast("improvement_surcharge" as numeric) as improvement_surcharge,
    cast("total_amount" as numeric) as total_amount,
    cast("congestion_surcharge" as numeric) as congestion_surcharge
    
from tripdata
where rn = 1

