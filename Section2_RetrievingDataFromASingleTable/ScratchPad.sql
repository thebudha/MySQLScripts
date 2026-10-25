SELECT name,
	unit_price,
    unit_price * 1.1 AS new_price
FROM products

-- The Select clause
SELECT * 
FROM customers
WHERE birth_date > '1990-01-01'

-- Exercise
SELECT *
FROM orders
WHERE order_date >= '2019-01-01'

-- The Where Clause
SELECT *
FROM customers
WHERE state != 'va'

-- AND, OR, and NOT operators
Select * 
FROM customers
WHERE birth_date <= '1990-01-01' AND points > 1000 

-- Exercise
Select * 
FROM order_items
WHERE order_id = 6 AND quantity * unit_price > 30

-- The IN operator
SELECT * 
FROM customers
WHERE state IN ('VA', 'FL', 'GA')

-- Exercise
Select * 
FROM products
WHERE quantity_in_stock IN (49, 38, 72)

-- The BETWEEN operator
SELECT * 
FROM customers
WHERE points BETWEEN 1000 AND 3000

-- Exercise
SELECT * 
FROM customers
WHERE birth_date BETWEEN '1990-01-01' AND '2000-01-01'

-- The LIKE operator
SELECT * 
FROM customers
WHERE last_name LIKE 'b____y'
-- % any number of characters, 
-- _ single character

-- Exercise
SELECT * 
FROM customers
WHERE address LIKE '%Trail%' OR
	address LIKE '%Avenue%' OR
    phone LIKE '%9'
    
-- The REGEXP operator
SELECT * 
FROM customers
WHERE last_name REGEXP 'field|mac|rose'
-- ^ beginning of a string, for example, '^field'
-- $ end of a string, for example, 'field$'
-- | logical OR, for example, 'field$|mac|rose'
-- [abcd] represents any characters listed in the brackets, before or after, for example, '[efg]field'
-- [a-f] represents a range of characters listed in the brackets

-- Exercise
SELECT * 
FROM customers
WHERE first_name REGEXP 'elka|ambur' 

SELECT * 
FROM customers
WHERE last_name REGEXP 'ey$|on$'

SELECT * 
FROM customers
WHERE last_name REGEXP '^my|se'

SELECT * 
FROM customers
WHERE last_name REGEXP 'b[ru]'

-- The NULL operator
SELECT * 
FROM orders
WHERE shipped_date IS NULL

-- The ORDER BY clause, a distant cousin of Santa Clause
SELECT first_name, last_name, 10 AS points 
FROM customers
ORDER BY points, first_name

-- Exercise
SELECT *, quantity * unit_price AS total_price
FROM order_items
WHERE order_id = 2
ORDER BY total_price DESC

-- The LIMIT clause, the other distant cousin of Santa Clause
SELECT * 
FROM customers
LIMIT 3

-- Exercise
SELECT * 
FROM customers
ORDER BY points DESC
LIMIT 4

-- Order of Operations:
SELECT * 
FROM whatever
WHERE
ORDER BY 
LIMIT 
