-- Importing a CSV file into a MySQL table

-- There are 3 ways:
--   1) LOAD DATA INFILE (file is on the MySQL server)
--   2) LOAD DATA LOCAL INFILE (file is on your own computer)
--   3) MySQL Workbench import tool

-- 1) LOAD DATA INFILE (file on the MySQL server)
-- It reads a CSV file from a folder on the MySQL server and loads it into a table.

-- You need:
--   - A table to import into.
--   - A CSV file whose columns match the table's columns (same number
--     and same type of data).
--   - A MySQL user with FILE and INSERT privileges.

-- Example CSV file: discounts.csv
-- The first line is the column headings, the other lines are data.
--   id,title,expired date,amount
--   1,Spring Break,2014-01-01,20
--   2,Back to School,2014-09-01,25
--   3,Summer Holiday,2014-08-25,10

-- Step 1: connect to the MySQL server (in Command Prompt or Terminal)
--   mysql -u root -p

-- Step 2: choose the database
USE classicmodels;

-- Step 3: create the table
CREATE TABLE discounts (
    id INT NOT NULL AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    expired_date DATE NOT NULL,
    amount DECIMAL(10, 2) NULL,
    PRIMARY KEY (id)
);

-- Step 4: find the folder you are allowed to load files from
SELECT @@secure_file_priv;
-- Example output: C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\
-- secure_file_priv is the only folder where you can put the file
-- and run LOAD DATA INFILE on it.

-- Step 5: copy discounts.csv into that folder.

-- Step 6: import the file
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/discounts.csv'
INTO TABLE discounts
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
-- Output: Query OK, 3 rows affected
--         Records: 3  Deleted: 0  Skipped: 0  Warnings: 0

-- What each line means:
--   LOAD DATA INFILE '...'         -> the path to the CSV file
--   INTO TABLE discounts           -> the table to load the data into
--   FIELDS TERMINATED BY ','       -> values are separated by commas (a CSV file)
--   ENCLOSED BY '"'                -> values may be wrapped in double quotes,
--                                     which is common when a value contains a comma
--   LINES TERMINATED BY '\n'       -> each line (row) ends with a newline
--   IGNORE 1 ROWS                  -> skip the first row (the headings)

-- Check the result
SELECT * FROM discounts;
-- id | title          | expired_date | amount
--  1 | Spring Break   | 2014-01-01   | 20.00
--  2 | Back to School | 2014-09-01   | 25.00
--  3 | Summer Holiday | 2014-08-25   | 10.00

-- If the file is NOT in the secure_file_priv folder, you get:
--   ERROR 1290: The MySQL server is running with the --secure-file-priv
--   option so it cannot execute this statement

-- Changing the data while importing
-- Sometimes the data doesn't match the table's format. You can fix it
-- with the SET clause.
-- Example file discounts2.csv has dates as mm/dd/yyyy:
--   id,title,expired date,amount
--   1,Spring Break,01/01/2014,20
--   2,Back to School,09/01/2014,25
--   3,Summer Holiday,08/25/2014,10

-- First: empty the table
TRUNCATE TABLE discounts;

-- Second: load the file and convert the date
-- The date goes into the variable @expired_date first, then SET converts
-- it with STR_TO_DATE before storing it in expired_date.
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/discounts2.csv'
INTO TABLE discounts
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(id, title, @expired_date, amount)
SET expired_date = STR_TO_DATE(@expired_date, '%m/%d/%Y');

-- 2) LOAD DATA LOCAL INFILE (file on your computer, server is remote)
-- The LOCAL option lets you import a CSV from your own computer into a
-- table on a remote MySQL server.

-- Configuration
-- MySQL turns this off by default. You must turn it on at BOTH the
-- server and the client. The local_infile setting controls it.

-- First: in the server's config file (my.ini or my.cnf), add:
--   [mysqld]
--   local_infile=1

-- Second: restart the MySQL server.

-- Third: on your local computer, connect with the mysql client:
--   mysql -h hostname -u root -p
-- Replace hostname with your remote MySQL server.

-- Fourth: turn the setting on for the client:
SET GLOBAL local_infile = 1;

-- Loading the file
USE classicmodels;

LOAD DATA LOCAL INFILE 'c:/temp/discounts.csv'
INTO TABLE discounts
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
-- The only difference is the word LOCAL.
-- With a big file it takes longer, because the file must be sent to the server.

-- If it is not configured on both sides, you get:
--   ERROR 3948: Loading local data is disabled; this must be enabled on
--   both the client and server sides

-- 3) Import with MySQL Workbench
-- Workbench has an import tool. The steps:
--   1. Open the discounts table.
--   2. Click the Import button.
--   3. Select the path of the CSV file and click Next.
--   4. Select the destination table (classicmodels.discounts). You can also
--      create a new table first, or truncate the table before importing.
--   5. Map the columns of the file to the columns of the table, then Next.
--   6. Review the steps Workbench will do, then Next.
--   7. Review again, then Next.
--   8. Review the import result, then Finish.
--   9. Show the contents of the discounts table to check.

-- Summary
-- 1. Use LOAD DATA INFILE to import a CSV file into a table.
-- 2. Use SET with STR_TO_DATE to change the data while importing.
-- 3. Use LOAD DATA LOCAL INFILE (with local_infile enabled on both sides)
--    to import from your own computer to a remote server.
-- 4. Use MySQL Workbench to import a CSV file from your local computer
--    into a table on a remote MySQL server.