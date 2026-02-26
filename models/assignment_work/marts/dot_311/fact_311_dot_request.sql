WITH base AS (
    SELECT *
    FROM {{ ref('stg_nyc_311_dot') }}
),

date_dim AS (
    SELECT *
    FROM {{ ref('dim_date') }}
),

location_dim AS (
    SELECT *
    FROM {{ ref('dim_location') }}
)

SELECT
    b.request_id,
    d.date_key,
    l.location_key,

    b.complaint_type,
    b.descriptor,
    b.status,
    b.agency,
    b.agency_name,
    b.method_of_submission,
    b.created_date,
    b.closed_date,
    b._stg_loaded_at

FROM base b
LEFT JOIN date_dim d
    ON DATE(b.created_date) = d.full_date

LEFT JOIN location_dim l
    ON b.borough = l.borough