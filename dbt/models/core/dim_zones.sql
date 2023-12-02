{{ config(materialized = 'table') }}

select
    "locationid" as locationid,
    "borough" as borough,
    "zone" as zone,
    replace("service_zone", 'Boro','Green') as service_zone

from {{ ref('taxi_zone_lookup') }}