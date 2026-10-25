-- Get the top three loyal customers
SELECT *
FROM customers
WHERE points > 1000
ORDER BY points DESC
LIMIT 3