{% docs customer_overview %}
This is the customer overview documentation from the docs directory.

This documentation provides a comprehensive business overview of customer data,
including acquisition channels, retention metrics, and segmentation strategies.

**Business Context:**
- Customer acquisition cost trends
- Retention and churn analysis
- Customer lifetime value calculations
- Segmentation for marketing campaigns

**Data Sources:**
- CRM system exports
- Web analytics data
- Marketing automation platforms

This documentation is maintained by the business intelligence team.
{% enddocs %}

{% docs data_governance %}
Data governance and quality standards for the jaffle shop project.

**Data Quality Standards:**
- All primary keys must be unique and not null
- Date fields must be in YYYY-MM-DD format
- Currency values stored in cents as integers
- All PII must be properly classified

**Data Lineage:**
- Raw data sourced from operational systems
- Staging models apply basic transformations
- Mart models provide business-ready datasets

Maintained by the data governance team.
{% enddocs %}