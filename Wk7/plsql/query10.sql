-- Note: Only use single-line comments in this file.

-- Citation for the following code:
-- Date: 2025/05/22
-- Copied from /OR/ Adapted from /OR/ Based on 
-- (Explain degree of originality)
-- based on ai tool generated code
-- Source URL: https://copilot.cloud.microsoft
-- If AI tools were used: Yes, per recommendation of this assignment.
-- (Explain the use of tools and include a summary of the prompts submitted to the AI tool)
-- Write a MySQL stored procedure based on the following prompts....
-- The sp_delete_cert_person_update_total deletes a row....


-- Leave the following query code untouched
DROP PROCEDURE IF EXISTS sp_delete_cert_person_update_total;
DELIMITER //

-- ------- Write your code below this line -----------
CREATE PROCEDURE sp_delete_cert_person_update_total(
    IN cert_id INT,
    IN person_id INT
)
BEGIN
    DECLARE initial_count INT;
    DECLARE rows_affected INT;
    DECLARE result_message VARCHAR(100);

    -- Get initial row count
    SELECT COUNT(*) INTO initial_count
    FROM bsg_cert_people;

    -- Attempt to delete the record
    DELETE FROM bsg_cert_people
    WHERE cid = cert_id AND pid = person_id;

    -- Capture the number of affected rows
    SET rows_affected = ROW_COUNT();

    -- Check if the delete was successful
    IF rows_affected > 0 THEN
        CALL sp_update_cert_count_totals();
        SET result_message = 'cert deleted and cert count total updated';
    ELSE
        SET result_message = 'Delete error!';
    END IF;

    -- Return the result message and row count info
    SELECT result_message AS message, initial_count AS before_delete, 
           (SELECT COUNT(*) FROM bsg_cert_people) AS after_delete;
END //
-- ------- Do not alter query code below this line -----------
DELIMITER ;