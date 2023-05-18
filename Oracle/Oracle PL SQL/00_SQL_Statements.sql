--ALL_TABLES describes the relational tables accessible to the current user
SELECT * FROM all_tables;
SELECT DISTINCT(owner) FROM all_tables;
SELECT * FROM all_tables where owner='HR';

-- Accessing Tables
SELECT * FROM HR.employees;

--ALL_TAB_COLUMNS describes the columns of the tables, views, and clusters accessible to the current user.
SELECT * FROM ALL_TAB_COLUMNS;
SELECT * FROM ALL_TAB_COLUMNS WHERE owner ='HR';

