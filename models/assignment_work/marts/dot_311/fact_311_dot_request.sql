-- Fact table: 311 DOT Requests
-- Grain: one row per request_id
-- This model references dimension tables so the DAG shows: staging -> dims -> fact

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

  -- Join keys from dimensions
  d.date_key,
  l.location_key,

  -- Core attributes
  b.created_date,
  b.closed_date,
  b.status,
  b.agency,
  b.agency_name,
  b.complaint_type,
  b.descriptor,
  b.method_of_submission,
  b._stg_loaded_at

FROM base b
LEFT JOIN date_dim d
  ON DATE(b.created_date) = d.full_date
LEFT JOIN location_dim l
  ON b.borough = l.borough
 AND ( (b.incident_zip IS NULL AND l.incident_zip IS NULL) OR b.incident_zip = l.incident_zip )