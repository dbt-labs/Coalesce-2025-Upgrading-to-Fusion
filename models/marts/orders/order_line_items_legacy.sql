-- This model demonstrates breaking changes from dbt_utils 0.9.6 → 1.0.0+
-- Uses deprecated surrogate_key() function that was replaced by generate_surrogate_key()

{{ config(
    materialized='table',
    tags=['package_breaking_change']
) }}

with order_items as (
    select * from {{ ref('stg_order_items') }}
),

orders as (
    select * from {{ ref('stg_orders') }}
),

products as (
    select * from {{ ref('stg_products') }}
),

joined as (
    select
        -- This will BREAK when upgrading dbt_utils - surrogate_key() was replaced
        {{ dbt_utils.surrogate_key(['oi.order_id', 'oi.product_id']) }} as order_item_key,
        
        oi.order_id,
        oi.product_id,
        oi.quantity,
        
        o.customer_id,
        o.order_date,
        
        p.name as product_name,
        p.price as unit_price,
        
        -- This will also BREAK - current_timestamp() moved to dbt namespace
        {{ dbt_utils.current_timestamp() }} as processed_at,
        
        oi.quantity * p.price as line_total
        
    from order_items oi
    left join orders o on oi.order_id = o.order_id
    left join products p on oi.product_id = p.product_id
)

select * from joined