Completed with 9 errors, 0 partial successes, and 0 warnings:
04:16:18  
04:16:18  Failure in model stg_orders_with_custom_config (models/staging/jaffle_shop/stg_orders_with_custom_config.sql)
04:16:18    Database Error in model stg_orders_with_custom_config (models/staging/jaffle_shop/stg_orders_with_custom_config.sql)
  000904 (42000): SQL compilation error: error line 7 at position 2
  invalid identifier 'USER_ID'
  compiled code at target/run/jaffle_shop/models/staging/jaffle_shop/stg_orders_with_custom_config.sql
04:16:18  
04:16:18    compiled code at target/compiled/jaffle_shop/models/staging/jaffle_shop/stg_orders_with_custom_config.sql
04:16:18  
04:16:18  Failure in snapshot orders_snapshot (snapshots/orders_snapshot.yml)
04:16:18    Database Error in snapshot orders_snapshot (snapshots/orders_snapshot.yml)
  000904 (42000): SQL compilation error: error line 7 at position 33
  invalid identifier 'ORDER_DATE'
04:16:18  
04:16:18  Failure in model daily_orders_cross_db_legacy (models/marts/orders/daily_orders_cross_db_legacy.sql)
04:16:18    Database Error in model daily_orders_cross_db_legacy (models/marts/orders/daily_orders_cross_db_legacy.sql)
  001003 (42000): SQL compilation error:
  syntax error line 57 at position 9 unexpected ','.
  compiled code at target/run/jaffle_shop/models/marts/orders/daily_orders_cross_db_legacy.sql
04:16:18  
04:16:18    compiled code at target/compiled/jaffle_shop/models/marts/orders/daily_orders_cross_db_legacy.sql
04:16:18  
04:16:18  Failure in model daily_customer_orders_insert_by_period (models/marts/orders/daily_customer_orders_insert_by_period.sql)
04:16:18    Database Error in model daily_customer_orders_insert_by_period (models/marts/orders/daily_customer_orders_insert_by_period.sql)
  002003 (02000): SQL compilation error:
  Schema 'TROUZE_UPGRADING_FUSION."dbt_trouze"' does not exist or not authorized.
  compiled code at target/run/jaffle_shop/models/marts/orders/daily_customer_orders_insert_by_period.sql
04:16:18  
04:16:18    compiled code at target/compiled/jaffle_shop/models/marts/orders/daily_customer_orders_insert_by_period.sql
04:16:18  
04:16:18  Failure in model monthly_payment_analysis_pivot_any (models/marts/agg/monthly_payment_analysis_pivot_any.sql)
04:16:18    Database Error in model monthly_payment_analysis_pivot_any (models/marts/agg/monthly_payment_analysis_pivot_any.sql)
  000904 (42000): SQL compilation error: error line 2 at position 28
  invalid identifier 'O.ORDER_DATE'
  compiled code at target/run/jaffle_shop/models/marts/agg/monthly_payment_analysis_pivot_any.sql
04:16:18  
04:16:18    compiled code at target/compiled/jaffle_shop/models/marts/agg/monthly_payment_analysis_pivot_any.sql
04:16:18  
04:16:18  Failure in model order_line_items_legacy (models/marts/orders/order_line_items_legacy.sql)
04:16:18    Database Error in model order_line_items_legacy (models/marts/orders/order_line_items_legacy.sql)
  001003 (42000): SQL compilation error:
  syntax error line 25 at position 0 unexpected 'with'.
  syntax error line 60 at position 26 unexpected 'oi'.
  compiled code at target/run/jaffle_shop/models/marts/orders/order_line_items_legacy.sql
04:16:18  
04:16:18    compiled code at target/compiled/jaffle_shop/models/marts/orders/order_line_items_legacy.sql
04:16:18  
04:16:18  Failure in model customer_product_spending_pivot_any (models/marts/agg/customer_product_spending_pivot_any.sql)
04:16:18    Database Error in model customer_product_spending_pivot_any (models/marts/agg/customer_product_spending_pivot_any.sql)
  002025 (42S21): SQL compilation error:
  duplicate column name 'CUSTOMER_ID'
  compiled code at target/run/jaffle_shop/models/marts/agg/customer_product_spending_pivot_any.sql
04:16:18  
04:16:18    compiled code at target/compiled/jaffle_shop/models/marts/agg/customer_product_spending_pivot_any.sql
04:16:18  
04:16:18  Failure in model customer_analysis_yaml_errors (models/marts/customer/customer_analysis_yaml_errors.sql)
04:16:18    Database Error in model customer_analysis_yaml_errors (models/marts/customer/customer_analysis_yaml_errors.sql)
  002003 (42S02): SQL compilation error:
  Table 'AUDIT_LOG' does not exist or not authorized.
04:16:18  
04:16:18    compiled code at target/compiled/jaffle_shop/models/marts/customer/customer_analysis_yaml_errors.sql
04:16:18  
04:16:18  Failure in model orders_with_query_comments (models/marts/orders/orders_with_query_comments.sql)
04:16:18    Database Error in model orders_with_query_comments (models/marts/orders/orders_with_query_comments.sql)
  100035 (22007): Timestamp '2025-10-13 04:15:49.556736+00:00' is not recognized
  compiled code at target/run/jaffle_shop/models/marts/orders/orders_with_query_comments.sql
04:16:18  
04:16:18    compiled code at target/compiled/jaffle_shop/models/marts/orders/orders_with_query_comments.sql
04:16:18  
04:16:18  Done. PASS=84 WARN=0 ERROR=9 SKIP=4 NO-OP=5 TOTAL=102