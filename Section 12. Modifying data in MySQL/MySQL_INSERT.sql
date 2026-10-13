-- MySQL INSERT

-- MySQL INSERT
-- INSERT adds one or more new rows to a table.
--
-- Syntax (one row):
--   INSERT INTO table_name(column1, column2, ...)
--   VALUES (value1, value2, ...);
--
-- Rules:
--   1. The number of columns must match the number of values.
--   2. The ORDER must match: the first column gets the first value,
--      the second column gets the second value, and so on.

-- Syntax (many rows at once):
--   INSERT INTO table_name(column1, column2, ...)
--   VALUES
--     (value1, value2, ...),
--     (value1, value2, ...),
--     (value1, value2, ...);
-- Rows are separated by commas.

-- SETUP: the table we will practice on
-- DROP TABLE IF EXISTS deletes the old table first, so you can re-run safely.
create database ModifyingData;
use ModifyingData;
DROP TABLE IF EXISTS tasks;

CREATE TABLE tasks (
    task_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    start_date DATE,
    due_date DATE,
    priority TINYINT NOT NULL DEFAULT 3,   -- if not given, priority is 3
    description TEXT
);

-- 1) Basic INSERT
-- We only give title and priority. For the other columns MySQL uses:
--   task_id     -> next number (AUTO_INCREMENT)
--   start_date  -> NULL (no default, so NULL)
--   due_date    -> NULL
--   description -> NULL

INSERT INTO tasks(title, priority)
VALUES ('Learn MySQL INSERT Statement', 1);

SELECT * FROM tasks;

-- 2) Using a column's default value
-- Two ways to get the default:
--   a) Leave the column out of the INSERT completely.
--   b) Write the column name and use the DEFAULT keyword as its value.
-- Here we use way (b). The default for priority is 3, so 3 is inserted.

INSERT INTO tasks(title, priority)
VALUES ('Understanding DEFAULT keyword', DEFAULT);

SELECT * FROM tasks;

-- 3) Inserting dates
-- A date is written as a string in this format: 'YYYY-MM-DD'
--   YYYY = 4-digit year, MM = 2-digit month, DD = 2-digit day

INSERT INTO tasks(title, start_date, due_date)
VALUES ('Insert date into table', '2018-01-09', '2018-09-15');

-- You can also use functions (expressions) inside VALUES.
-- CURRENT_DATE() returns today's date.

INSERT INTO tasks(title, start_date, due_date)
VALUES ('Use current date for the task', CURRENT_DATE(), CURRENT_DATE());

SELECT * FROM tasks;

-- 4) Inserting multiple rows
-- One INSERT, many rows, separated by commas.
-- This is faster than running many separate INSERT statements.

INSERT INTO tasks(title, priority)
VALUES
    ('My first task', 1),
    ('It is the second task', 2),
    ('This is the third task of the week', 3);

-- MySQL replies with a message like:
--   Records: 3  Duplicates: 0  Warnings: 0
-- Records = rows inserted, Duplicates = rows skipped as duplicates,
-- Warnings = problems MySQL noticed.

SELECT * FROM tasks;

-- 5) A table with only an AUTO_INCREMENT column
-- If every column can fill itself in, you can insert with empty VALUES().

CREATE TABLE t (
    id INT AUTO_INCREMENT PRIMARY KEY
);

INSERT INTO t VALUES ();

SELECT * FROM t;

-- SUMMARY
-- 1. INSERT INTO table(columns) VALUES (values); adds a row.
-- 2. Columns and values must match in number and order.
-- 3. Columns you leave out get their default value (or NULL if no default).
-- 4. Use the DEFAULT keyword to insert a column's default on purpose.
-- 5. Dates use the format 'YYYY-MM-DD'.
-- 6. Functions like CURRENT_DATE() can be used inside VALUES.
-- 7. Separate rows with commas to insert many rows in one statement.
-- 8. INSERT INTO t VALUES (); works when all columns fill themselves in.