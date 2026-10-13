-- MySQL Compare Two Tables

-- In data migration or auditing, it is common to compare a legacy table with a 
-- new table to identify missing, broken, or unmatched data rows.

-- The Core Logic:
--   1. Use UNION ALL to merge the targeted columns from both tables into one pool.
--   2. Use GROUP BY on the fields you want to match.
--   3. Apply HAVING COUNT(*) = 1. If a row exists identically in both tables, 
--      the count is 2. If it is broken or missing from one table, the count is 1.

-- Step 1: Select your database context
USE classicmodels;
-- Step 2: Setup two sample tables representing a migration test
CREATE TABLE IF NOT EXISTS t11 (
    id INT AUTO_INCREMENT PRIMARY KEY, 
    title VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS t22 (
    id INT AUTO_INCREMENT PRIMARY KEY, 
    title VARCHAR(255), 
    note VARCHAR(255) -- Extra descriptive column unique to table 2
);

-- Step 3: Seed identical data into both test environments
TRUNCATE TABLE t11;
TRUNCATE TABLE t22;

INSERT INTO t11(title) VALUES ('row 1'), ('row 2'), ('row 3');
  
-- Copy table 1 data over into table 2 to simulate a successful migration stage
INSERT INTO t22(title, note) 
SELECT title, 'data migration' FROM t11;

-- TEST 1: COMPARING TABLES WITH PERFECTLY MATCHED DATA
-- This combined query counts groups. Since every row matches, COUNT(*) equals 2 
-- everywhere, leaving the HAVING COUNT(*) = 1 filter empty.

SELECT id, title 
FROM (
    SELECT id, title FROM t11 
    UNION ALL 
    SELECT id, title FROM t22
) AS tb1l 
GROUP BY id, title 
HAVING COUNT(*) = 1 
ORDER BY id;

-- Expected Output:
-- Empty set (0.00 sec) -> Proof that data migration matches perfectly!

-- TEST 2: COMPARING TABLES AFTER CHANGES (FINDING MISMATCHES)
-- Insert a brand new unmatched record into table 2 only.
INSERT INTO t22(title, note) VALUES ('new row 4', 'new');

-- Re-run the comparison query engine
SELECT id, title 
FROM (
    SELECT id, title FROM t11 
    UNION ALL 
    SELECT id, title FROM t22
) AS tbl
GROUP BY id, title 
HAVING COUNT(*) = 1 
ORDER BY id; -- The new row, which is the unmatched row, should return:




-- SUMMARY 
-- 1. Combine comparison fields cleanly with: UNION ALL.
-- 2. Group by all critical tracking columns: GROUP BY primary_key, compare_column.
-- 3. Filter using: HAVING COUNT(*) = 1 to expose orphan or corrupted data records.
-- 4. An empty result set guarantees 100% accurate data parity between both tables.
