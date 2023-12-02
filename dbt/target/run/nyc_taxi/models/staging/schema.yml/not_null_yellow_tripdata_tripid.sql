select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select tripid
from "ny_taxi"."dbtschema"."yellow_tripdata"
where tripid is null



      
    ) dbt_internal_test