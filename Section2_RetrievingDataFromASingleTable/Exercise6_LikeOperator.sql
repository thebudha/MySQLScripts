SELECT *
FROM customers
WHERE address LIKE '%trail%' OR address LIKE '%avenue%'

SELECT *
FROM customers
WHERE phone LIKE '%9'

SELECT *
FROM customers
WHERE phone NOT LIKE '%9'