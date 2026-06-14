SELECT
    location_id        AS zone_id,
    borough,
    zone_name,
    service_zone,

    -- Flag airport zones
    CASE 
        WHEN zone_name ILIKE '%airport%' THEN TRUE
        ELSE FALSE
    END AS is_airport

FROM {{ ref('stg_zones') }}