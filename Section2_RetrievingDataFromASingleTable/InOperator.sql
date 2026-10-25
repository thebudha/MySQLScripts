SELECT *
FROM sql_store.customers
WHERE state IN ('VA', 'FL', 'GA')

SELECT *
FROM sql_store.customers
WHERE state NOT IN ('VA', 'FL', 'GA')