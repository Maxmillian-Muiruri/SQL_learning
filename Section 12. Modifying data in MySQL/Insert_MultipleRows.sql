-- MySQL Insert Multiple Rows

-- MySQL INSERT Multiple Rows
-- You can insert many rows with ONE INSERT statement.

-- Syntax:
--   INSERT INTO table_name (column_list)
--   VALUES
--     (value_list_1),
--     (value_list_2),

--     (value_list_n);
--
-- How it works:
--   1. Write the table name after INSERT INTO.
--   2. List the columns you want to fill. This list is optional, but if
--      you write it, every row must give a value for each listed column.
--   3. After VALUES, write one set of values per row, separated by commas.
--      Each set must have the same number of values as the column list.

-- To insert rows that come from another query, use INSERT INTO ... SELECT
-- instead of VALUES.

-- The size limit: max_allowed_packet
-- In theory there is no limit on the number of rows.
-- In practice, if the whole INSERT statement is bigger than the
-- max_allowed_packet setting, MySQL gives a "packet too large" error
-- and closes the connection.

-- See the current limit (the number is in BYTES, yours may differ)
SHOW VARIABLES LIKE 'max_allowed_packet';

-- Change the limit (size is in bytes)
-- SET GLOBAL max_allowed_packet = 67108864;

-- This limit does NOT apply to INSERT INTO ... SELECT,
-- which can insert as many rows as you want.

-- EXAMPLE 1: Insert multiple rows

CREATE TABLE projects (
    project_id INT AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    start_date DATE,
    end_date DATE,
    PRIMARY KEY (project_id)
);

-- Two rows in one statement
INSERT INTO projects(name, start_date, end_date)
VALUES
    ('AI for Marketing', '2019-08-01', '2019-12-31'),
    ('ML for Sales', '2019-05-15', '2019-11-20');

-- MySQL replies: Query OK, 2 rows affected

SELECT * FROM projects;

-- EXAMPLE 2: LAST_INSERT_ID() with multiple rows
-- LAST_INSERT_ID() gives the last AUTO_INCREMENT id that was generated.
-- Careful: after a multi-row INSERT, it returns the id of the FIRST
-- row inserted by that statement, NOT the last one.

INSERT INTO projects(name, start_date, end_date)
VALUES
    ('NeuroSynthIQ', '2023-12-01', '2024-12-31'),
    ('QuantumMind Explorer', '2023-05-15', '2024-12-20'),
    ('SentientBot Assistant', '2023-05-15', '2024-10-20');

SELECT * FROM projects;
-- The three new rows got ids 3, 4, and 5.

SELECT LAST_INSERT_ID();
-- Returns 3 (the FIRST of the new rows), not 5.

-- To work out the last id yourself:
--   last id = LAST_INSERT_ID() + (number of rows inserted) - 1
--   here: 3 + 3 - 1 = 5
SELECT LAST_INSERT_ID() + ROW_COUNT() - 1;
-- Run this right after the INSERT, because ROW_COUNT() refers
-- to the most recent statement.

-- SUMMARY
-- 1. Separate rows with commas after VALUES to insert many rows at once.
-- 2. Each row needs the same number of values as the column list.
-- 3. A huge INSERT can hit the max_allowed_packet limit.
-- 4. max_allowed_packet does not affect INSERT INTO ... SELECT.
-- 5. LAST_INSERT_ID() returns the FIRST id of a multi-row insert.
