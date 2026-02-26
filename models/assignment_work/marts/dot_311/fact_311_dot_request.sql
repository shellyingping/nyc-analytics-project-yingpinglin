-- Fact table: one row per 311 DOT request

WITH base AS (
    SELECT *
    FROM {{ ref('stg_nyc_311_dot') }}
),

with_keys AS (
    SELECT
        request_id,

        -- Date key
        FORMAT_DATE('%Y%m%d', DATE(created_date)) AS date_key,

        -- Location key (
        TO_HEX(MD5(CONCAT(COALESCE(borough, ''), '|', COALESCE(incident_zip, '')))) AS location_key,

        complaint_type,
        descriptor,
        status,
        agency,
        agency_name,
        method_of_submission,
        created_date,
        closed_date,
        _stg_loaded_at

    FROM base
)

SELECT *
FROM with_keys