SELECT s.orders_id, s.date_date, 
ROUND(s.revenue-(s.quantity*p.purchase_price),2) AS margin,
ROUND((sh.shipping_fee-(sh.logCost-sh.ship_cost)),2) AS operation,
ROUND(s.revenue-(s.quantity*p.purchase_price) + (sh.shipping_fee-(sh.logCost-sh.ship_cost)),2) AS operational_margin,
s.quantity 
FROM 
    {{ref("stg_raw__sales")}} s
JOIN 
    {{ref("stg_raw__product")}} p
    ON s.products_id = p.products_id
JOIN 
    {{ref("stg_raw__ship")}} sh
    ON sh.orders_id = s.orders_id
ORDER BY orders_id DESC

