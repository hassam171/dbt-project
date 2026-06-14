SELECT
    payment_type_id,
    payment_description

FROM {{ source('raw', 'payment_types') }}

WHERE payment_type_id IS NOT NULL