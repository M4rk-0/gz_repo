SELECT m.orders_id, m.date_date, 
ROUND((m.margin + sh.shipping_fee)-(sh.logCost-sh.ship_cost),2) AS operational_margin,
m.quantity, m.revenue, m.purchase_cost, m.margin, sh.shipping_fee, sh.logCost, sh.ship_cost 
FROM 
    {{ref("int_orders_margin")}} m
LEFT JOIN 
    {{ref("stg_raw__ship")}} sh
    ON sh.orders_id = m.orders_id
ORDER BY orders_id DESC

