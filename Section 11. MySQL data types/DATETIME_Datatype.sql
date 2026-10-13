-- MySQL DATETIME Data Type
-- MySQL DATETIME data type allows you to store a value that contains both date and time.

-- when you query data from a DATETIME column, MySQL displays the DATETIME value in the following format:
-- 'YYYY-MM-DD HH:MM:SS'

-- When you insert a value into a DATETIME column, you use the same format. 

INSERT INTO table_name(datetime_column)
VALUES('2023-12-31 15:30:45');

--  to populate a column with the current date and time, you use the result of the CURRENT_TIMESTAMP or NOW() function as the default value.

CREATE TABLE events(
    id INT AUTO_INCREMENT PRIMARY KEY,
    event_name VARCHAR(255) NOT NULL,
    started_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO events(event_name)
VALUES('Connected to MySQL Server');

SELECT * FROM events;

-- MySQL DATETIME vs.TIMESTAMP 
-- MySQL provides another temporal data type that is similar to the DATETIME called  TIMESTAMP.


-- MySQL stores TIMESTAMP in UTC value. However, MySQL stores the DATETIME value as is without timezone
-- First, set the timezone of the current connection to +00:00
SET time_zone = '+00:00';


-- Next, create a table named timestamp_n_datetime that consists of two columns: ts and dt with TIMESTAMP and DATETIME

CREATE TABLE timestamp_n_datetime (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ts TIMESTAMP,
    dt DATETIME
);


-- insert the current date and time into both ts and dt columns of the timestamp_n_datetime table,

INSERT INTO timestamp_n_datetime(ts,dt)
VALUES(NOW(),NOW());
-- After that, query data from the timestamp_n_datetime table.

SELECT 
    ts, 
    dt
FROM
    timestamp_n_datetime;

--  set the connection’s time zone to +03:00 and query data from the timestamp_n_datetime table again.
SET time_zone = '+03:00';
SELECT 
    ts, 
    dt
FROM
    timestamp_n_datetime;

-- MySQL DATETIME functions 

-- MySQL DATE() function 
-- To extract the date portion from a DATETIME value, you use the DATE function as follows:

CREATE TABLE test_dt (
    id INT AUTO_INCREMENT PRIMARY KEY,
    created_at DATETIME
);

INSERT INTO test_dt(created_at)
VALUES('2026-11-10 15:43:36');
  
--    to know which row created
SELECT 
    *
FROM
    test_dt
WHERE
    created_at = '2026-11-10';  -- retirns null 
    
-- because the created_at column contains not only the date but also the time. To correct it, you use the DATE function 

SELECT 
    *
FROM
    test_dt
WHERE
    DATE(created_at) = '2026-11-10';
    
    
--     MySQL TIME function 
-- extract the time portion from a DATETIME value, you use the TIME function
SELECT TIME(@dt);


-- MySQL YEAR, QUARTER, MONTH, WEEK, DAY, HOUR, MINUTE and SECOND functions

SELECT 
    HOUR(@dt),
    MINUTE(@dt),
    SECOND(@dt),
    DAY(@dt),
    WEEK(@dt),
    MONTH(@dt),
    QUARTER(@dt),
    YEAR(@dt);
    
--     MySQL DATE_FORMAT function 

-- To format a DATETIME value, you use the DATE_FORMAT function. 
SELECT DATE_FORMAT(@dt, '%H:%i:%s - %W %M %Y');

-- MySQL DATE_ADD function 
-- add an interval to a DATETIME value, you use DATE_ADD function 
SELECT @dt start, 
       DATE_ADD(@dt, INTERVAL 1 SECOND) '1 second later',
       DATE_ADD(@dt, INTERVAL 1 MINUTE) '1 minute later',
       DATE_ADD(@dt, INTERVAL 1 HOUR) '1 hour later',
       DATE_ADD(@dt, INTERVAL 1 DAY) '1 day later',
       DATE_ADD(@dt, INTERVAL 1 WEEK) '1 week later',
       DATE_ADD(@dt, INTERVAL 1 MONTH) '1 month later',
       DATE_ADD(@dt, INTERVAL 1 YEAR) '1 year later';
       
--       MySQL DATE_DIFF function 
--  To calculate a difference in days between two DATETIME values, you use the DATEDIFF function

--     create a table named datediff_test that has one column whose data type is DATETIME.   
CREATE TABLE datediff_test (
    dt DATETIME
);


-- insert some rows into the datediff_test table.


INSERT INTO datediff_test(dt)
VALUES('2010-04-30 07:27:39'),
	('2020-05-17 22:52:21'),
	('2010-05-18 01:19:10'),
	('2010-05-22 14:17:16'),
	('2010-05-26 03:26:56'),
	('2010-06-10 04:44:38'),
	('2010-06-13 13:55:53');
    
    
    
--      use the DATEDIFF function to compare the current date and time with the value in each row of the datediff_test table.

SELECT 
    dt, 
    DATEDIFF(NOW(), dt)
FROM
    datediff_test;