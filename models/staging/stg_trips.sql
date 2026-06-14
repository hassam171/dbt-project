SELECT
    pulocationid          AS pickup_zone_id,
    dolocationid           AS dropoff_zone_id,
    payment_type           AS payment_type_id,
    tpep_pickup_datetime    AS pickup_datetime,
    tpep_dropoff_datetime   AS dropoff_datetime,
    trip_distance           AS distance_miles,
    passenger_count,
    fare_amount,
    tip_amount,
    tolls_amount,
    total_amount

FROM {{ source('raw', 'raw_trips') }}

WHERE total_amount >= 0
  AND tpep_pickup_datetime IS NOT NULL
  AND tpep_dropoff_datetime IS NOT NULL
  AND tpep_dropoff_datetime >= tpep_pickup_datetime