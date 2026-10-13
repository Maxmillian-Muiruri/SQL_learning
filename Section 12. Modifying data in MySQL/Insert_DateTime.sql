-- MySQL Insert DateTime

-- The DATETIME data type is used to store both date and time values. To define a column with the DATETIME data type,

-- Syntax:
--   column_name DATETIME

-- Required format when inserting:
--   'YYYY-MM-DD HH:MM:SS'
--   Example: '2023-10-28 19:30:35'

-- If your date and time are in a different format, you must convert  them to this format first (see Example 3).

-- SETUP: the table we will practice on

CREATE TABLE events (
    id INT AUTO_INCREMENT PRIMARY KEY,
    event_name VARCHAR(255) NOT NULL,
    event_time DATETIME NOT NULL
);

-- EXAMPLE 1: Insert a datetime value
-- Write the value as a string in the 'YYYY-MM-DD HH:MM:SS' format.

INSERT INTO events(event_name, event_time)
VALUES ('MySQL tutorial livestream', '2023-10-28 19:30:35');

SELECT * FROM events;

-- EXAMPLE 2: Insert the current date and time
-- NOW() returns the current date and time, so you don't type it yourself.

INSERT INTO events(event_name, event_time)
VALUES ('MySQL Workshop', NOW());

SELECT * FROM events;

-- EXAMPLE 3: Insert a datetime written in another format
-- If the string is NOT in 'YYYY-MM-DD HH:MM:SS' format, use
-- STR_TO_DATE(string, format) to convert it.
--
-- The second argument describes how your string is laid out:
--   %m = month (01-12)
--   %d = day (01-31)
--   %Y = 4-digit year
--   %H = hour in 24-hour time (00-23)
--   %i = minutes (00-59)
--   %s = seconds (00-59)
--
-- Here the string is month/day/year, so the format is '%m/%d/%Y %H:%i:%s'.

INSERT INTO events(event_name, event_time)
VALUES ('MySQL Party',
        STR_TO_DATE('10/28/2023 20:00:00', '%m/%d/%Y %H:%i:%s'));

SELECT * FROM events;

-- EXTRA 
-- To SHOW a DATETIME in a friendlier format, use DATE_FORMAT.
-- %p = AM/PM, %h = hour in 12-hour time (01-12)
SELECT event_name,
       DATE_FORMAT(event_time, '%d/%m/%Y %h:%i %p') AS friendly_time
FROM events;

-- SUMMARY
-- 1. DATETIME holds a date and a time together.
-- 2. Insert it as 'YYYY-MM-DD HH:MM:SS'.
-- 3. Use NOW() to insert the current date and time.
-- 4. Use STR_TO_DATE() to convert a string in another format.
-- 5. STR_TO_DATE reads a string into a DATETIME, and DATE_FORMAT shows a DATETIME as a string.