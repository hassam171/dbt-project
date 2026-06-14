SELECT
    location_id,
    borough,
    zone_name,
    service_zone

FROM {{ source('raw', 'zones') }}

WHERE location_id IS NOT NULL