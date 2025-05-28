-- Note: Only use single-line comments in this file.

-- Citation for the following code:
-- Date: 2025/05/22
-- Copied from /OR/ Adapted from /OR/ Based on 
-- (Explain degree of originality)
-- based on ai tool generated code
-- Source URL: https://copilot.cloud.microsoft
-- If AI tools were used: Yes, per recommendation of this assignment.
-- (Explain the use of tools and include a summary of the prompts submitted to the AI tool)
-- Write a MySQL function based on the following prompts....
-- The function func_cert_count accepts a certification title and returns...


-- Leave the following query code untouched
Drop TABLE IF EXISTS diag_function_cert_use;
CREATE TABLE diag_function_cert_use (
    used INT DEFAULT 0
);

INSERT INTO diag_function_cert_use (used) VALUES (0)
ON DUPLICATE KEY UPDATE used = used;

DELIMITER //
DROP FUNCTION IF EXISTS func_cert_count;

-- ------- Write your code below this line -----------
CREATE FUNCTION func_cert_count(cert_title VARCHAR(255)) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE cert_count INT;

    -- Get the count of people with the given certification title
    SELECT COUNT(*) INTO cert_count
    FROM bsg_cert_people AS cp
    JOIN bsg_cert AS c ON cp.cid = c.id
    WHERE c.title = cert_title;

    -- Increment the usage counter
    UPDATE diag_function_cert_use SET used = used + 1;

    -- Return the count
    RETURN cert_count;
END;
//
-- ------- Do not alter query code below this line -----------
DELIMITER ;
