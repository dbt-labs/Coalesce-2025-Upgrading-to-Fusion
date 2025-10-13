{% docs customer_overview %}
This is the customer overview documentation from the models directory.

This doc block describes customer data and related business logic.
It covers customer demographics, segmentation, and key metrics.

**Key Fields:**
- customer_id: Unique identifier for each customer
- customer_type: Whether the customer is new or returning
- lifetime_value: Total value of all customer orders

This documentation is maintained by the data modeling team.
{% enddocs %}

{% docs order_status_definitions %}
Order status field definitions from the models directory.

**Status Values:**
- pending: Order placed but not yet processed
- shipped: Order has been shipped to customer
- delivered: Order successfully delivered
- cancelled: Order was cancelled before shipping
- returned: Order was returned by customer

Updated by the analytics team.
{% enddocs %}