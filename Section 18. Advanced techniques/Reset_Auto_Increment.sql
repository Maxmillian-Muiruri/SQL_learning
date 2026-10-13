-- MySQL Reset Auto Increment Values

-- The AUTO_INCREMENT attribute automatically handles unique row identity generation.
-- However, after clearing records or during staging, you often need to alter or reset 
-- this sequence generator back to a fresh starting boundary.
--
-- This guide documents 3 techniques along with their structural impacts:
--   1) ALTER TABLE Strategy (Best practice: retains your existing records safely)
--   2) TRUNCATE TABLE Strategy (Wipes out all rows, resets the counter to 1)
--   3) DROP & RECREATE Blueprint (Drastic purge approach that rebuilds the schema)

-- Choose your database context
USE classicmodels;

-- Setup initial baseline test infrastructure
DROP TABLE IF EXISTS items;

CREATE TABLE items (
  id INT AUTO_INCREMENT,
  name VARCHAR(45) NOT NULL,
  PRIMARY KEY (id)
);

-- Seed initial test sample records
INSERT INTO items(name)
VALUES ('Item 1'), ('Item 2'), ('Item 3');

-- Check baseline data allocation entries
SELECT * FROM items;
-- Output holds keys: 1, 2, 3

-- METHOD 1: USING THE "ALTER TABLE" STATEMENT (SAFE & PREFERABLE)
-- Modifies the interior sequence marker without destroying any current records.
--
-- [CRITICAL RULE]: The target reset value MUST be greater than or equal to the 
-- current highest primary key value in the table. You cannot force it below existing data.

-- Step 1: Remove the newest record (id = 3)
DELETE FROM items WHERE id = 3;

-- [The Next-In-Line Issue]: If you write a new record now, MySQL defaults to '4'.
-- Step 2: Intercept and reset the counter back down to 3 explicitly
ALTER TABLE items AUTO_INCREMENT = 3;

-- Step 3: Insert a new item to verify the sequence counter tracking change
INSERT INTO items(name) VALUES ('Items 4');

-- View results to check identity sequence allocation parity
SELECT * FROM items;
-- Success Output: Row values hold ids: 1, 2, 3 ('Items 4' holds 3 instead of 4)

-- METHOD 2: USING THE "TRUNCATE TABLE" STATEMENT

-- Wipes out your table entries cleanly and sets the internal sequence register back 
-- to zero (meaning the next inserted entry will start fresh at identity primary key 1).
--
-- NOTE  This removes all table dataset lines permanently.

TRUNCATE TABLE items;

-- METHOD 3: USING "DROP TABLE" AND "CREATE TABLE"

-- A brute-force method that deletes the entire database table object from the schema 
-- entirely, allowing you to run a fresh CREATE script containing a clean sequence index.
--
-- NOTE: Completely drops index boundaries, triggers, and all table records.

DROP TABLE items;

CREATE TABLE items (
  id INT AUTO_INCREMENT,
  name VARCHAR(45) NOT NULL,
  PRIMARY KEY (id)
);


-- SUMMARY CHECKLIST
-- 1. Modify active indexes safely: Use `ALTER TABLE table_name AUTO_INCREMENT = value;`.
-- 2. Clean out tracking spaces fully: Use `TRUNCATE TABLE table_name;`.
-- 3. Avoid hard coding specific record indexes manually unless counter boundaries match.
