-- Use the `ref` function to select from other models

select *
from "ny_taxi"."dbtschema"."my_first_dbt_model"
where id = 1