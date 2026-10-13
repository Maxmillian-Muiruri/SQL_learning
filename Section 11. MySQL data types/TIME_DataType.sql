-- MySQL TIME Data Type

-- TIME stores a time of day (no date).
-- Format: HH:MM:SS  (example: 16:06:00)
--
-- TIME can also store a DURATION (time between two events),
-- which can be longer than 24 hours: HHH:MM:SS (example: 120:30:00)
--
-- Range: -838:59:59 to 838:59:59
-- (negative values are allowed, useful for durations)

-- Syntax:
--   start_at TIME         
--   begin_at TIME(3)       
-- TIME(3) example value: 08:00:00.123


-- Storage size (you don't need to memorize this)
-- TIME or TIME(0)   -> 3 bytes
-- TIME(1), TIME(2)  -> 4 bytes
-- TIME(3), TIME(4)  -> 5 bytes
-- TIME(5), TIME(6)  -> 6 bytes
-- Rule: 3 bytes base, plus extra bytes for fractional seconds.

-- PART 1: Using TIME in a table

CREATE TABLE tests (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    start_at TIME,
    end_at TIME
);

INSERT INTO tests(name, start_at, end_at)
VALUES ('Test 1', '08:00:00', '10:00:00');

SELECT name, start_at, end_at FROM tests;

-- PART 2: Different ways to write a TIME value (literals)

-- Without colons: 'HHMMSS'
INSERT INTO tests(name, start_at, end_at)
VALUES ('Test 2', '083000', '101500');

-- Invalid time -> error
-- 108000 would mean 10 hours, 80 minutes. 80 minutes is not valid.
INSERT INTO tests(name, start_at, end_at)
VALUES ('Test invalid', '083000', '108000');
-- Error 1292: Incorrect time value: '108000' for column 'end_at'

-- As a number (no quotes): HHMMSS
INSERT INTO tests(name, start_at, end_at)
VALUES ('Test 3', 082000, 102000);

-- One digit is allowed when you use colons: 9:5:0 = 09:05:00
INSERT INTO tests(name, start_at, end_at)
VALUES ('Test 4', '9:5:0', 100500);

SELECT * FROM tests;


-- For durations (time intervals) you can also use:
--   'D HH:MM:SS'  (D = days, 0 to 34)
--   'HH:MM', 'D HH:MM', 'D HH', or 'SS'
-- Example: '1 02:30:00' means 1 day + 2 hours 30 minutes = 26:30:00

-- PART 3: Useful TIME functions

-- 1) Current time of the server
SELECT
    CURRENT_TIME()     AS string_now,    =
    CURRENT_TIME() + 0 AS numeric_now;   

-- 2) Add and subtract time
-- ADDTIME(time, amount)  and  SUBTIME(time, amount)
-- 023000 means 2 hours 30 minutes
SELECT
    CURRENT_TIME(),                        
    ADDTIME(CURRENT_TIME(), 023000),      
    SUBTIME(CURRENT_TIME(), 023000);

-- Difference between two times: TIMEDIFF(later, earlier)
SELECT name, TIMEDIFF(end_at, start_at) AS duration
FROM tests;

-- 3) Change how a time is displayed: TIME_FORMAT
-- %h = hours (01-12)
-- %i = minutes (00-59)
-- %p = AM or PM
SELECT
    name,
    TIME_FORMAT(start_at, '%h:%i %p') AS start_at,
    TIME_FORMAT(end_at,   '%h:%i %p') AS end_at
FROM tests;


-- 4) Pull out hour, minute, second
SELECT
    start_at,
    HOUR(start_at)   AS hour,
    MINUTE(start_at) AS minute,
    SECOND(start_at) AS second
FROM tests;

-- 5) UTC time (compare with your server's local time)
SELECT
    CURRENT_TIME(),   
    UTC_TIME();

-- SUMMARY

-- 1. TIME = time of day OR a duration, range -838:59:59 to 838:59:59.
-- 2. Add (N) for fractional seconds, e.g. TIME(3), up to 6 digits.
-- 3. Accepts '08:30:00', '083000', 083000, and '9:5:0'.
-- 4. Invalid values (like 80 minutes) give Error 1292.
-- 5. Handy functions: CURRENT_TIME, ADDTIME, SUBTIME, TIMEDIFF,
--    TIME_FORMAT, HOUR, MINUTE, SECOND, UTC_TIME.