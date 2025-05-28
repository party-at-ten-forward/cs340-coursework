-- Note: Only use single-line comments in this file.

-- Citation for the following code:
-- Date: 2025/05/19
-- Copied from /OR/ Adapted from /OR/ Based on 
-- (Explain degree of originality)
-- based on ai tool generated code
-- Source URL: https://copilot.cloud.microsoft
-- If AI tools were used: Yes, per recommendation of this assignment.
-- (Explain the use of tools and include a summary of the prompts submitted to the AI tool)
-- Write a MySQL stored procedure sp_query1 takes an input time in a specific format....

-- Leave the following query code untouched
DROP PROCEDURE IF EXISTS sp_query1;
DELIMITER //

-- ------- Write your code below this line -----------

CREATE PROCEDURE sp_query1(IN input_time VARCHAR(4), OUT greeting VARCHAR(100))
BEGIN
    DECLARE time_int INT;

    -- Validate input: must be 4 digits and numeric
    IF LENGTH(input_time) != 4 OR input_time REGEXP '[^0-9]' THEN
        SET greeting = 'Invalid time format. Please use HHMM.';
    ELSE
        SET time_int = CAST(input_time AS UNSIGNED);

        -- Check if time is within valid range
        IF time_int < 0 OR time_int > 2359 OR time_int MOD 100 >= 60 THEN
            SET greeting = 'Invalid time format. Please use HHMM.';
        ELSEIF time_int BETWEEN 600 AND 1159 THEN
            SET greeting = 'Good morning';
        ELSEIF time_int BETWEEN 1200 AND 1659 THEN
            SET greeting = 'Good afternoon';
        ELSEIF time_int BETWEEN 1700 AND 2359 THEN
            SET greeting = 'Good evening';
        ELSE
            SET greeting = 'My it''s late, shouldn''t you be in bed?';
        END IF;
    END IF;
END//

-- ------- Do not alter query code below this line -----------
DELIMITER ;
