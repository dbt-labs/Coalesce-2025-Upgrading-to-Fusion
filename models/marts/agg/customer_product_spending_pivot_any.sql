-- This model uses PIVOT with ANY which causes introspection errors in Fusion
-- Fusion cannot statically analyze dynamic column generation from PIVOT (ANY)
-- This is a common pattern when pivoting on unknown or changing dimension values

{{ config(
    materialized='table',
    tags=['introspection_error', 'pivot_any']
) }}

with customer_product_purchases as (
    select 
        c.customer_id,
        c.customer_name,
        p.product_type as product_category,
        sum(1 * p.product_price) as category_spend  -- Using default quantity of 1
    from {{ ref('stg_customers') }} c
    join {{ ref('stg_orders') }} o on c.customer_id = o.customer_id  
    join {{ ref('stg_order_items') }} oi on o.order_id = oi.order_id
    join {{ ref('stg_products') }} p on oi.product_id = p.product_id
    group by c.customer_id, c.customer_name, p.product_type
),

-- BREAKING: This PIVOT with ANY causes introspection errors in Fusion
-- Fusion cannot determine columns at parse time when using dynamic PIVOT
pivoted_customer_spend as (
    select 
        customer_id,
        customer_name
        -- Note: product_category becomes column names after PIVOT
        -- category_spend values become the pivoted column values
    from customer_product_purchases
    PIVOT (
        sum(category_spend) 
        FOR product_category IN (ANY)  -- PROBLEMATIC: Fusion cannot introspect dynamic columns
    ) as p
)

select 
    -- These columns are dynamically generated and cause introspection issues
    *
from pivoted_customer_spend