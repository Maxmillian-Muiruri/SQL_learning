-- MySQL UPDATE JOIN

-- UPDATE JOIN changes rows in one table using values from ANOTHER table.
-- Use it when the data you need for the update lives in a related table.
--
-- Syntax:
--   UPDATE T1
--   [INNER JOIN | LEFT JOIN] T2 ON T1.C1 = T2.C1
--   SET T1.C2 = T2.C2,
--       T2.C3 = expr
--   WHERE condition;
--
-- How it works:
--   1. UPDATE T1: the main table you want to change.
--   2. INNER JOIN or LEFT JOIN T2 ON ...: link to the other table.
--      The JOIN must come right after UPDATE.
--   3. SET: the new values. You can use columns from either table.
--   4. WHERE: optional filter for which rows to update.
--
-- INNER JOIN: only rows that have a match in BOTH tables are updated.
-- LEFT JOIN:  every row of T1 is updated, even if T2 has no match
--             (the T2 columns are NULL for those rows).
--
-- The older way to write a cross-table update (a comma between tables
-- instead of JOIN) behaves like an INNER JOIN:
--   UPDATE T1, T2
--   SET T1.c2 = T2.c2
--   WHERE T1.c1 = T2.c1 AND condition;

-- SETUP: a small "hr" database with two tables
--   merits:    performance score -> raise percentage
--   employees: employee data, with a performance score and a salary


CREATE DATABASE IF NOT EXISTS hrr;
USE hrr;

DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS merits;

CREATE TABLE merits (
    performance INT PRIMARY KEY,
    percentage DEC(11, 2) NOT NULL
);

CREATE TABLE employees (
    emp_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_name VARCHAR(255) NOT NULL,
    performance INT DEFAULT NULL,
    salary DEC(11, 2) DEFAULT NULL,
    FOREIGN KEY (performance) REFERENCES merits (performance)
);

INSERT INTO merits(performance, percentage)
VALUES
    (1, 0),
    (2, 0.01),
    (3, 0.03),
    (4, 0.05),
    (5, 0.08);

INSERT INTO employees(emp_name, performance, salary)
VALUES
    ('Mary Doe', 1, 50000),
    ('Cindy Smith', 3, 65000),
    ('Sue Greenspan', 4, 75000),
    ('Grace Dell', 5, 125000),
    ('Nancy Johnson', 3, 85000),
    ('John Doe', 2, 45000),
    ('Lily Bush', 3, 55000);

-- Workbench safe update mode (Error 1175) blocks updates without a
-- key in WHERE. The examples below have no WHERE, so turn it off first.
SET SQL_SAFE_UPDATES = 0;

-- EXAMPLE 1: UPDATE with INNER JOIN
-- Goal: raise each employee's salary by a percentage based on performance.
-- The percentage is in merits, the salary is in employees, so we JOIN them.

UPDATE employees
INNER JOIN merits ON employees.performance = merits.performance
SET salary = salary + salary * percentage;

-- MySQL replies:
--   Rows matched: 7  Changed: 6
-- 7 rows matched, but only 6 changed. Mary Doe has performance 1, whose
-- percentage is 0, so her salary stayed the same.
--
-- There is no WHERE here, so ALL matching rows are updated.
-- Formula: new salary = salary + salary * percentage
--   Example: 65000 + 65000 * 0.03 = 66950

SELECT * FROM employees;

-- EXAMPLE 2: UPDATE with LEFT JOIN
-- New situation: two new hires have no performance score yet (NULL).

-- Reset the table (TRUNCATE empties it and restarts emp_id at 1)
TRUNCATE TABLE employees;

INSERT INTO employees(emp_name, performance, salary)
VALUES
    ('Mary Doe', 1, 50000),
    ('Cindy Smith', 3, 65000),
    ('Sue Greenspan', 4, 75000),
    ('Grace Dell', 5, 125000),
    ('Nancy Johnson', 3, 85000),
    ('John Doe', 2, 45000),
    ('Lily Bush', 3, 55000),
    ('Jack William', NULL, 43000),
    ('Ricky Bond', NULL, 52000);

SELECT * FROM employees;

-- INNER JOIN would SKIP the new hires, because NULL matches nothing
-- in merits. LEFT JOIN keeps them, with percentage = NULL.

-- COALESCE(a, b) returns a if it is not NULL, otherwise b.
-- COALESCE(percentage, 0.015) means:
--   use the merit percentage if there is one, otherwise use 1.5%.

UPDATE employees
LEFT JOIN merits ON employees.performance = merits.performance
SET salary = salary + salary * COALESCE(percentage, 0.015);

-- MySQL replies:
--   Rows matched: 9  Changed: 8
-- All 9 rows matched, 8 changed. Mary Doe again stayed the same (0%).
--   Example: 43000 + 43000 * 0.015 = 43645

SELECT * FROM employees;

-- Turn safe update mode back on
SET SQL_SAFE_UPDATES = 1;

-- SUMMARY
-- 1. UPDATE JOIN updates one table using data from another table.
-- 2. INNER JOIN updates only rows that match in both tables.
-- 3. LEFT JOIN updates every row of the main table, even with no match.
-- 4. Use COALESCE(value, default) to handle the NULLs a LEFT JOIN creates.
-- 5. Without WHERE, all matched rows are updated.
-- 6. "Rows matched" counts rows found, "Changed" counts rows that
--    actually got a different value.