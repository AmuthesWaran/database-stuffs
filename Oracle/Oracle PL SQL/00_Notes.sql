-- Concatenate 
||

FirstName || LastName
FirstName || ' ' || LastName

SELECT 'Full Name :' FirstName || ' ' || LastName from Customer;

--Alternative Quotes
'q[ ]'

-- SELECT last_name || q'[ , This employee's role is: ]' || title from employees;


--Arithmetic Operations
+   
-
*
/

SELECT total + 0.50 from invoice;

--Filtering Data
    * Comparison Operators
    * Comparison Keywords
    * Logical Operators

-- WHERE Clause

-- for strings
SELECT * FROM employee WHERE job_id = 'AD_PRESS'

-- Strings and dates must be enclosed with in single quotes ''

-- Comparison Operators
>       Greater Than
>=      Greater Than or equal to
<       Less Than
<=      Less Than or equal to 
=       equal to
<>      NOT equal

-- for numerical columns
SELECT * FROM employee WHERE salary > 4000;

-- Comparison Keywords
    * BETWEEN
    * IN
    * LIKE

-- BETWEEN contains lower and upper limits
SELECT * FROM employee WHERE salary BETWEEN 4000 AND 10000;

-- IN - to look values from a list - can be used with any datatypes
SELECT * FROM employee WHERE job_id IN ('IT_PROG', 'AD_VP');

-- Comparison Keywords - LIKE

%       Represents any sequence of zero or more characters
_       Any single character

-- Logical Operators
    * AND
    * OR
    * NOT

-- AND

    SELECT * FROM invoice WHERE billingcountry = 'india' AND Total > 4

-- OR

    SELECT * FROM invoice WHERE billingcountry = 'india' OR Total > 4

-- NOT

    SELECT * FROM employee WHERE job_id NOT IN ('IT_PROG', 'AD_VP');


--Group Functions
SUM
AVG
MEDIAN
MIN
MAX
COUNT

SELECT SUM(salary) from employees;
SELECT SUM(salary) AS "Total Salary" from employees;

SELECT AVG(salary) from employees;

SELECT MIN(salary), MAX(salary) from employees;

SELECT COUNT(manager_id) FROM employees;
SELECT COUNT(*) FROM employees;

SELECT COUNT(DISTINCT job_id) FROM employees;


--Datatypes can be used for group functions
            Numeric Data        Character Data      Date Data
AVG             X
SUM             X
MIN             X                     X                 X
MAX             X                     X                 X
COUNT           X                     X                 X


-- Group Data
SELECT job_id, AVG(salary) FROM employees GROUP BY job_id;

SELECT job_id, AVG(salary) FROM employees WHERE salary > 5000 GROUP BY job_id;


SELECT job_id, AVG(salary) FROM employees GROUP BY job_id ORDER BY AVG(salary);

SELECT job_id, AVG(salary) FROM employees GROUP BY job_id ORDER BY AVG(salary) DESC;


-- Combining Data using joins
Types of Joins
    *Inner Join
    *Outer Join
    *Cross Join
    *Self Join

--Inner Join

--select columns to output and include table names
--in the from, list the relevant tables separated by INNER JOIN
--Use ON to define the column to join on
-- other SQL clauses can be added

SELECT employees.first_name, departments.department_name 
FROM employees INNER JOIN departments 
ON employees.department_id = departments.department_id;

SELECT employees.first_name, departments.department_name 
FROM employees INNER JOIN departments 
ON employees.department_id = departments.department_id 
where departments.department_name = 'IT';

--to improve the readability use alias after the FROM clause
SELECT e.first_name, d.department_name 
FROM employees e INNER JOIN departments d
ON e.department_id = d.department_id 
where d.department_name = 'IT';






