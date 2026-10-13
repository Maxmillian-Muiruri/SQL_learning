--  MYSQL SELECT INTO VARIABLE

-- The SELECT INTO statement allows you to take data columns or expressions directly 
-- from a query result set and inject them seamlessly into user-defined variables.

-- Strict Structural Rules:
--  1. The number of variables MUST exactly match the number of columns selected.
--  2. The query must return a MAXIMUM of one row.
--  3. If zero rows are found, a "no data" warning is issued; variables are unchanged.
--  4. If multiple rows are found, MySQL completely crashes with Error 1172.

-- Choose your database context
USE classicmodels;

-- METHOD 1: SELECT INTO A SINGLE VARIABLE
-- Pulling a single column value from a targeted record layout.

SELECT city
INTO @city
FROM customers
WHERE customerNumber = 103;

-- Display the variable value
SELECT @city;


-- METHOD 2: SELECT INTO MULTIPLE VARIABLES

-- Pulling multiple values simultaneously by separating the variables with commas.
-- Columns and destination variables map strictly from left to right.

SELECT city, country 
INTO @city, @country
FROM customers
WHERE customerNumber = 103;

-- Display multiple variables in a single view
SELECT @city, @country;


-- METHOD 3: FIXING MULTIPLE ROWS (THE LIMIT 1 SAFETY NET)
-- When a filter expression captures a wide dataset, the query will fail immediately.

-- [THIS WILL FAIL]: More than one customer has an ID greater than 103
SELECT creditLimit
INTO @creditLimit
FROM customers
WHERE customerNumber > 103;

-- Expected Output Error:
-- "Error Code: 1172. Result consisted of more than one row"

-- [THE FIX]: Add 'LIMIT 1' to guarantee the query never returns more than one row
SELECT creditLimit
INTO @creditLimit
FROM customers
WHERE customerNumber > 103
LIMIT 1;



-- METHOD 4: ASSIGNING COMPLEX EXPRESSIONS TO VARIABLES
-- You are not limited to raw columns. You can assign calculated database functions or
-- expressions (like string concatenations) directly into variables.

SELECT CONCAT_WS(' ', contactFirstName, contactLastName)
INTO @full_name 
FROM customers
WHERE customerNumber = 103;

-- View the combined string expression
SELECT @full_name;


-- SUMMARY 
-- 1. Syntax structure: SELECT col1, col2 INTO @v1, @v2 FROM table WHERE ...
-- 2. Keep columns and variables balanced (1-to-1 ratio).
-- 3. Always apply a LIMIT 1 clause if your WHERE filter is not perfectly unique.
