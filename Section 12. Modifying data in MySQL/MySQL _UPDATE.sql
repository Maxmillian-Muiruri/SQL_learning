-- MySQL UPDATE

-- UPDATE changes existing data in a table.
-- It can change one or more columns, in one row or in many rows.
--
-- Syntax:
--   UPDATE [LOW_PRIORITY] [IGNORE] table_name
--   SET
--       column_name1 = expr1,
--       column_name2 = expr2,
--       ...
--   [WHERE condition];
--
-- How it works:
--   1. UPDATE table_name: which table to change.
/*   2. SET: which columns get which new values.
      Several columns are separated by commas.
     A value can be a plain value, an expression, or a subquery. */
--   3. WHERE: which rows to change.
--
/*  WHERE is optional, but if you leave it out, EVERY row in the
 table is updated. Always check that your WHERE is there. */
--  run a SELECT with the same WHERE first, to see which rows will change.

-- Two optional modifiers:
--   LOW_PRIORITY: wait until nobody is reading the table before updating.
--                 Only works with table-level locking engines
--                 (MyISAM, MERGE, MEMORY).
--   IGNORE:       keep going even if some rows cause errors, such as
--                 duplicate-key conflicts. Those rows are skipped.

--  use the employees and customers tables from the
-- MySQL sample database "classicmodels".

-- EXAMPLE 1: Update one column in one row

-- Step 1: look at the row before changing it
SELECT firstname, lastname, email
FROM employees
WHERE employeeNumber = 1056;

-- Step 2: change the email
-- WHERE picks employee 1056 only. SET gives the new email.
UPDATE employees
SET email = 'mary.patterson@classicmodelcars.com'
WHERE employeeNumber = 1056;
-- MySQL replies: 1 row(s) affected

-- Step 3: check the change
SELECT firstname, lastname, email
FROM employees
WHERE employeeNumber = 1056;

-- EXAMPLE 2: Update several columns at once
-- Separate the assignments with commas.

UPDATE employees
SET lastname = 'Hill',
    email = 'mary.hill@classicmodelcars.com'
WHERE employeeNumber = 1056;

SELECT firstname, lastname, email
FROM employees
WHERE employeeNumber = 1056;

-- EXAMPLE 3: Replace part of a text value
-- REPLACE(text, old_part, new_part) swaps one piece of text for another.
-- Here it changes the email domain of all Sales Reps in office 6.

UPDATE employees
SET email = REPLACE(email, '@classicmodelcars.com', '@mysqltutorial.org')
WHERE jobTitle = 'Sales Rep'
  AND officeCode = 6;

-- EXAMPLE 4:  Using MySQL UPDATE to update rows returned by a SELECT statement 

-- Step 1: find customers with no sales rep (the value is NULL)
SELECT customername, salesRepEmployeeNumber
FROM customers
WHERE salesRepEmployeeNumber IS NULL;

-- Step 2: this query picks one random Sales Rep
--   ORDER BY RAND() shuffles the rows, LIMIT 1 keeps the first one.
SELECT employeeNumber
FROM employees
WHERE jobtitle = 'Sales Rep'
ORDER BY RAND()
LIMIT 1;

-- Step 3: put that query inside SET (in brackets) to fill the NULLs
UPDATE customers
SET salesRepEmployeeNumber = (
    SELECT employeeNumber
    FROM employees
    WHERE jobtitle = 'Sales Rep'
    ORDER BY RAND()
    LIMIT 1
)
WHERE salesRepEmployeeNumber IS NULL;

-- Step 4: check. This should now return no rows.
SELECT salesRepEmployeeNumber
FROM customers
WHERE salesRepEmployeeNumber IS NULL;

-- SUMMARY
-- 1. UPDATE table SET column = value WHERE condition; changes existing rows.
-- 2. Separate several column assignments with commas.
-- 3. Without WHERE, ALL rows are updated. Never forget it.
-- 4. Check with a SELECT before and after the update.
-- 5. REPLACE() changes part of a text value.
-- 6. A subquery in SET can take the new value from another table.
-- 7. IGNORE skips rows that cause errors.
-- 8. LOW_PRIORITY delays the update (table-locking engines only).