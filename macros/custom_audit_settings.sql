{% macro custom_audit_settings() %}
  {#- 
    This macro demonstrates custom config usage that will fail in Fusion.
    These are completely custom organizational configs that Fusion doesn't support.
    Trainees need to move custom configs to meta and update this macro.
  -#}
  
  {% set enable_audit_logging = config.get('enable_audit_logging', false) %}
  {% set audit_table_suffix = config.get('audit_table_suffix', '_audit') %}
  {% set data_classification = config.get('data_classification', 'internal') %}
  {% set retention_days = config.get('retention_days', 365) %}
  {% set enable_pii_masking = config.get('enable_pii_masking', false) %}
  
  {% if enable_audit_logging %}
    {#- Create audit table logic -#}
    create or replace table {{ this }}{{ audit_table_suffix }} as (
      select 
        *,
        current_timestamp() as audit_created_at,
        current_user() as audit_created_by,
        '{{ data_classification }}' as data_classification
      from {{ this }}
    );
  {% endif %}
  
  {% if data_classification == 'confidential' %}
    {#- Apply row access policy for confidential data -#}
    alter table {{ this }} add row access policy confidential_data_policy on (user_id);
  {% endif %}
  
  {% if enable_pii_masking %}
    {#- Apply masking policy to PII columns -#}
    alter table {{ this }} modify column first_name set masking policy pii_mask;
    alter table {{ this }} modify column last_name set masking policy pii_mask;
  {% endif %}
  
  {% if retention_days < 365 %}
    {#- Set up data retention policy -#}
    alter table {{ this }} set data_retention_time_in_days = {{ retention_days }};
  {% endif %}
  
{% endmacro %}