-- MySQL CHAR Data Type
/*The CHAR data type is a fixed-length character type in MySQL. You often declare the CHAR type with a length that specifies the maximum number of characters that you want to store.
 For example, CHAR(20) can hold up to 20 characters.*/
 
--  First, create a table with a CHAR column.

CREATE TABLE mysql_char_test (
    status CHAR(3)
); 

INSERT INTO mysql_char_test(status)
VALUES('Yes'),('No');


SELECT 
    status, 
    LENGTH(status)
FROM
    mysql_char_test;
    
    INSERT INTO mysql_char_test(status)
VALUES(' Y ');

--     query the inserted values, and you will see that MySQL removes the trailing spaces.
   SELECT 
    status, 
    LENGTH(status)
FROM
    mysql_char_test;
    
-- Comparing MySQL CHAR values 

-- Rule 1: With =, <>, >, <, MySQL ignores trailing spaces  but not leading spaces.
-- Rule 2: LIKE counts trailing spaces in pattern matching.
-- Rule 3: MySQL uses the column’s character set and collation to compare the values.

-- MySQL CHAR and UNIQUE index 

-- If the CHAR column has a UNIQUE index and you insert a value that is different from an existing value in a number of trailing spaces, MySQL will reject the changes because of duplicate-key error.

#  MySQL CHAR and UNIQUE index 

-- create a unique index for the status column of the mysql_char_test table.

CREATE UNIQUE INDEX uidx_status 
ON mysql_char_test(status);

--  insert a new row into the mysql_char_test table.

INSERT INTO mysql_char_test(status)
VALUES('N');

-- insert the following value will cause a duplicate key error.

INSERT INTO mysql_char_test(status)
VALUES('N ');








    