-- Introduction to MySQL BIT data type


-- BIT data type that allows you to store bit values, which are 0 and 1.

-- BIT literals 

-- To specify a bit value literal, you use b'val' or 0bval notation, which val is a binary value that contains only 0 and 1.

-- MySQL BIT data type examples 

--  creates a new table named working_calendars that has the days column is BIT(7):

CREATE TABLE working_calendars(
    year INT,
    week INT,
    days BIT(7),
    PRIMARY KEY(year,week)
);

-- The values in the column days indicate whether the day is a working day or day off

INSERT INTO working_calendars(year,week,days)
VALUES(2017,1,B'1111100');

-- retrieve data from working_calendar

SELECT 
    year, week, days
FROM
    working_calendars;
    
--     The output indicates that the bit value in the  days column is converted into an integer.

--  To represent it as bit values, you use the BIN function:

SELECT 
    year, week, bin(days)
FROM
    working_calendars;

-- Use MySQL BIT data type to store BIT data in a table.



