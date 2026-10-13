--  DELETING DUPLICATE ROWS IN MYSQL
-- Once duplicate rows are identified, you must clean your tables by deleting them.
-- This file documents 3 production methods to remove duplicates securely:
--   1) DELETE JOIN (Self-join filtering by ID comparison)
--   2) Intermediate Table Strategy (Rebuilding with GROUP BY / DISTINCT data)
--   3) ROW_NUMBER() Window Function (Modern MySQL 8.0+ partition method)

-- Step 1: Select your database context
DROP DATABASE IF EXISTS advanced;
create database  advanced;
USE advanced;

-- Step 2: Prepare sample data workspace (Run this to reset tables for tests)
DROP TABLE IF EXISTS contacts;

CREATE TABLE contacts (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL, 
    email VARCHAR(255) NOT NULL
);

INSERT INTO contacts (first_name,last_name,email) 
VALUES ('Carine ','Schmitt','carine.schmitt@verizon.net'),
       ('Jean','King','jean.king@me.com'),
       ('Peter','Ferguson','peter.ferguson@google.com'),
       ('Janine ','Labrune','janine.labrune@aol.com'),
       ('Jonas ','Bergulfsen','jonas.bergulfsen@mac.com'),
       ('Janine ','Labrune','janine.labrune@aol.com'),
       ('Susan','Nelson','susan.nelson@comcast.net'),
       ('Zbyszek ','Piestrzeniewicz','zbyszek.piestrzeniewicz@att.net'),
       ('Roland','Keitel','roland.keitel@yahoo.com'),
       ('Julie','Murphy','julie.murphy@yahoo.com'),
       ('Kwai','Lee','kwai.lee@google.com'),
       ('Jean','King','jean.king@me.com'),
       ('Susan','Nelson','susan.nelson@comcast.net'),
       ('Roland','Keitel','roland.keitel@yahoo.com');

SELECT * FROM contacts
ORDER BY email;

-- Check duplicate baselines before execution
SELECT email, COUNT(email) FROM contacts GROUP BY email HAVING COUNT(email) > 1;

-- METHOD 1: USING THE "DELETE JOIN" STATEMENT (FASTEST & MOST COMMON)
-- This performs a self-join to compare records with identical unique parameters 
-- (like email) and eliminates the row based on structural ID comparison.

-- SCENARIO A: Delete duplicates but KEEP the HIGHEST ID row
DELETE t1 FROM contacts t1
INNER JOIN contacts t2 
WHERE t1.id < t2.id 
  AND t1.email = t2.email;

-- [RESET TIP]: Re-run Step 2 to refill identical test data before running below:

-- SCENARIO B: Delete duplicates but KEEP the LOWEST ID row
  

-- METHOD 2: USING AN INTERMEDIATE TEMPORARY TABLE

 -- Safe architectural pattern for large data cleanups or legacy database engines:
-- Step 1: Create a clone structure of the table.
-- Step 2: Extract and insert only unique records using GROUP BY.
-- Step 3: Swap out tables securely using DROP and RENAME.

-- Step 1: Clone structure layout precisely
CREATE TABLE contacts_temp LIKE contacts;

-- Step 2: Pipe unique records across to the staging layout
INSERT INTO contacts_temp
SELECT * FROM contacts GROUP BY email;

-- Step 3: Drop corrupted source and swap the clean table into production
DROP TABLE contacts;
ALTER TABLE contacts_temp RENAME TO contacts;

-- METHOD 3: USING THE ROW_NUMBER() WINDOW FUNCTION (MYSQL 8.0+)

-- Available starting with MySQL 8.02. This partitions data blocks by the targeted 
-- duplicate column and increments an integer marker for every repetition found.

-- Phase A: Inspecting partition row allocations visually
SELECT 
  id, email, 
  ROW_NUMBER() OVER (PARTITION BY email ORDER BY email) AS row_num 
FROM contacts;

-- Phase B: Purging any data allocation tracking higher than row number 1
DELETE FROM contacts 
WHERE id IN (
    SELECT id 
    FROM (
        SELECT id, 
               ROW_NUMBER() OVER (PARTITION BY email ORDER BY email) AS row_num 
        FROM contacts
    ) t 
    WHERE row_num > 1
);

-- SUMMARY CHECKLIST
-- 
-- 1. DELETE JOIN: Simplest method. Filter `t1.id < t2.id` to retain high primary keys.
-- 2. Intermediary Table: Highly secure method. Filters duplicates out via GROUP BY.
-- 3. ROW_NUMBER(): Modern system pattern. Isolates data row windows via CTE/Subqueries.
