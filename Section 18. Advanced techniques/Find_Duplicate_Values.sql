-- How To Find Duplicate Values in MySQL

-- Data duplication happens for many reasons. Finding duplicates is an important 
-- database administration task used to clean and validate your data tables.
--
-- The Core Logic:
--   1. Use GROUP BY to bundle identical column values into single clusters.
--   2. Use COUNT() in a HAVING clause to filter out any group with more than 1 row.

-- Step 1: Select your database context
USE classicmodels;

-- Step 2: Setup a sample address book table to hold test data
CREATE TABLE IF NOT EXISTS contactss (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(255) NOT NULL
);

-- Step 3: Insert sample data with intentional multi-row duplicate names and emails

INSERT INTO contactss (first_name, last_name, email) 
VALUES ('Carine ', 'Schmitt', 'carine.schmitt@verizon.net'),
       ('Jean', 'King', 'jean.king@me.com'),
       ('Peter', 'Ferguson', 'peter.ferguson@google.com'),
       ('Janine ', 'Labrune', 'janine.labrune@aol.com'),
       ('Jonas ', 'Bergulfsen', 'jonas.bergulfsen@mac.com'),
       ('Janine ', 'Labrune', 'janine.labrune@aol.com'), -- Duplicate
       ('Susan', 'Nelson', 'susan.nelson@comcast.net'),
       ('Zbyszek ', 'Piestrzeniewicz', 'zbyszek.piestrzeniewicz@att.net'),
       ('Roland', 'Keitel', 'roland.keitel@yahoo.com'),
       ('Julie', 'Murphy', 'julie.murphy@yahoo.com'),
       ('Kwai', 'Lee', 'kwai.lee@google.com'),
       ('Jean', 'King', 'jean.king@me.com'),              -- Duplicate
       ('Susan', 'Nelson', 'susan.nelson@comcast.net'),    -- Duplicate
       ('Roland', 'Keitel', 'roland.keitel@yahoo.com');    -- Duplicate

-- Step 4: Review raw data ordered by email to spot duplicates visually
SELECT * FROM contactss  ORDER BY email;

-- METHOD 1: FINDING DUPLICATE VALUES IN A SINGLE COLUMN
  -- Use this template when you only care if one specific field repeats across rows.

SELECT 
    email, 
    COUNT(email) -- AS occurrence_count
FROM contactss
GROUP BY email
HAVING COUNT(email) > 1;



-- METHOD 2: FINDING DUPLICATE VALUES IN MULTIPLE COLUMNS
-- Rows are only considered duplicates if the entire *combination* of target fields 
-- repeats. We connect conditions using the AND operator in the HAVING clause.

SELECT 
    first_name, COUNT(first_name) AS first_name_count,
    last_name,  COUNT(last_name)  AS last_name_count,
    email,      COUNT(email)      AS email_count
FROM contactss
GROUP BY 
    first_name, 
    last_name, 
    email
HAVING COUNT(first_name) > 1
   AND COUNT(last_name) > 1
   AND COUNT(email) > 1;

-- SUMMARY CHECKLIST
-- 1. Single Column Check: GROUP BY col HAVING COUNT(col) > 1;
-- 2. Multi-Column Check: GROUP BY col1, col2 HAVING COUNT(c1) > 1 AND COUNT(c2) > 1;
-- 3. Always apply aggregation functions to the columns that you are evaluating.
