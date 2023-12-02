

select 
--renaming both yellow and green trip tables to match
--identifiers
    md5(cast(coalesce(cast(VendorID as 
    varchar
), '') || '-' || coalesce(cast(tpep_pickup_datetime as 
    varchar
), '') as 
    varchar
)) as tripid,
    cast(VendorID as integer) as vendorid,
    cast(RatecodeID as integer) as ratecodeid,
    cast(PULocationID as integer) as pulocationid,
    cast(DOLocationID as integer) as dolocationid,

--timestamps
    cast(tpep_pickup_datetime as timestamp) as pickup_datetime,
    cast(tpep_dropoff_datetime as timestamp) as droppoff_datetime,

--trip info
    cast(passenger_count as integer) as passenger_count,
    cast(trip_distance as numeric) as trip_distance,
    cast(store_and_fwd_flag as ) as store_and_fwd_flag,

--payment info
    cast(payment_type as integer) as payment_type,
    
    case 
        when 1 then 'Credit card'
        when 2 then 'Cash'
        when 3 then 'No charge'
        when 4 then 'Dispute'
        when 5 then 'Unknown'
        when 6 then 'Voided trip'
    end
 as payment_type_description,
    cast(fare_amount as numeric) as fare_amount,
    cast(extra as numeric) as extra,
    cast(mta_tax as numeric) as mta_tax,
    cast(tip_amount as numeric) as tip_amount,
    cast(tolls_amount as numeric) as tolls_amount,
    cast(improvement_surcharge as numeric) as improvement_surcharge,
    cast(total_amount as numeric) as total_amount,
    cast(congestion_surcharge as numeric) as congestion_surcharge,
    cast(Airport_fee as integer) as airport_fee
    


from "pgdatabase"."ny_taxi"."green_tripdata"
where vendorid is not null



    limit 100

