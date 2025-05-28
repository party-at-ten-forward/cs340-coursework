-- Note: Only use single-line comments in this file.

-- Citation for the following code:
-- Date: 2025/05/22
-- Copied from /OR/ Adapted from /OR/ Based on 
-- (Explain degree of originality)
-- based on ai tool generated code
-- Source URL: https://copilot.cloud.microsoft
-- If AI tools were used: Yes, per recommendation of this assignment.
-- (Explain the use of tools and include a summary of the prompts submitted to the AI tool)
-- Write a MySQL trigger based on the following prompts....
-- he trigger trigger_after_cert_person_inserted automatically calls th....


-- Leave the following query code untouched
DROP TRIGGER IF EXISTS trigger_after_cert_person_inserted;
DELIMITER //

-- ------- Write your code below this line -----------
CREATE TRIGGER trigger_after_cert_person_inserted
AFTER INSERT ON bsg_cert_people
FOR EACH ROW
BEGIN
    CALL sp_update_cert_count_totals();
END //

-- ------- Do not alter query code below this line -----------
DELIMITER ;