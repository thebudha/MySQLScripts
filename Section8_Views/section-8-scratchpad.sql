-- Creating Views
USE sql_invoicing;

CREATE OR REPLACE VIEW sales_by_client AS
SELECT
	c.client_id,
    c.name,
    SUM(invoice_total) AS total_sales
FROM clients c
JOIN invoices i USING (client_id)
GROUP BY client_id, name


SELECT *
FROM sales_by_client
JOIN clients USING (client_id)


-- Exercise
-- Create a view to see the balance for each client.
--
-- clients_balance

-- client_id
-- name
-- balance

CREATE VIEW clients_balance AS
SELECT
	c.client_id,
    c.name,
    SUM(invoice_total - payment_total) AS balance
    FROM clients c
JOIN invoices i USING (client_id)
GROUP BY client_id, name


-- Altering or Dropping Views
DROP VIEW sales_by_client


-- Updatable Views
CREATE OR REPLACE VIEW invoices_with_balance AS
SELECT 
	invoice_id,
	number,
    client_id,
    invoice_total,
    payment_total,
    invoice_total - payment_total AS balance,
    invoice_date,
    due_date,
    payment_date
FROM invoices
WHERE (invoice_total - payment_total) > 0


DELETE FROM invoices_with_balance
WHERE invoice_id = 1

-- updating view
UPDATE invoices_with_balance
SET due_date = DATE_ADD(due_date, INTERVAL 2 DAY)
WHERE invoice_id = 2


-- The WITH OPTION CHECK Clause
CREATE OR REPLACE VIEW invoices_with_balance AS
SELECT 
	invoice_id,
	number,
    client_id,
    invoice_total,
    payment_total,
    invoice_total - payment_total AS balance,
    invoice_date,
    due_date,
    payment_date
FROM invoices
WHERE (invoice_total - payment_total) > 0
WITH CHECK OPTION

UPDATE invoices_with_balance
SET payment_total = invoice_total
WHERE invoice_id = 3


-- Other Benefits of Views
-- Simplify Queries
-- Reduce the impact of changes to your database design
-- Restrict access to the data in the underlying table

