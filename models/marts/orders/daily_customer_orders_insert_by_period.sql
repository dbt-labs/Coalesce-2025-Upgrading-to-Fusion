-- This model attempts to use the deprecated insert_by_period materialization
-- BREAKING: insert_by_period was removed from dbt_utils 1.0.0 and moved to experimental-features repo

{{ config(
    materialized='insert_by_period',  -- BREAKS: No longer available in dbt_utils 1.0.0+
    period='day',
    timestamp_field='order_date',
    start_date='2023-01-01',
    stop_date='2024-12-31',
    tags=['package_breaking_change', 'materialization']
) }}

select
    order_date,
    customer_id,
    count(*) as order_count,
    sum(order_total) as daily_total
from {{ ref('stg_orders') }}

{% if is_incremental() %}
    where order_date >= (select max(order_date) from {{ this }})
{% endif %}

group by order_date, customer_id