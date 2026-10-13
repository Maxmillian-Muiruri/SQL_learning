
-- MySQL DATE dataType
-- DATE stores only a date (no time).
-- Format: YYYY-MM-DD (fixed, you cannot change it)
-- Example: 2026-10-11

-- Uses 3 bytes of storage.
-- Range: 1000-01-01 to 9999-12-31
-- For dates outside this range, DATE will not work.

-- Want a different display format, like mm/dd/yyyy?
-- You can't change how DATE is stored, but you can change how it
-- is SHOWN with the DATE_FORMAT function (see Part 3).


-- PART 1: Using DATE in a table

CREATE TABLE people (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    birth_date DATE NOT NULL
);

INSERT INTO people(first_name, last_name, birth_date)
VALUES ('John', 'Doe', '1990-09-01');

SELECT first_name, last_name, birth_date FROM people;
-- John | Doe | 1990-09-01

-- PART 2: Two-digit years (avoid these)

-- MySQL always stores 4-digit years, but it accepts 2-digit years
-- and converts them using these rules:
--   00 to 69  ->  2000 to 2069
--   70 to 99  ->  1970 to 1999
-- This is confusing, so always write the full 4-digit year.

INSERT INTO people(first_name, last_name, birth_date)
VALUES ('Jack', 'Daniel', '01-09-01'),   -- year 01 -> 2001
       ('Lily', 'Bush',   '80-09-01');   -- year 80 -> 1980

SELECT first_name, last_name, birth_date FROM people;
-- Jack | Daniel | 2001-09-01
-- Lily | Bush   | 1980-09-01


-- PART 3: Useful DATE functions

-- Current date AND time
SELECT NOW();
-- e.g. 2026-10-11 16:01:00

-- Only the date part of a date+time value
SELECT DATE(NOW());
-- e.g. 2026-10-11

-- Today's date (no time)
SELECT CURDATE();
-- e.g. 2026-10-11

-- Change how a date is displayed
-- %m = month, %d = day, %Y = 4-digit year
SELECT DATE_FORMAT(CURDATE(), '%m/%d/%Y') AS today;
-- e.g. 10/11/2026

-- Days between two dates (first date minus second date)
SELECT DATEDIFF('2015-11-04', '2014-11-04') AS days;
-- 365

-- Add time to a date: DATE_ADD
SELECT
    '2015-01-01' AS start,
    DATE_ADD('2015-01-01', INTERVAL 1 DAY)   AS one_day_later,    -- 2015-01-02
    DATE_ADD('2015-01-01', INTERVAL 1 WEEK)  AS one_week_later,   -- 2015-01-08
    DATE_ADD('2015-01-01', INTERVAL 1 MONTH) AS one_month_later,  -- 2015-02-01
    DATE_ADD('2015-01-01', INTERVAL 1 YEAR)  AS one_year_later;   -- 2016-01-01

-- Subtract time from a date: DATE_SUB
SELECT
    '2015-01-01' AS start,
    DATE_SUB('2015-01-01', INTERVAL 1 DAY)   AS one_day_before,    -- 2014-12-31
    DATE_SUB('2015-01-01', INTERVAL 1 WEEK)  AS one_week_before,   -- 2014-12-25
    DATE_SUB('2015-01-01', INTERVAL 1 MONTH) AS one_month_before,  -- 2014-12-01
    DATE_SUB('2015-01-01', INTERVAL 1 YEAR)  AS one_year_before;   -- 2014-01-01

-- Pull out one part of a date
SELECT
    DAY('2000-12-31')     AS day,       -- 31
    MONTH('2000-12-31')   AS month,     -- 12
    QUARTER('2000-12-31') AS quarter,   -- 4
    YEAR('2000-12-31')    AS year;      -- 2000

-- Week information
SELECT
    WEEKDAY('2000-12-31')    AS weekday,     -- 6  (Monday = 0 ... Sunday = 6)
    WEEK('2000-12-31')       AS week,        -- 53 (default: counting starts at 0)
    WEEKOFYEAR('2000-12-31') AS weekofyear;  -- 52 (calendar week)

-- WEEK with a second argument of 1 changes how weeks are counted
SELECT WEEK('2000-12-31', 1) AS week;        -- 52

-- SUMMARY

-- Current date and time	NOW()
-- Today’s date only	CURDATE()
-- Date part of a date and time	DATE(value)
-- Show a date in another format	DATE_FORMAT(date, '%m/%d/%Y')
-- Days between two dates	DATEDIFF(later, earlier)
-- Add days, weeks, months, or years	DATE_ADD(date, INTERVAL 1 MONTH)
-- Subtract days, weeks, months, or years	DATE_SUB(date, INTERVAL 1 MONTH)
-- Get the day, month, quarter, or year	DAY(), MONTH(), QUARTER(), YEAR()

-- 1. DATE = date only, format YYYY-MM-DD, range 1000 to 9999.
-- 2. The storage format is fixed. Use DATE_FORMAT to change how it looks.
-- 3. Avoid 2-digit years (00-69 -> 2000s, 70-99 -> 1900s).
-- 4. Handy functions: NOW, CURDATE, DATE, DATE_FORMAT, DATEDIFF,
--    DATE_ADD, DATE_SUB, DAY, MONTH, QUARTER, YEAR, WEEK, WEEKDAY.