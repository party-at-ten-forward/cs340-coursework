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
-- The stored procedure sp_update_person_homeworld....


-- Leave the following query code untouched
DROP PROCEDURE IF EXISTS sp_update_person_homeworld;
DELIMITER //

-- ------- Write your code below this line -----------
CREATE PROCEDURE sp_update_person_homeworld (
    IN in_pid INT,
    IN myworld VARCHAR(255)
)
BEGIN
    DECLARE new_homeworld_id INT;

    -- Case 1: If myworld is NULL, set homeworld to NULL
    IF myworld IS NULL THEN
        UPDATE bsg_people
        SET homeworld = NULL
        WHERE id = in_pid;

    -- Case 2: If myworld is an integer (as a string), use it as a homeworld ID
    ELSEIF myworld REGEXP '^[0-9]+$' THEN
        SET new_homeworld_id = CAST(myworld AS UNSIGNED);
        UPDATE bsg_people
        SET homeworld = new_homeworld_id
        WHERE id = in_pid;

    -- Case 3: Otherwise, treat myworld as a planet name
    ELSE
        SELECT id INTO new_homeworld_id
        FROM bsg_planets
        WHERE name = myworld
        LIMIT 1;

        UPDATE bsg_people
        SET homeworld = new_homeworld_id
        WHERE id = in_pid;
    END IF;

    -- Return the updated person info with homeworld name
    SELECT 
        p.fname,
        p.lname,
        pl.name AS homeworld,
        p.age
    FROM bsg_people p
    LEFT JOIN bsg_planets pl ON p.homeworld = pl.id
    WHERE p.id = in_pid;
END;
//

-- ------- Do not alter query code below this line -----------
DELIMITER ;