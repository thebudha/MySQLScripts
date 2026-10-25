-- Writing Complex Queries


-- Subqueries
-- Find products that are more
-- expensive than lettuce (id = 3)

SELECT *
FROM products
WHERE unit_price > (
	SELECT unit_price
    FROM products
    WHERE product_id = 3
)

-- Exercise
-- In sql_hr database:
-- Find employees who earn more than average
USE sql_hr;

SELECT *
FROM employees
WHERE salary > (
	SELECT 
        AVG(salary) as average
    FROM employees
)


-- The IN Operator

-- Find the products that have never been ordered

USE sql_store;

SELECT *
FROM products
WHERE product_id NOT IN (
	SELECT DISTINCT product_id
    FROM order_items
)

-- Exercise

-- Find clients without invoices
USE sql_invoicing;

SELECT *
FROM clients
WHERE client_id NOT IN (
	SELECT DISTINCT client_id
    FROM invoices
)

-- Subqueries Versus Joins

SELECT * 
FROM clients
LEFT JOIN invoices USING (client_id)
WHERE invoice_id IS NULL

-- Exercise

-- Find customers who have ordered lettuce (id = 3)
-- Select customer_id, first_name, last_name

USE sql_store;

SELECT *
FROM customers
WHERE customer_id IN (
	SELECT o.customer_id 
	FROM order_items oi
    JOIN orders o USING (order_id)
	WHERE product_id = 3
)


-- The ALL Keyword

-- Select invoices larger than all invoices of client 3
USE sql_invoicing;

SELECT *
FROM invoices
WHERE invoice_total > ALL (
	SELECT invoice_total
    FROM invoices
    WHERE client_id = 3
)


-- The ANY Keyword

-- Select clients with at least two invoices
USE sql_invoicing;

SELECT * 
FROM clients
WHERE client_id = ANY (
	SELECT client_id
	FROM invoices
	GROUP BY client_id
	HAVING COUNT(*) >= 2
)


-- Correlated Subqueries

-- Select employees whose salary is
-- above the average in their office

USE sql_hr;

SELECT *
FROM employees e
WHERE salary > (
	SELECT AVG(salary)
    FROM employees
    WHERE office_id = e.office_id
)

-- Exercise

-- Get invoices that are larger than
-- clients average invoice amount

USE sql_invoicing;

SELECT * 
FROM  invoices i
WHERE invoice_total > (
	SELECT AVG(invoice_total)
	FROM invoices
    WHERE client_id = i.client_id
)


-- The EXISTS Operator

-- Select clients that have an invoice
USE sql_invoicing;

SELECT *
FROM clients
WHERE client_id IN (
	SELECT DISTINCT client_id
    FROM invoices
)

SELECT *
FROM clients c
WHERE EXISTS (
	SELECT client_id
    FROM invoices
    WHERE client_id = c.client_id
)

-- Exercise
-- Find the products that have never been ordered

USE sql_store;

SELECT * 
FROM products 
WHERE product_id NOT IN (
	SELECT product_id
    FROM order_items
)

SELECT * 
FROM products p
WHERE NOT EXISTS (
	SELECT product_id
    FROM order_items
    WHERE product_id = p.product_id
)


-- Subqueries in the SELECT Clause
USE sql_invoicing;

SELECT
	invoice_id,
    invoice_total,
    (SELECT AVG(invoice_total)
		FROM invoices) AS invoice_average,
	invoice_total - (SELECT invoice_average) AS difference
FROM invoices

-- Exercise
USE sql_invoicing;

SELECT
	client_id,
    name,
    (SELECT SUM(invoice_total)
		FROM invoices
        WHERE client_id = c.client_id) AS total_sales,
	(SELECT AVG(invoice_total)
		FROM invoices) AS average,
	(SELECT total_sales - average) AS difference
FROM clients c


-- Subqueries in the FROM Clause
USE sql_invoicing;

SELECT *
FROM (
	SELECT
		client_id,
		name,
		(SELECT SUM(invoice_total)
			FROM invoices
			WHERE client_id = c.client_id) AS total_sales,
		(SELECT AVG(invoice_total)
			FROM invoices) AS average,
		(SELECT total_sales - average) AS difference
	FROM clients c
) AS sales_summary
WHERE total_sales IS NOT NULL
