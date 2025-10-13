{{
  config(
    materialized='table',
    enable_audit_logging=true,
    audit_table_suffix='_audit_log',
    data_classification='confidential',
    retention_days=180,
    enable_pii_masking=true
  )
}}

{#- 
  This model uses completely custom organizational configs that Fusion doesn't support.
  These are made-up governance/audit configs that would be specific to a company.
  Trainees need to:
  1. Move custom configs (enable_audit_logging, audit_table_suffix, data_classification, etc.) to meta 
  2. Update the custom_audit_settings macro to reference config.get('meta')
-#}

select 
  id,
  user_id,
  order_date,
  status,
  created_at,
  updated_at
from {{ source('jaffle_shop', 'raw_orders') }}

{{ custom_audit_settings() }}