-- GETTING MYSQL ROW COUNTS

-- This guide documents 4 techniques for counting rows:
--   1) Counting rows in a single table
--   2) Counting rows across multiple targeted tables (UNION)
--   3) Dynamically counting ALL tables using Prepared Statements (100% Accurate)
--   4) Quick metadata counts using information_schema (Fastest, but can be inaccurate)


-- Choose your database context
USE classicmodels;

-- METHOD 1: ROW COUNT OF A SINGLE TABLE
-- The standard, most reliable way to count rows in a specific table.

SELECT COUNT(*) FROM customers;



-- METHOD 2: ROW COUNT OF TWO OR MORE SPECIFIC TABLES
-- Use UNION to run separate COUNT queries and combine them into a clean overview list.

SELECT 
    'customers' tablename, 
     COUNT(*) rows
FROM
    customers 
UNION 
SELECT 
    'orders' tablename, 
     COUNT(*) rows
FROM
    orders;





-- METHOD 3: DYNAMIC COUNT FOR ALL TABLES IN A DATABASE (100% ACCURATE)

-- First, get all table names in the database
-- Second, construct an SQL statement that includes all SELECT COUNT(*) FROM table_name
--  statements for all tables separated by UNION.

SELECT 
    table_name
FROM
    information_schema.tables
WHERE
    table_schema = 'classicmodels'
        AND table_type = 'BASE TABLE';
        
-- Second, to construct the SQL statement, we use the GROUP_CONCATand CONCATfunctions 
SELECT 
    CONCAT(GROUP_CONCAT(CONCAT('SELECT \'',
                        table_name,
                        '\' table_name,COUNT(*) rows FROM ',
                        table_name)
                SEPARATOR ' UNION '),
            ' ORDER BY table_name')
INTO @sql 
FROM
    table_list;
 

-- Execute the generated statement string stored in @sql
PREPARE s FROM @sql;
EXECUTE s;
DEALLOCATE PREPARE s;


-- METHOD 4:Getting MySQL row count of all tables in a database with one query 

-- You can read table metadata from the `information_schema` table instantly. 
--
--  This method is sometimes inaccurate because values are cached 
-- and are not perfectly synchronized in real time.
-- [THE FIX]: Run `ANALYZE TABLE` right before running your query to force an update.

-- Step 1: Update the cached system statistics for accuracy
ANALYZE TABLE customers, employees, offices, orderdetails, orders, payments, productlines, products;

-- Step 2: Run the instant estimation query
SELECT 
    table_name, 
    table_rows
FROM information_schema.tables
WHERE table_schema = 'classicmodels'
ORDER BY table_name;


-- SUMMARY CHECKLIST
-- 1. For single tables: Use SELECT COUNT(*).
-- 2. For multi-table combinations: Use UNION to group results.
-- 3. For instant overview maps: Query information_schema.tables (after ANALYZE TABLE).
-- 4. For perfect database snapshots: Build dynamic SQL strings using @variables.
