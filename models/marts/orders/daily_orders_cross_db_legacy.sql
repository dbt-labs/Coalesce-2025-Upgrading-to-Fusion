-- This model demonstrates cross-db macros that moved from dbt_utils to dbt namespace
-- These will BREAK when upgrading from dbt_utils 0.9.6 to 1.0.0+

{{ config(
    materialized='table',
    tags=['package_breaking_change', 'cross_db_macros']
) }}

with daily_orders as (
    select 
        order_date,
        count(*) as order_count,
        sum(order_total) as daily_revenue
    from {{ ref('stg_orders') }}
    group by order_date
),

enriched as (
    select
        order_date,
        order_count,
        daily_revenue,
        
        -- BREAKING: These cross-db macros moved from dbt_utils to dbt namespace
        {{ dbt_utils.dateadd('day', 1, 'order_date') }} as next_day,
        {{ dbt_utils.datediff('order_date', dbt_utils.current_timestamp(), 'day') }} as days_ago,
        
        -- BREAKING: type_string moved to dbt namespace
        {{ dbt_utils.type_string() }} as string_type,
        
        -- BREAKING: safe_cast moved to dbt namespace  
        {{ dbt_utils.safe_cast("order_count", dbt_utils.type_string()) }} as order_count_str,
        
        -- BREAKING: split_part moved to dbt namespace
        {{ dbt_utils.split_part('order_date', '-', 1) }} as order_year
        
    from daily_orders
)

select * from enriched