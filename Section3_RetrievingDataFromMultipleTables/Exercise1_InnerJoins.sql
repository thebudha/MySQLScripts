SELECT order_id, p.product_id, quantity, o.unit_price 
FROM order_items o
JOIN products p
	ON o.order_id = p.product_id