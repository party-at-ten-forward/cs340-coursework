/*
****

Citations:
    
Leveraged starter code from "Implementing CUD operations in your app" exploration
Link: https://canvas.oregonstate.edu/courses/1999601/pages/exploration-implementing-cud-operations-in-your-app?module_item_id=25352968

****
*/

-- #############################
-- CREATE Cust_Prod_Orders
-- #############################
DROP PROCEDURE IF EXISTS sp_CreateCustOrder;

DELIMITER //
CREATE PROCEDURE sp_CreateCustOrder(
    IN p_customer INT, 
    IN p_product INT, 
    IN p_price DECIMAL(10,2), 
    IN p_quantity INT,
    IN p_delivery TINYINT(1),
    IN p_recurring TINYINT(1),
    OUT p_id INT
    )
BEGIN
    INSERT INTO Cust_Prod_Orders (
    customer_id, 
    product_id, 
    price, 
    quantity, 
    needs_delivery, 
    recurring
    ) 
    VALUES (
    p_customer,
    p_product,
    p_price, 
    p_quantity, 
    p_delivery, 
    p_recurring
    );

    -- Store the ID of the last inserted row
    SELECT LAST_INSERT_ID() into p_id;
    -- Display the ID of the last inserted customer order.
    SELECT LAST_INSERT_ID() AS 'new_id';

END //
DELIMITER ;

-- #############################
-- UPDATE Cust_Prod_Orders
-- #############################
DROP PROCEDURE IF EXISTS sp_UpdateCustOrder;

DELIMITER //
CREATE PROCEDURE sp_UpdateCustOrder(
    IN p_id INT, 
    IN p_customer INT, 
    IN p_product INT, 
    IN p_price DECIMAL(10,2), 
    IN p_quantity INT,
    IN p_delivery TINYINT(1),
    IN p_recurring TINYINT(1)
    )

BEGIN
    UPDATE Cust_Prod_Orders
    SET
        customer_id = p_customer,
        product_id = p_product,
        price = p_price, 
        quantity = p_quantity, 
        needs_delivery = p_delivery, 
        recurring = p_recurring
    WHERE cust_prod_order_id = p_id;
END //
DELIMITER ;

-- #############################
-- DELETE Cust_Prod_Orders
-- #############################
DROP PROCEDURE IF EXISTS sp_DeleteOrder;

DELIMITER //
CREATE PROCEDURE sp_DeleteOrder(IN p_id INT)
BEGIN
    DECLARE error_message VARCHAR(255); 

    -- error handling
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Roll back the transaction on any error
        ROLLBACK;
        -- Propogate the custom error message to the caller
        RESIGNAL;
    END;

    DELETE FROM Cust_Prod_Orders WHERE cust_prod_order_id = p_id;

    -- ROW_COUNT() returns the number of rows affected by the preceding statement.
    IF ROW_COUNT() = 0 THEN
        set error_message = CONCAT('No matching record found in Cust_Prod_Orders for id: ', p_id);
        -- Trigger custom error, invoke EXIT HANDLER
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = error_message;
    END IF;

    COMMIT;

END //
DELIMITER ;
