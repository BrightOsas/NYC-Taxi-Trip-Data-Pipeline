

select
    "locationid" as locationid,
    "borough" as borough,
    "zone" as zone,
    replace("service_zone", 'Boro','Green') as service_zone

from "ny_taxi"."dbtschema"."taxi_zone_lookup"