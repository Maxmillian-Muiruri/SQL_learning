-- MySQL ALTER TABLE

-- Setting up a sample table 

CREATE TABLE vehicles (
    vehicleId INT,
    year INT NOT NULL,
    make VARCHAR(100) NOT NULL,
    PRIMARY KEY(vehicleId)
);

--  Add a column to  a table 


-- To add a column to a table, you use the ALTER TABLE ADD

ALTER TABLE vehicles
ADD model VARCHAR(100) NOT NULL;

DESCRIBE vehicles;

-- Add multiple columns to a table 

-- add two columns color and note to the vehicles table:
ALTER TABLE vehicles
ADD color VARCHAR(50),
ADD note VARCHAR(255);

DESCRIBE vehicles;

-- MySQL ALTER TABLE – Modify columns 

-- modify the note column:

ALTER TABLE vehicles 
MODIFY note VARCHAR(100) NOT NULL;

DESCRIBE vehicles;


-- Modify multiple columns 
-- use the ALTER TABLE MODIFY statement to modify multiple columns:
ALTER TABLE vehicles 
MODIFY year SMALLINT NOT NULL,
MODIFY color VARCHAR(20) NULL AFTER make;


-- MySQL ALTER TABLE  Rename a column in a table 
--  uses the ALTER TABLE CHANGE COLUMN statement to rename the column note to vehicleCondition
ALTER TABLE vehicles 
CHANGE COLUMN note vehicleCondition VARCHAR(100) NOT NULL;

-- ALTER TABLE – Drop a column
--  use the ALTER TABLE DROP COLUMN statement:

--  remove the vehicleCondition column from the vehicles table:
ALTER TABLE vehicles
DROP COLUMN vehicleCondition;

DESCRIBE vehicles;
 
--  MySQL ALTER TABLE – Rename table

--  you use the ALTER TABLE RENAME TO statement:

ALTER TABLE vehicles 
RENAME TO cars; 
