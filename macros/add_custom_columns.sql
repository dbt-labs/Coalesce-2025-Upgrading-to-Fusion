{% macro add_custom_columns() %}
  {#- 
    This macro demonstrates custom config usage that will fail in Fusion.
    It adds computed columns based on custom organizational configs.
    Trainees need to move custom configs to meta and update this macro.
  -#}
  
  {#- These config.get() calls will return None in Fusion since custom configs must be under 'meta' -#}
  {% set add_row_number = config.get('add_row_number') %}
  {% set add_hash_key = config.get('add_hash_key') %}
  {% set business_unit = config.get('business_unit') %}
  {% set enable_audit_fields = config.get('enable_audit_fields') %}
  
  {#- Force errors when configs are None (missing in Fusion) -#}
  {% if add_row_number == none %}
    {{ log("ERROR: add_row_number config is None - custom configs must be under 'meta' in Fusion", info=true) }}
  {% endif %}
  
  {#- This will cause a compilation error when business_unit is None -#}
  {% set business_unit_upper = business_unit.upper() %}
  
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