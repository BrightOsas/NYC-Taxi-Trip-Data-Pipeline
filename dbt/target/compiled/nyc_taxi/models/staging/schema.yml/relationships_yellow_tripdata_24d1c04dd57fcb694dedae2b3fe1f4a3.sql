
    
    

with child as (
    select Pickup_locationid as from_field
    from "ny_taxi"."dbtschema"."yellow_tripdata"
    where Pickup_locationid is not null
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


