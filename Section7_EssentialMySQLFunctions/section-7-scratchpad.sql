-- Numeric functions
SELECT ROUND(5.7245)
SELECT ROUND(5.7245, 2)
SELECT CEILING(5.7245)
SELECT FLOOR(5.7245)
SELECT ABS(-5.2)
SELECT RAND()
SELECT TRUNCATE(5.7245689, 2)

SELECT ABS(-15);        -- Returns 15
SELECT CEIL(4.2);       -- Returns 5
SELECT FLOOR(4.8);      -- Returns 4
SELECT ROUND(3.14159,2);-- Returns 3.14
SELECT MOD(10,3);       -- Returns 1
SELECT POWER(2,3);      -- Returns 8
SELECT SQRT(16);        -- Returns 4
SELECT SIGN(-7);        -- Returns -1
SELECT LOG(10);         -- Returns natural log of 10
SELECT SIN(PI()/2);     -- Returns 1


-- String Functions
USE sql_store;

SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM customers


-- Date Functions
SELECT NOW(), CURDATE(), CURTIME()
SELECT MONTH(NOW())
SELECT DAY(NOW())
SELECT HOUR(NOW())
SELECT NINUTE(NOW())
SELECT SECOND(NOW())
SELECT DAYNAME(NOW())
SELECT MONTHNAME(NOW())
SELECT EXTRACT(DAY FROM NOW())
SELECT EXTRACT(YEAR FROM NOW())

-- Exercise
SELECT * 
FROM orders
WHERE YEAR(order_date) = YEAR(NOW())


-- Formatting Dates and Times
SELECT DATE_FORMAT(NOW(), '%y')  -- returns 26
SELECT DATE_FORMAT(NOW(), '%Y')  -- returns 2026
SELECT DATE_FORMAT(NOW(), '%m %Y')  -- returns 10 2026
SELECT DATE_FORMAT(NOW(), '%M %Y')  -- returns October 2026
SELECT DATE_FORMAT(NOW(), '%M %d %Y')  -- returns October 11 2026
SELECT TIME_FORMAT(NOW(), '%H:%i %p')  -- returns 16:40 PM


-- Calculating Dates and Times
SELECT DATE_ADD(NOW(), INTERVAL 1 DAY)  -- returns 2026-10-12 16:43:22
SELECT DATE_ADD(NOW(), INTERVAL 1 YEAR)  -- returns 2027-10-11 16:44:09
SELECT DATE_SUB(NOW(), INTERVAL 1 YEAR)  -- returns 2025-10-11 16:45:19
SELECT DATEDIFF('2019-01-05', '2019-01-01')  -- returns 4
SELECT DATEDIFF('2019-01-05', '2019-01-01')  -- returns 4
SELECT TIME_TO_SEC('09:00')  -- returns 32400
SELECT TIME_TO_SEC('09:02') - TIME_TO_SEC('09:00')  -- returns 120


-- The IFNULL and COALESCE Functions
USE sql_store;

SELECT
	order_id,
    IFNULL(shipper_id, 'Not assigned') AS shipper
FROM orders


USE sql_store;

SELECT
	order_id,
    COALESCE(shipper_id, comments, 'Not assigned') AS shipper
FROM orders

-- Exercise
USE sql_store;

SELECT 
	CONCAT(first_name, ' ', last_name) AS customer,
    IFNULL(phone, 'Unknown') AS phone
FROM customers


-- The IF Function
IF(expression, first, second)

SELECT 
	order_id,
    order_date,
    IF(
		YEAR(order_date) < YEAR(NOW()),
        'Active',
        'Archived') AS category
FROM orders

-- Exercise
SELECT 
	product_id,
    name,
    COUNT(*) AS orders,
    IF(COUNT(*) > 1, 'Many times', 'Once') AS frequency
FROM products
JOIN order_items USING (product_id)
GROUP BY product_id, name


-- The CASE Operator
SELECT 
	order_id,
    CASE
		WHEN YEAR(order_date) = YEAR(NOW()) THEN 'Active'
        WHEN YEAR(order_date) = YEAR(NOW()) -1 THEN 'Last Year'
        WHEN YEAR(order_date) < YEAR(NOW()) -1 THEN 'Archived' 
        ELSE 'Future'
	END AS category
FROM orders

SELECT 
	order_id,
    CASE
		WHEN YEAR(order_date) >= YEAR('2019-01-01') THEN 'Active'
        WHEN YEAR(order_date) = YEAR('2019-01-01') -1 THEN 'Last Year'
        WHEN YEAR(order_date) < YEAR('2019-01-01') -1 THEN 'Archived' 
        ELSE 'Future'
	END AS category
FROM orders

-- Exercise
SELECT 
	CONCAT(first_name, ' ', last_name) AS customer,
    points,
	CASE
		WHEN points > 3000 THEN 'Gold'
        WHEN points >= 2000 THEN 'Silver'
        ELSE 'Bronze'
	END AS category
FROM customers
ORDER BY points DESC;




