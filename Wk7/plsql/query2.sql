-- Note: Only use single-line comments in this file.

-- Citation for the following code:
-- Date: 2025/05/22
-- Copied from /OR/ Adapted from /OR/ Based on 
-- (Explain degree of originality)
-- based on ai tool generated code
-- Source URL: https://copilot.cloud.microsoft
-- If AI tools were used: Yes, per recommendation of this assignment.
-- (Explain the use of tools and include a summary of the prompts submitted to the AI tool)
-- Write a MySQL view based on the following prompts....
-- The view v_cert_people returns the following values...



-- Leave the following query code untouched
DROP VIEW IF EXISTS v_cert_people;

-- ------- Write your code below this line -----------
CREATE VIEW v_cert_people AS
SELECT 
    bsg_cert.title,
    bsg_people.fname,
    bsg_people.lname,
    bsg_planets.name AS planet_name
FROM bsg_cert_people
JOIN bsg_cert ON bsg_cert_people.cid = bsg_cert.id
JOIN bsg_people ON bsg_cert_people.pid = bsg_people.id
LEFT JOIN bsg_planets ON bsg_people.homeworld = bsg_planets.id;

