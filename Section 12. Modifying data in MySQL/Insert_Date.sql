-- MySQL Insert Date

-- DATE stores only a date no time
-- Syntax:
--   column_name DATE

-- Required format when inserting:
--   'YYYY-MM-DD'
--   YYYY = 4-digit year (2026)
--   MM   = 2-digit month (10)
--   DD   = 2-digit day (11)

-- Valid range: '1000-01-01' to '9999-12-31'
-- An invalid date gives an error (see Example 2).

-- example

CREATE TABLE eventss (
    id INT AUTO_INCREMENT PRIMARY KEY,
    event_name VARCHAR(255) NOT NULL,
    event_date DATE NOT NULL
);

-- EXAMPLE 1: Insert a date value
-- Write the date as a string in the 'YYYY-MM-DD' format.

INSERT INTO eventss(event_name, event_date)
VALUES ('MySQL Conference', '2023-10-29');

SELECT event_name, event_date
FROM eventss;

-- EXAMPLE 2: An invalid date causes an error
-- There is no day 39 in any month, so MySQL rejects it.

INSERT INTO eventss(event_name, event_date)
VALUES ('MySQL Database Design Workshop', '2023-10-39');
-- Error 1292: Incorrect date value: '2023-10-39' for column 'event_date'

-- EXAMPLE 3: Insert the current date
-- CURRENT_DATE returns today's date from the database SERVER.

INSERT INTO eventss(event_name, event_date)
VALUES ('MySQL Replication Workshop', CURRENT_DATE);

-- UTC_DATE() returns today's date in UTC (world standard time).
-- It can differ from CURRENT_DATE when the server's time zone is
-- not UTC, especially near midnight.

INSERT INTO eventss(event_name, event_date)
VALUES ('MySQL Day in kenya', UTC_DATE());

SELECT event_name, event_date
FROM eventss;

-- EXAMPLE 4: Insert a date written in another format
-- If the string is NOT 'YYYY-MM-DD', convert it with
-- STR_TO_DATE(string, format).
--   %m = month (01-12)
--   %d = day (01-31)
--   %Y = 4-digit year
-- The string below is month/day/year, so the format is '%m/%d/%Y'.

INSERT INTO eventss(event_name, event_date)
VALUES ('MySQL Innovate', STR_TO_DATE('11/10/2026', '%m/%d/%Y'));

SELECT event_name, event_date
FROM eventss;

-- SUMMARY
-- 1. DATE holds a date only. Insert it as 'YYYY-MM-DD'.
-- 2. Valid range is 1000-01-01 to 9999-12-31.
-- 3. An invalid date (like 2023-10-39) gives Error 1292.
-- 4. CURRENT_DATE inserts the server's current date.
-- 5. UTC_DATE() inserts the current date in UTC.
-- 6. STR_TO_DATE() converts a date string in another format.