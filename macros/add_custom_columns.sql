{% macro add_custom_columns() %}
  {#- 
    This macro demonstrates custom config usage that will fail in Fusion.
    It adds computed columns based on custom organizational configs.
    Trainees need to move custom configs to meta and update this macro.
  -#}
  
  {#- Access custom configs from meta block, with null-safe handling -#}
  {% set meta_config = config.get('meta', {}) %}
  {% set add_row_number = meta_config.get('add_row_number', false) if meta_config else false %}
  {% set add_hash_key = meta_config.get('add_hash_key', false) if meta_config else false %}
  {% set business_unit = meta_config.get('business_unit') if meta_config else none %}
  {% set enable_audit_fields = meta_config.get('enable_audit_fields', false) if meta_config else false %}
  
  {#- Safely handle business_unit upper case conversion -#}
  {% set business_unit_upper = business_unit.upper() if business_unit else none %}
  
  {#- Generate additional computed columns based on config -#}
  {% if add_row_number %}
    , row_number() over (order by id) as row_num
  {% endif %}
  
  {% if add_hash_key %}
    , md5(cast(id as string) || cast(customer as string)) as record_hash
  {% endif %}
  
  {% if business_unit %}
    , '{{ business_unit_upper }}' as business_unit
  {% endif %}
  
  {% if enable_audit_fields %}
    , current_timestamp() as processed_at
    , current_user() as processed_by
  {% endif %}
  
{% endmacro %}