
    
    

with child as (
    select dropoff_locationid as from_field
    from "ny_taxi"."dbtschema"."green_tripdata"
    where dropoff_locationid is not null
),

parent as (
    select locationid as to_field
    from "ny_taxi"."dbtschema"."taxi_zone_lookup"
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null


