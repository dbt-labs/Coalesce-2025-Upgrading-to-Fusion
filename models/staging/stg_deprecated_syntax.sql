{{
  config(
    materialized='view',
    description='Model using deprecated dbt syntax patterns'
  )
}}

-- This model contains multiple deprecated syntax patterns that need remediation

WITH deprecated_patterns AS (
  SELECT 
    id as customer_id,
    name as customer_name,
    SPLIT_PART(name, ' ', 1) as first_name,
    SPLIT_PART(name, ' ', 2) as last_name,
    LOWER(REPLACE(name, ' ', '.')) || '@example.com' as email,
    
    -- DEPRECATED: Using adapter_macro instead of adapter.dispatch
    -- Example: adapter_macro('dbt', 'current_timestamp') would fail compilation
    CURRENT_TIMESTAMP as created_at_old_syntax,
    
    -- DEPRECATED: Old ref syntax without quotes (will cause warnings)
    -- Should be {{ ref('raw_customers') }}
    'raw_customers' as table_reference_old,
    
    -- DEPRECATED: Using schema.split instead of schema | as_text
    -- {{ schema.split('_')[0] }} -- This would fail compilation
    '{{ this.schema }}' as schema_part_old,
    
    -- DEPRECATED: Old target.name syntax in conditionals
    {% if target.name == 'prod' %}
      'production' 
    {% else %}
      'development'
    {% endif %} as environment_old_check,
    
    -- DEPRECATED: Using run_started_at without proper quoting
    '{{ run_started_at }}' as run_time_old_format
    
  FROM {{ ref('raw_customers') }}
),

more_deprecated_syntax AS (
  SELECT 
    *,
    
    -- DEPRECATED: Old adapter.quote syntax
    -- {{ adapter.quote('customer_id') }} -- Commented out to prevent compilation issues
    'quoted_column_placeholder' as quoted_column_old,
    
    -- DEPRECATED: Using this.database instead of this.database
    '{{ this.database }}' as database_reference_old,
    
    -- DEPRECATED: Old var syntax without default
    '{{ var("some_var", "default_value") }}' as variable_old_syntax,  -- Fixed with default
    
    -- DEPRECATED: Using modules.datetime directly without proper handling
    '{{ modules.datetime.datetime.now() }}' as timestamp_old_syntax,
    
    -- DEPRECATED: Old test syntax (should be using generic tests)
    -- This would be in a separate test file, but showing the pattern here
    -- not_null columns should be defined in YAML, not inline
    
    -- DEPRECATED: Using graph without proper checks
    {% if graph %}
      '{{ graph.nodes | length }}'
    {% else %}
      '0'
    {% endif %} as graph_usage_old
    
  FROM deprecated_patterns
),

column_name_issues AS (
  SELECT 
    customer_id,
    first_name,
    last_name,
    email,
    
    -- DEPRECATED: Column names with spaces (if enabled in flags)
    first_name + ' ' + last_name as "Full Name With Spaces",  -- Will trigger warning
    
    -- DEPRECATED: Reserved keyword usage without proper quoting
    'order' as order_keyword,  -- Should be quoted in most dialects
    
    created_at_old_syntax,
    environment_old_check,
    
    -- DEPRECATED: Using hardcoded schema names
    'raw_data.customers' as hardcoded_schema_reference
    
  FROM more_deprecated_syntax
),

macro_argument_issues AS (
  SELECT 
    *,
    
    -- DEPRECATED: Macro calls without proper argument handling
    -- Commented out to prevent compilation issues: dbt_utils.generate_surrogate_key(['customer_id'])
    'surrogate_key_placeholder' as surrogate_key_old,
    
    -- DEPRECATED: Using undefined macro arguments
    -- Example: some_undefined_macro(bad_arg=true) would fail compilation
    'undefined_macro_result' as undefined_macro_call,
    
    -- DEPRECATED: Old pivot syntax (fully documented only)
    -- Would use: dbt_utils.pivot(column='some_column', values=['a', 'b', 'c'])
    'documented_pivot_pattern' as old_pivot_syntax
    
  FROM column_name_issues
)

-- DEPRECATED: Using SELECT * in final model (bad practice that may trigger warnings)
SELECT * 
FROM macro_argument_issues

-- DEPRECATED: Missing model-level configurations that should be explicit
-- Should have explicit materialization, description, etc. in config
