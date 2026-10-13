-- MySQL DELETE JOIN

-- DELETE JOIN deletes rows from one or more tables, using a JOIN to decide
-- which rows to remove. It is more flexible than the other two ways
-- you learned (multi-table DELETE and ON DELETE CASCADE).

-- PART 1: DELETE with INNER JOIN
-- Deletes rows that have a MATCH in the other table.
--
-- Syntax:
--   DELETE T1, T2
--   FROM T1
--   INNER JOIN T2 ON T1.key = T2.key
--   WHERE condition;
--
-- How it works:
--   1. The tables to delete from go between DELETE and FROM.
--      - DELETE T1, T2 -> deletes matching rows from BOTH tables
--      - DELETE T1     -> deletes only from T1 (T2 is just used to match)
--      - DELETE T2     -> deletes only from T2
--   2. ON T1.key = T2.key: how the rows are matched.
--   3. WHERE: which of the matched rows to delete.

-- SETUP: two small tables

DROP TABLE IF EXISTS t1, t2;

CREATE TABLE t1 (
    id INT PRIMARY KEY AUTO_INCREMENT
);

CREATE TABLE t2 (
    id VARCHAR(20) PRIMARY KEY,
    ref INT NOT NULL      -- ref points to t1.id
);

INSERT INTO t1 VALUES (1), (2), (3);

INSERT INTO t2(id, ref)
VALUES ('A', 1), ('B', 2), ('C', 3);

-- EXAMPLE 1: Delete from BOTH tables
-- Delete the row with id 1 in t1 AND the row with ref 1 in t2.

DELETE t1, t2
FROM t1
INNER JOIN t2 ON t2.ref = t1.id
WHERE t1.id = 1;
-- MySQL replies: 2 row(s) affected (one row from each table)

SELECT * FROM t1;   -- ids 2 and 3 remain
SELECT * FROM t2;   -- B and C remain

-- PART 2: DELETE with LEFT JOIN
-- Deletes rows in the LEFT table that have NO match in the right table.
--
-- Syntax:
--   DELETE T1
--   FROM T1
--   LEFT JOIN T2 ON T1.key = T2.key
--   WHERE T2.key IS NULL;
--
-- How it works:
--   1. LEFT JOIN keeps every T1 row. Where T2 has no match, the T2 columns
--      are NULL.
--   2. WHERE T2.key IS NULL keeps only the rows with NO match.
--   3. Only T1 is written after DELETE, because we only want to delete
--      from T1 (T2 has no row to delete for those cases).

-- EXAMPLE 2: Delete customers who have never placed an order
-- NOTE: this uses the customers and orders tables from the sample database
-- "classicmodels". Each customer has zero or more orders, and each order
-- belongs to exactly one customer.

DELETE customers
FROM customers
LEFT JOIN orders ON customers.customerNumber = orders.customerNumber
WHERE orderNumber IS NULL;

-- Check that none are left: this should return an empty result
SELECT
    c.customerNumber,
    c.customerName,
    orderNumber
FROM customers c
LEFT JOIN orders o ON c.customerNumber = o.customerNumber
WHERE orderNumber IS NULL;

-- EXTRA PRACTICE (not in the tutorial): LEFT JOIN with t1 and t2
-- This works without the classicmodels database.
-- Add a t1 row that has no matching t2 row, then delete it.

INSERT INTO t1 VALUES (4);

-- Workbench safe update mode (Error 1175) blocks a WHERE without a key,
-- so turn it off for this statement, then back on.
SET SQL_SAFE_UPDATES = 0;

DELETE t1
FROM t1
LEFT JOIN t2 ON t2.ref = t1.id
WHERE t2.ref IS NULL;
-- MySQL replies: 1 row(s) affected (t1 row 4 had no match in t2)

SET SQL_SAFE_UPDATES = 1;

SELECT * FROM t1;   -- ids 2 and 3 remain

-- SUMMARY
-- 1. DELETE T1, T2 FROM T1 INNER JOIN T2 ... deletes matching rows from
--    both tables.
-- 2. The tables listed between DELETE and FROM are the ones that lose rows.
-- 3. DELETE T1 FROM T1 LEFT JOIN T2 ... WHERE T2.key IS NULL deletes
--    T1 rows that have no match in T2.
-- 4. Always test the join with a SELECT first to see what will be deleted.