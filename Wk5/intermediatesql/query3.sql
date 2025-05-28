-- Write your query to select data here
SELECT employee.first_name, employee.last_name, project.title
FROM employee
INNER JOIN works_on ON employee.id = works_on.eid
INNER JOIN project ON works_on.pid = project.id
ORDER BY employee.first_name ASC;
