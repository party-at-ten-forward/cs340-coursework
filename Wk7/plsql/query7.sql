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
-- The stored procedure sp_modify_cert_table alters the bsg_cert table by....


-- Leave the following query code untouched
DROP PROCEDURE  IF EXISTS sp_modify_cert_table;
DELIMITER //

-- ------- Write your code below this line -----------
CREATE PROCEDURE sp_modify_cert_table()
BEGIN
    -- Add the cert_total column to the bsg_cert table
    ALTER TABLE bsg_cert
    ADD COLUMN cert_total INT DEFAULT 0;
END //

-- ------- Do not alter query code below this line -----------
DELIMITER ;
