-- Fact table: Open Restaurant Applications
-- Grain: one row per record from stg_nyc_open_restaurant_apps

WITH apps AS (
  SELECT *
  FROM {{ ref('stg_nyc_open_restaurant_apps') }}
)

SELECT
  -- Deterministic surrogate key from the whole row (BigQuery-safe)
  CAST(FARM_FINGERPRINT(TO_JSON_STRING(apps)) AS STRING) AS restaurant_application_sk,



  CAST(NULL AS STRING) AS date_key,
  CAST(NULL AS STRING) AS location_key,

  apps.*
FROM apps