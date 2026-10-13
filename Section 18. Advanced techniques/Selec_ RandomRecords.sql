-- MySQL Select Random Records

-- Selecting random records is a common requirement for features like "Product of the Day",
-- "Random Blog Posts", or "Featured Gallery Images".

-- This file documents 3 distinct techniques along with their performance trade-offs:
--   1) ORDER BY RAND() (Easiest, but very slow on large tables)
--   2) INNER JOIN Optimization (Blazing fast, requires zero-gap Auto-Increment ID)
--   3) User-Defined Variables (Advanced range mapping, requires consecutive numeric IDs)

-- Choose your database context
USE classicmodels;

-- METHOD 1: THE STANDARD APPROACH (ORDER BY RAND)
-- How it works:
--  - RAND() generates a temporary random decimal between 0 and 1 for every single row.
--  - ORDER BY sorts the entire table based on those dynamically generated values.
--  - LIMIT extracts the top N rows from that scrambled list.
--
--   This works beautifully for small tables. However, for large tables, it scales terribly. 
--   MySQL must perform a full-table scan and sort the entire dataset in memory before 
--   it can return even a single random row.

-- Example: Fetching 5 random customer accounts from the database
SELECT 
    customerNumber, 
    customerName
FROM customers
ORDER BY RAND()
LIMIT 5;

-- METHOD 2: INNER JOIN OPTIMIZATION (HIGH SPEED)

-- How it works:
--  - Instead of shuffling the whole table, it computes a single random ID mathematically:
--    RAND() * MAX(id) gives a random value within your table boundaries.
--  - It wraps this math into a derived table/subquery (`x`) and joins it back to the main table.
--
-- NOTE 
--   1. The table MUST have an integer primary key auto-increment field.
--   2. There must be NO GAPS in the numerical sequence (no deleted record IDs).
--   3. If you increase the LIMIT to more than 1, it will just give you continuous sequential 
--      records starting from that random location, rather than separate random entries.

SELECT 
    t.customerNumber, 
    t.customerName
FROM customers AS t
INNER JOIN (
    SELECT ROUND(RAND() * (SELECT MAX(customerNumber) FROM customers)) AS customerNumber
) AS x
WHERE t.customerNumber >= x.customerNumber
LIMIT 1;

-- METHOD 3: THE VARIABLE RANGE SCANNER (ADVANCED MULTI-ROW MATCHING)
-- How it works:
--  - It loops through a subquery block using an incrementing session tracker counter (`@num`)
--    to safely select multiple random ID numbers falling strictly between 1 and N.
--  - It matches those computed numbers against the real table keys inside the outer WHERE clause.
--
-- NOTE
--   1. Primary keys must be integers running strictly in sequence without structural gaps.
--   2. User-defined variables are bound strictly to your connection session. This technique
--      will fail or behave unpredictably if your application relies on Connection Pooling.

-- Example: Selecting a clean block of "N" random items using an inline variable loop
SELECT t.*
FROM (
    SELECT 
        ROUND(RAND() * (SELECT MAX(customerNumber) FROM customers)) AS random_num,
        @num := @num + 1 -- Increments session tracker safely
    FROM (SELECT @num := 0) AS a, customers
    LIMIT 5 -- Replace 5 with your desired N count of random records
) AS b,
customers AS t
WHERE b.random_num = t.customerNumber;

-- SUMMARY 

-- 1. Small Tables: Simply use ORDER BY RAND() LIMIT N.
-- 2. Performance (Single Row): Use the MAX(id) INNER JOIN strategy.
-- 3. Performance (Multi Row): Use the subquery variable-loop join mechanism.
-- 4. Always remember that randomized engines will display unique records on every single execution.

