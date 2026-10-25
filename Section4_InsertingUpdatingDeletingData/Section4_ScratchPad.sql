-- Inserting a row
INSERT INTO customers (
	first_name,
    last_name,
    birth_date,
    address,
    city,
    state)
VALUES (
	'John', 
    'Smith', 
    '1990-01-01',
    'address',
    'city',
    'CA')

-- Inserting multiple rows
INSERT INTO shippers (name)
VALUES ('Shipper1'),
	   ('Shipper2'),
       ('Shipper3')
	
-- Exercise
-- Insert three rows in the products table
INSERT INTO products (
	name,
    quantity_in_stock,
    unit_price)
VALUES ('Medium size pumpkins', 100, 3.79),
	   ('Zevia ginger ale 6-pack', 12, 6.99),
       ('Lysol linen scent 2-pack', 4, 13.76)
	
-- Inserting Hierarchical Rows
INSERT INTO orders (customer_id, order_date, status)
VALUES (1, '2019-01-02', 1);

INSERT INTO order_items
VALUES (LAST_INSERT_ID(), 1, 1, 2.95),
	   (LAST_INSERT_ID(), 2, 1, 3.95)
       
-- Creating a Copy of a Table
CREATE TABLE orders_archived AS
SELECT * FROM orders

INSERT INTO orders_archived
SELECT *
FROM orders
WHERE order_date < '2019-01-01'

-- Exercise

USE sql_invoicing;

CREATE TABLE invoices_archived AS
SELECT
	i.invoice_id,
    i.number,
    c.name AS client,
    i.invoice_total,
    i.payment_total,
    i.invoice_date,
    i.payment_date,
    i.due_date
FROM invoices i
JOIN clients c
	USING (client_id)
WHERE payment_date IS NOT NULL
ORDER BY invoice_id
       
-- Updating a Single Row
UPDATE invoices
SET 
	payment_total = invoice_total * 0.5, 
    payment_date = due_date
WHERE invoice_id = 3
       
-- Updating Multiple Rows
UPDATE invoices
SET 
	payment_total = invoice_total * 0.5, 
    payment_date = due_date
WHERE client_id IN (3, 4)

-- Exercise
UPDATE customers
SET points = points + 50
WHERE birth_date < '1990-01-01'

-- Using subqueries in Updates
UPDATE invoices
SET 
	payment_total = invoice_total * 0.5, 
    payment_date = due_date
WHERE client_id IN
	(SELECT client_id
	FROM clients
	WHERE state IN('CA', 'NY'))

-- Exercise
UPDATE orders
SET comments = 'Gold Customer'
WHERE customer_id IN
	(SELECT customer_id
	FROM customers
	WHERE points > 3000)
    
-- Deleting Rows
DELETE FROM invoices
WHERE client_id = (
	SELECT *
	FROM clients
	WHERE name = 'Myworks
)




