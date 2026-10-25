-- Stored Procedures

-- Creating a Stored Procedure

DELIMITER $$
CREATE PROCEDURE get_clients()
BEGIN
	SELECT * FROM clients;
END$$

DELIMITER ;

CALL get_clients()

-- Exercise

DELIMITER $$
CREATE PROCEDURE get_invoices_with_balance()
BEGIN
	SELECT *
	FROM invoices_with_balance
	WHERE balance > 0;
END$$

DELIMITER ;

-- Dropping Stored Procedures
DROP PROCEDURE IF EXISTS get_clients;


-- Procedures

DROP PROCEDURE IF EXISTS get_clients_by_state;

DELIMITER $$
CREATE PROCEDURE get_clients_by_state
(
	state CHAR(2)
)
BEGIN
	SELECT * FROM clients c
    WHERE c.state = state;
END$$

DELIMITER ;

CALL get_clients_by_state('CA')

-- Exercise
DROP PROCEDURE IF EXISTS get_invoices_by_client;

DELIMITER $$
CREATE PROCEDURE get_invoices_by_client
(
	client_id INT
)
BEGIN
	SELECT * 
    FROM invoices i
    WHERE i.client_id = client_id;
END$$

DELIMITER ;

CALL get_invoices_by_client(5)


-- Parameters with Default Values

