{{
  config(
    materialized='view',
    description='Model with deprecated test patterns and syntax'
  )
}}

-- This model demonstrates various deprecated testing patterns

WITH base_data AS (
  SELECT 
    id as customer_id,
    name as customer_name,
    SPLIT_PART(name, ' ', 1) as first_name,
    SPLIT_PART(name, ' ', 2) as last_name,
    LOWER(REPLACE(name, ' ', '.')) || '@example.com' as email,
    
    -- DEPRECATED: Inline data quality checks that should be proper tests
    CASE 
      WHEN email IS NULL THEN 'FAIL'
      WHEN email NOT LIKE '%@%' THEN 'FAIL'  
      ELSE 'PASS'
    END as email_quality_check,  -- Should use proper dbt tests
    
    -- order_total,  -- Not available in customer data
    customer_id as created_date,  -- Placeholder for date field
    
    -- DEPRECATED: Business logic validation in model instead of tests
    CASE 
      WHEN customer_id IS NULL THEN 'INVALID_NEGATIVE'  -- Placeholder logic
      WHEN LENGTH(customer_name) > 100 THEN 'INVALID_TOO_HIGH'
      ELSE 'VALID'
    END as order_validation,  -- Should be a separate test
    
    -- DEPRECATED: Hardcoded test logic that should be configurable
    CASE 
      WHEN created_date > CURRENT_DATE THEN 'FUTURE_DATE_ERROR'
      WHEN created_date < '2020-01-01' THEN 'TOO_OLD_ERROR'
      ELSE 'DATE_OK'
    END as date_validation
    
  FROM {{ ref('raw_customers') }}
),

deprecated_aggregations AS (
  SELECT 
    *,
    
    -- DEPRECATED: Counting nulls manually instead of using tests
    COUNT(*) OVER () as total_records,
    COUNT(email) OVER () as non_null_emails,
    COUNT(*) OVER () - COUNT(email) OVER () as null_email_count,  -- Should be not_null test
    
    -- DEPRECATED: Manual uniqueness checks instead of unique tests
    COUNT(*) OVER (PARTITION BY customer_id) as customer_id_duplicates,  -- Should be unique test
    COUNT(*) OVER (PARTITION BY email) as email_duplicates,  -- Should be unique test
    
    -- DEPRECATED: Manual relationship validation instead of relationship tests
    CASE 
      WHEN customer_id IN (SELECT customer_id FROM {{ ref('orders') }}) THEN 'HAS_ORDERS'
      ELSE 'NO_ORDERS'
    END as relationship_check  -- Should be relationships test
    
  FROM base_data
),

-- DEPRECATED: Data profiling in model instead of using dbt artifacts
data_profiling AS (
  SELECT 
    'customer_id' as column_name,
    COUNT(*) as row_count,
    COUNT(DISTINCT customer_id) as distinct_count,
    COUNT(customer_id) as non_null_count,
    MIN(customer_id) as min_value,
    MAX(customer_id) as max_value
  FROM deprecated_aggregations
  
  UNION ALL
  
  SELECT 
    'customer_name' as column_name,
    COUNT(*) as row_count,
    COUNT(DISTINCT customer_name) as distinct_count,
    COUNT(customer_name) as non_null_count,
    MIN(customer_name) as min_value,
    MAX(customer_name) as max_value
  FROM deprecated_aggregations
  
  UNION ALL
  
  SELECT 
    'email' as column_name,
    COUNT(*) as row_count,
    COUNT(DISTINCT email) as distinct_count,
    COUNT(email) as non_null_count,
    MIN(email) as min_value,  -- Nonsensical for strings, but shows pattern
    MAX(email) as max_value
  FROM deprecated_aggregations
)

-- Final selection with deprecated validation patterns
SELECT 
  customer_id,
  first_name,
  last_name,
  email,
  customer_name,
  created_date,
  
  -- DEPRECATED: Quality scores in model instead of test results
  email_quality_check,
  order_validation,
  date_validation,
  
  -- DEPRECATED: Test results as columns
  CASE WHEN customer_id_duplicates > 1 THEN 'DUPLICATE' ELSE 'UNIQUE' END as uniqueness_status,
  CASE WHEN null_email_count > 0 THEN 'HAS_NULLS' ELSE 'NO_NULLS' END as completeness_status,
  
  -- DEPRECATED: Manual data lineage tracking
  'raw_data.customers' as source_table,
  '{{ this }}' as current_model,
  '{{ run_started_at }}' as processed_at
  
FROM deprecated_aggregations
WHERE 
  -- DEPRECATED: Data filtering based on quality checks in model
  email_quality_check = 'PASS'
  AND order_validation = 'VALID'
  AND date_validation = 'DATE_OK'
