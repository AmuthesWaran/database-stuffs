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
