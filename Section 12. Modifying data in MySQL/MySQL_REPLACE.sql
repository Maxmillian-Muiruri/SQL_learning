-- MySQL REPLACE

-- REPLACE inserts a new row, or replaces an existing one.
-- It is a MySQL extension to standard SQL.
--
-- How it works:
--   Step 1. MySQL tries to INSERT the new row.
--   Step 2. If that fails because of a duplicate key (PRIMARY KEY or
--           UNIQUE index), MySQL:
--             a) DELETES the old row that caused the conflict, then
--             b) INSERTS the new row.
--
-- Key points:
--   - MySQL decides whether a row "already exists" using the PRIMARY KEY
--     or a UNIQUE index. If the table has neither, REPLACE acts exactly
--     like INSERT.
--   - You need both INSERT and DELETE privileges on the table.
--   - This is the REPLACE STATEMENT. It is NOT the same as the REPLACE()
--     string function (which swaps text inside a value, like in your
--     UPDATE notes).

-- SETUP: the table we will practice on


CREATE TABLE cities (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    population INT NOT NULL
);

INSERT INTO cities(name, population)
VALUES ('New York', 8008278),
       ('Los Angeles', 3694825),
       ('San Diego', 1223405);

SELECT * FROM cities;

--  1: REPLACE ... VALUES
-- Syntax:
--   REPLACE [INTO] table_name(column_list)
--   VALUES (value_list);
-- It looks like INSERT, with the word REPLACE instead.

-- Goal: change the population of Los Angeles (id 2) to 3696820.
REPLACE INTO cities(id, population)
VALUES (2, 3696820);

SELECT * FROM cities;

-- What happened:
--   1. MySQL tried to insert id 2, but id 2 already exists.
--   2. MySQL deleted the old row with id 2.
--   3. MySQL inserted a NEW row with id 2 and population 3696820.
--   4. We did not give a name, so name became NULL.
--      The old name 'Los Angeles' is gone.
--
-- This is the big difference from UPDATE. UPDATE changes only the columns
-- you name. REPLACE rebuilds the whole row, so columns you leave out get
-- their default value (or NULL).

--  2: REPLACE ... SET
-- Syntax:
--   REPLACE INTO table_name
--   SET column1 = value1,
--       column2 = value2;
-- Looks like UPDATE, but there is no WHERE clause. The row is found
-- through the key you give (here, id).

REPLACE INTO cities
SET id = 4,
    name = 'Phoenix',
    population = 1768980;

SELECT * FROM cities;

-- Columns you leave out of SET get their default value, unlike UPDATE.
-- Id 4 did not exist yet, so this was a plain insert and nothing
-- was deleted.

--  3: REPLACE ... SELECT
-- Syntax:
--   REPLACE INTO table_1(column_list)
--   SELECT column_list
--   FROM table_2
--   WHERE where_condition;
-- Similar to INSERT INTO ... SELECT.

-- Copy the New York row (id 1) into a new row in the same table.
REPLACE INTO cities(name, population)
SELECT name, population
FROM cities
WHERE id = 1;

SELECT * FROM cities;

-- We did not give an id, so AUTO_INCREMENT made a new one (5).
-- Nothing conflicted, so a copy of New York was added.

-- WARNINGS 
--   1. REPLACE deletes the old row first. If a child table has a foreign
--      key to that row with ON DELETE CASCADE, the child rows are deleted
--      too. With ON DELETE RESTRICT, the REPLACE can fail with Error 1451.
--   2. The new row may get a different AUTO_INCREMENT value if you don't
--      give the id.
--   3. A safer way to "insert or update" is INSERT ... ON DUPLICATE KEY
--      UPDATE, which changes only the columns you name:
INSERT INTO cities(id, name, population)
VALUES (2, 'Los Angeles', 3696820)
ON DUPLICATE KEY UPDATE population = VALUES(population);
--      Here id 2 already exists, so only the population is updated and
--      the name stays.

-- SUMMARY
-- 1. REPLACE = INSERT, but if the key already exists, DELETE the old row
--    first and then INSERT the new one.
-- 2. It needs a PRIMARY KEY or UNIQUE index to detect duplicates.
-- 3. Columns you don't give are reset to their default or NULL.
-- 4. Three forms: VALUES, SET, and SELECT.
-- 5. It needs INSERT and DELETE privileges.
-- 6. The REPLACE statement is different from the REPLACE() function.