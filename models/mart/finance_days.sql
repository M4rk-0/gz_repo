WITH daily_summary AS (
    SELECT
            s.date_date,
            COUNT(DISTINCT s.orders_id) AS total_number_of_transactions,
            ROUND(SUM(s.revenue),2) AS total_revenue,
            ROUND(SUM(s.quantity),2) AS total_quantity_of_products_sold,
            ROUND(SUM(s.quantity * p.purchase_price),2) AS total_purchase_cost,
            ROUND(SUM(sh.shipping_fee),2) AS total_shipping_fees,
            ROUND(SUM(sh.logCost),2) AS total_log_costs,
            -- Calcular Operational Margin: revenue - cost + shipping_fee
            ROUND(SUM(s.revenue - (s.quantity * p.purchase_price) + sh.shipping_fee),2) AS operational_margin
        FROM
            {{ ref("stg_raw__sales") }} s
        JOIN
            {{ ref("stg_raw__product") }} p
            ON s.products_id = p.products_id
        JOIN
            {{ ref("stg_raw__ship") }} sh
            ON s.orders_id = sh.orders_id
        GROUP BY
            s.date_date
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