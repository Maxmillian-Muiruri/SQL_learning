-- MySQL Copy Table

-- Copying data from an existing table to a new one is very useful in some cases such as backing up data
--  and replicating the production data for testing.

-- To copy data from a table to a new one, you use CREATE TABLE... SELECT statement

-- syntax
-- CREATE TABLE new_table 
-- SELECT column1, column2, ...
-- FROM existing_table;

-- To copy partial data from an existing table to the new one, 
-- you use the WHERE clause in the SELECT statement
-- syntax

-- CREATE TABLE new_table 
-- SELECT column1, column2, ...
-- FROM existing_table
-- WHERE condition;


-- It is very important to check whether the table you want to create
--  already exists before creating it.

-- To do so, you can use IF NOT EXIST option in the CREATE TABLE statement.

-- syntax

-- CREATE TABLE IF NOT EXISTS new_table 
-- SELECT column1, column2, ...
-- FROM existing_table
-- WHERE condition;


-- example

CREATE TABLE IF NOT EXISTS offices_bk 
SELECT * FROM offices;

SELECT * FROM offices_bk;


-- to copy not only the data but also all database objects
--  associated with the offices table, we use the following statements:

CREATE TABLE offices2 LIKE offices;

INSERT offices2
SELECT * FROM offices;

-- Copying tables across databases

-- Sometimes, you want to copy a table to a different database.

CREATE DATABASE IF NOT EXISTS testdb;

--  create the offices table in the testdb by copying its structure 
-- from the offices table in the classicmodels database.

CREATE TABLE testdb.offices LIKE classicmodels.offices;

-- copy data from the classimodels.offices table to testdb.offices table.

INSERT testdb.offices
SELECT *
FROM classicmodels.offices;

--  verify the data from the testdb.offices table.

SELECT * FROM testdb.offices;
 


