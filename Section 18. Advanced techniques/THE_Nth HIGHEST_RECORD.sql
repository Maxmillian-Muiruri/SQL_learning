--  SELECTING THE Nth HIGHEST RECORD IN MYSQL

-- Finding the absolute maximum or minimum record is easy using MAX() or MIN(). 
-- However, isolating the Nth highest value (e.g., the 2nd highest salary or 
-- 3rd most expensive product) requires specialized ranking techniques.

-- This guide documents 3 main patterns to achieve this:
--   1) The Optimized LIMIT Offset Strategy (Fastest & Simplest)
--   2) The Nested Reverse Sort Subquery (Standard ANSI SQL compatibility)
--   3) The Correlated Subquery Count Pattern (Pure logical mapping)

-- Choose your database context
USE classicmodels;

-- METHOD 1: THE OPTIMIZED "LIMIT OFFSET" STRATEGY (BEST PRACTICE)


-- MySQL provides an extension to the LIMIT clause: LIMIT [offset], [row_count].
-- To find the Nth highest record, you sort descending and skip exactly (N - 1) rows.

-- Formula: 
--   ORDER BY column_name DESC LIMIT (N - 1), 1;
--
-- Example (N = 2): Fetch the 2nd most expensive product (skip 1 row, take 1 row).

SELECT 
    productCode, 
    productName, 
    buyPrice
FROM products
ORDER BY buyPrice DESC
LIMIT 1, 1; -- (N-1 = 1 offset row to skip, 1 row to fetch)

-- METHOD 2: NESTED REVERSE SORT SUBQUERY

-- How it works:
--   1. The inner query collects the top N records sorting them in ASCENDING order.
--   2. The target Nth record becomes the very last row of that small pool.
--   3. The outer query flips that pool into DESCENDING order and grabs the first row (`LIMIT 1`).

SELECT *
FROM (
    SELECT 
        productCode, 
        productName, 
        buyPrice
    FROM products
    ORDER BY buyPrice ASC
    LIMIT 2 -- Replace with your targeted 'N' value
) AS tbl
ORDER BY buyPrice DESC
LIMIT 1;

-- METHOD 3: CORRELATED SUBQUERY COUNT PATTERN

-- How it works:
--   For every row evaluated by the outer query (`a`), the inner query (`b`) counts 
--   how many records have a value strictly greater than it. 
--   If exactly (N - 1) records are higher than row `a`, then row `a` must be the Nth highest record.
--
-- Formula: 
--   WHERE (N - 1) = (SELECT COUNT(*) FROM table b WHERE b.val > a.val)

SELECT 
    productCode, 
    productName, 
    buyPrice
FROM products a
WHERE 1 = ( -- N - 1 = 1 (Looking for the 2nd highest)
    SELECT COUNT(productCode)
    FROM products b
    WHERE b.buyPrice > a.buyPrice
);

-- SUMMARY 
-- 1. MySQL Native Speed: Use `ORDER BY column DESC LIMIT N-1, 1`. It is the most legible.
-- 2. Generic SQL Engines: Use Method 2 or Method 3 if migrating to databases lacking offsets.
-- 3. Always test tracking fields to make sure index configurations support sorting speeds.
