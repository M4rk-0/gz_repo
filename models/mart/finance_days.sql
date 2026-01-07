{{ config(materialized='table') }}

WITH daily_summary AS (
    SELECT
            date_date,
            COUNT(DISTINCT orders_id) AS total_number_of_transactions,
            ROUND(SUM(revenue),2) AS total_revenue,
            ROUND(SUM(operational_margin),2) AS operational_margin,
            ROUND(SUM(quantity),2) AS total_quantity_of_products_sold,
            ROUND(SUM(purchase_cost),2) AS total_purchase_cost,
            ROUND(SUM(shipping_fee),2) AS total_shipping_fees,
            ROUND(SUM(logCost),2) AS total_log_costs
        FROM
            {{ ref("int_orders_operational") }}
        GROUP BY
            date_date
)

SELECT
    date_date AS date,
    total_number_of_transactions,
    total_revenue,
    ROUND(total_revenue / NULLIF(total_number_of_transactions, 0),2) AS average_basket,
    operational_margin,
    total_purchase_cost,
    total_shipping_fees,
    total_log_costs,
    total_quantity_of_products_sold
FROM
    daily_summary
ORDER BY
    date DESC
