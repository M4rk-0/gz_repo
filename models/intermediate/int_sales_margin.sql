SELECT s.products_id,s.date_date, 
ROUND(s.quantity*p.purchase_price,2) AS purchase_cost,
ROUND(s.revenue-(s.quantity*p.purchase_price),2) AS margin
FROM {{ref("stg_raw__product")}} p
JOIN {{ref("stg_raw__sales")}} s
USING(products_id)
