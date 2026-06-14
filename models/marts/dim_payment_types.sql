SELECT
    payment_type_id,
    payment_description,

    -- Group into broader payment method category
    CASE 
        WHEN payment_description ILIKE '%credit%' 
             OR payment_description ILIKE '%digital%'
        THEN 'Digital'
        WHEN payment_description ILIKE '%cash%'
        THEN 'Cash'
        ELSE 'Other'
    END AS payment_method_group

FROM {{ ref('stg_payment_types') }}