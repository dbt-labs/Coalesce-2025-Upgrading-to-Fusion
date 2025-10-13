-- This model demonstrates another PIVOT (ANY) pattern that breaks Fusion introspection
-- Common use case: pivoting payment methods that may change over time
-- Fusion cannot statically determine the resulting column structure

{{ config(
    materialized='view',
    tags=['introspection_error', 'pivot_any', 'monthly_analysis']
) }}

with monthly_payment_data as (
    select 
        date_trunc('month', o.order_date) as order_month,
        p.payment_method,
        sum(o.order_total) as payment_method_revenue,
        count(*) as transaction_count
    from {{ ref('stg_orders') }} o
    join {{ ref('stg_payments') }} p on o.order_id = p.order_id
    where o.order_date >= '2023-01-01'
    group by 
        date_trunc('month', o.order_date),
        p.payment_method
),

-- BREAKING: Another PIVOT (ANY) that causes Fusion introspection failure
-- This pattern is common when payment methods are added/removed dynamically
monthly_revenue_by_payment_method as (
    select *
    from monthly_payment_data
    PIVOT (
        sum(payment_method_revenue) as revenue,
        sum(transaction_count) as transactions
        FOR payment_method IN (ANY)  -- PROBLEMATIC: Dynamic columns break static analysis
    ) as pivot_table
)

select 
    order_month,
    -- These dynamically generated columns cause introspection errors:
    -- e.g., CREDIT_CARD_REVENUE, DEBIT_CARD_REVENUE, PAYPAL_REVENUE, etc.
    *
from monthly_revenue_by_payment_method
order by order_month