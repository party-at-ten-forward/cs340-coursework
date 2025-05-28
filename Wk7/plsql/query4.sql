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
-- he stored procedure sp_insert_person adds a new person....


-- Leave the following query code untouched
DROP PROCEDURE IF EXISTS sp_insert_person;
DELIMITER //

-- ------- Write your code below this line -----------
CREATE PROCEDURE sp_insert_person (
    IN in_fname VARCHAR(255),
    IN in_lname VARCHAR(255),
    IN in_age INT,
    IN in_homeworld INT,
    IN in_cert_id INT,
    OUT out_person_id INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Rollback on error and return -99
        ROLLBACK;
        SET out_person_id = -99;
    END;

    START TRANSACTION;

    -- Insert into bsg_people
    INSERT INTO bsg_people (fname, lname, age, homeworld)
    VALUES (in_fname, in_lname, in_age, in_homeworld);

    -- Get the new person's ID
    SET out_person_id = LAST_INSERT_ID();

    -- Insert into bsg_cert_people
    INSERT INTO bsg_cert_people (cid, pid)
    VALUES (in_cert_id, out_person_id);

    COMMIT;
END;
//

-- ------- Do not alter query code below this line -----------
DELIMITER ;