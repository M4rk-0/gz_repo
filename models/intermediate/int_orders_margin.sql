SELECT s.orders_id,s.date_date,s.revenue,s.quantity, 
ROUND(s.quantity*p.purchase_price,2) AS purchase_cost,
ROUND(s.revenue-(s.quantity*p.purchase_price),2) AS margin
FROM {{ref("stg_raw__product")}} p
JOIN {{ref("stg_raw__sales")}} s
USING(products_id)
WHERE s.date_date = "2021-09-27"
ORDER BY products_id DESC