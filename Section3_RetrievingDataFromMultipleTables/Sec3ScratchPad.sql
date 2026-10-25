-- Inner JOINS
Select order_id, o.customer_id, first_name, last_name
FROM order_items 
JOIN customers c
	ON o.customer_id = c.customer_id

-- Exercise
SELECT order_id, oi.product_id, quantity, oi.unit_price, name
FROM order_items oi
JOIN products p
	ON oi.product_id = p.product_id

-- Joining across databases
USE sql_inventory;

SELECT * 
FROM sql_store.order_items oi
JOIN sql_inventory.products p
	ON oi.product_id = p.product_id
    
-- Self JOINS
USE sql_hr;

SELECT 
	e.employee_id,
    e.first_name,
    m.first_name AS manager
FROM employees e
JOIN employees m
	ON e.reports_to = m.employee_id

-- Joining Multiple Tables
USE sql_store;

SELECT 
	o.order_id, 
    o.order_date, 
    c.first_name, 
    c.last_name, 
    os.name
FROM orders o
JOIN customers c
	ON o.customer_id = c.customer_id
JOIN order_statuses os
	ON o.status = os.order_status_id
    
-- Exercise
USE sql_invoicing;

SELECT 
	p.invoice_id,
    p.date,    
    p.amount,
    c.name,
    pm.name AS payment_method    
FROM payments p
JOIN clients c 
	ON p.client_id = c.client_id
JOIN payment_methods pm
	ON	p.payment_method = pm.payment_method_id
    
-- Compound Join Conditions
SELECT *
FROM order_items oi
JOIN order_item_notes oin
	ON oi.order_id = oin.order_id
    AND oi.product_id = oin.product_id

-- Implicit Join Syntax (do not use as a best practice)
-- Standard Join:
SELECT *
FROM orders o
JOIN customers c
	ON o.customer_id = c.customer_id
    
-- Implicit Join:
SELECT *
FROM orders o, customers c
WHERE o.customer_id = c.customer_id

-- Outer Joins
-- JOIN --> means inner join.  All joins up to this point have been inner joins.
-- OUTER JOINs are:
-- LEFT JOIN
-- RIGHT JOIN

SELECT
	c.customer_id,
    c.first_name,
    o.order_id
FROM customers c
LEFT JOIN orders o
	ON c.customer_id = o.customer_id
ORDER BY c.customer_id
    
SELECT
	c.customer_id,
    c.first_name,
    o.order_id
FROM customers c
RIGHT JOIN orders o
	ON c.customer_id = o.customer_id
ORDER BY c.customer_id

-- Exercise
SELECT 
	oi.product_id,
    p.name,
    oi.quantity
FROM order_items oi
RIGHT JOIN products p
	ON oi.product_id = p.product_id
ORDER BY p.product_id

-- Outer joins between multiple tables
SELECT
	c.customer_id,
    c.first_name,
    o.order_id,
    sh.name AS shipper
FROM customers c
LEFT JOIN orders o
	ON c.customer_id = o.customer_id
LEFT JOIN shippers sh
	ON o.shipper_id = sh.shipper_id
ORDER BY c.customer_id

-- Exercise
SELECT 
	o.order_date,
    o.order_id,
    c.first_name AS customer,
    sh.name AS shipper,
    os.name AS status
FROM orders o
JOIN customers c
	ON o.customer_id = c.customer_id
LEFT JOIN shippers sh
	ON o.shipper_id = sh.shipper_id
JOIN order_statuses os
	ON o.status = os.order_status_id
ORDER BY status, o.order_id, o.order_date DESC

-- Self Outer Joins
USE sql_hr;

SELECT 
	e.employee_id,
    e.first_name,
    m.first_name AS manager
FROM employees e
LEFT JOIN employees m
	ON e.reports_to = m.employee_id

-- The USING Clause, distant cousin to Santa Clause
SELECT 
	o.order_id,
    c.first_name,
    sh.name AS shipper
FROM orders o
JOIN customers c
	-- ON o.customer_id = c.customer_id
    USING (customer_id)
LEFT JOIN shippers sh
	USING (shipper_id)
    
SELECT *
FROM order_items oi
JOIN order_item_notes oin
	USING (order_id, product_id)
/*	ON oi.order_id = oin.order_id AND
		oi.product_id = oin.product_id */


-- Exercise
USE sql_invoicing;

SELECT 
	p.date,
    c.name AS client,
    p.amount,
    pm.name AS 'payment method'    
FROM invoices i
JOIN clients c USING (client_id)
JOIN payments p	USING (invoice_id)
JOIN payment_methods pm
	ON payment_method_id = p.payment_method

-- Natural Joins
SELECT
	o.order_id,
    c.first_name
FROM orders o
NATURAL JOIN customers c

-- Cross Joins
SELECT 
	c.first_name AS customer,
    p.name AS product
FROM customers c
CROSS JOIN products p
ORDER BY c.first_name

-- Exercise
SELECT
	s.name,
    p.name
FROM shippers s
CROSS JOIN products p
ORDER BY s.name

SELECT
	s.name,
    p.name
FROM shippers s, products p
ORDER BY s.name

-- Union Operator
SELECT 
	order_id,
    order_date,
    'Active' AS status
FROM orders
WHERE order_date >+ '2019-01-01'
UNION
SELECT 
	order_id,
    order_date,
    'Archived' AS status
FROM orders
WHERE order_date < '2019-01-01'

-- Exercise
SELECT 
	customer_id,
    first_name,
    points,
    'Bronze' AS type
FROM customers
WHERE points < 2000
UNION
SELECT 
	customer_id,
    first_name,
    points,
    'Silver' AS type
FROM customers
WHERE points BETWEEN 2000 and 3000
UNION
SELECT 
	customer_id,
    first_name,
    points,
    'Gold' AS type
FROM customers
WHERE points > 3000
ORDER BY points DESC

SELECT 
	customer_id,
    first_name,
    points,
    'Gold' AS type
FROM customers
WHERE points >= 3000 
ORDER BY points DESC