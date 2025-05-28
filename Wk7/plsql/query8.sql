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
-- The stored procedure sp_update_cert_count_totals updates the cert_total column in the bsg_cert table with....



-- Leave the following query code untouched
DROP PROCEDURE IF EXISTS sp_update_cert_count_totals;
DELIMITER //

-- ------- Write your code below this line -----------
CREATE PROCEDURE sp_update_cert_count_totals()
BEGIN
    -- Update cert_total in bsg_cert with the count of people per certificate
    UPDATE bsg_cert
    LEFT JOIN (
        SELECT cid, COUNT(*) AS total
        FROM bsg_cert_people
        GROUP BY cid
    ) AS cp ON bsg_cert.id = cp.cid
    SET bsg_cert.cert_total = IFNULL(cp.total, 0);
END //

-- ------- Do not alter query code below this line -----------
DELIMITER ;