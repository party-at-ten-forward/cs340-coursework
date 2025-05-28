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
-- The stored procedure sp_add_person_certification adds a certification....


-- Leave the following query code untouched
DROP PROCEDURE IF EXISTS sp_add_person_certification;
DELIMITER //

CREATE PROCEDURE sp_add_person_certification (
    IN in_pid INT,
    IN in_cid INT,
    OUT out_cert_count INT
)
BEGIN
    DECLARE cert_title VARCHAR(255);

    -- Error handler: rollback and return -99 on any SQL error
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SET out_cert_count = -99;
    END;

    START TRANSACTION;

    -- Step 1: Get the certification title (will error if not found)
    SELECT title INTO cert_title
    FROM bsg_cert
    WHERE id = in_cid;

    -- Step 2: Check for duplicate entry
    IF EXISTS (
        SELECT 1 FROM bsg_cert_people
        WHERE cid = in_cid AND pid = in_pid
    ) THEN
        -- Duplicate found, rollback and return -99
        ROLLBACK;
        SET out_cert_count = -99;
    ELSE
        -- Step 3: Insert the new certification for the person
        INSERT INTO bsg_cert_people (cid, pid)
        VALUES (in_cid, in_pid);

        -- Step 4: Call the function to get updated count
        SELECT func_cert_count(cert_title) INTO out_cert_count;

        COMMIT;
    END IF;
END;
//
DELIMITER ;
