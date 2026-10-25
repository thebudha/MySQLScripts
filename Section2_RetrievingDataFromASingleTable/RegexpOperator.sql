SELECT *
FROM customers
WHERE last_name LIKE '%field%'

SELECT *
FROM customers
WHERE last_name REGEXP 'field'

SELECT *
FROM customers
WHERE last_name REGEXP 'field|mac|rose'

SELECT *
FROM customers
WHERE last_name REGEXP '[gim]e'

SELECT *
FROM customers
WHERE last_name REGEXP 'e[fmq]'

SELECT *
FROM customers
WHERE last_name REGEXP 'e[fmq]'

SELECT *
FROM customers
WHERE last_name REGEXP '[a-h]e'

-- ^ beginning
-- $ end
-- | logical or
-- [abcd]
-- [a-f]
