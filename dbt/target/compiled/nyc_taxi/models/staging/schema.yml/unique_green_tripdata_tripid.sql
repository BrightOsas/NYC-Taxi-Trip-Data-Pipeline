
    
    

select
    tripid as unique_field,
    count(*) as n_records

from "ny_taxi"."dbtschema"."green_tripdata"
where tripid is not null
group by tripid
having count(*) > 1


