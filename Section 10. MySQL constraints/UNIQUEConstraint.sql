-- MySQL UNIQUE Constraint

-- A UNIQUE constraint is an integrity constraint that ensures the uniqueness of values in a column or group of columns. A UNIQUE constraint can be either a column constraint or a table constraint.

-- MySQL UNIQUE constraint 

-- create table suppliers with two unique constrints

CREATE TABLE suppliers (
    supplier_id INT AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    phone VARCHAR(15) NOT NULL UNIQUE,
    address VARCHAR(255) NOT NULL,
    PRIMARY KEY (supplier_id),
    CONSTRAINT uc_name_address UNIQUE (name,address)
);

-- insert data in to the tabkle we crerated named suppliers
INSERT INTO suppliers(name, phone, address) 
VALUES( 'ABC Inc', 
       '(408)-908-2476',
       '4000 North 1st Street');
	
    
--     if you attempt to insert a diffrent suppliers but has the phine number that already exist if will throw an error becouse we added a unique to the phone number
-- example
INSERT INTO suppliers(name, phone, address) 
VALUES( 'XYZ Corporation','(408)-908-2476','3000 North 1st Street');

-- change the phone number to a different one and execute the insert statement again this time it will accept coz we used a diffrent number wich is unique.
INSERT INTO suppliers(name, phone, address) 
VALUES( 'XYZ Corporation','(408)-908-3333','3000 North 1st Street');   

-- insert a row into the suppliers table with values that already exist in the columns name and address  MySQLwill issue an error because the UNIQUE constraint uc_name_address was violated. :

INSERT INTO suppliers(name, phone, address) 
VALUES( 'ABC Inc', 
       '(408)-908-1111',
       '4000 North 1st Street');
       
--  MySQL UNIQUE constraint & NULL 

-- In MySQL, NULL values are treated as distinct when it comes to unique constraints. Therefore, if you have a column that accepts NULL values, you can insert multiple values into the column

-- create a new table  has a phone column with a UNIQUE constraint. Also, the phone column can accept NULL values
 CREATE TABLE contacts(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    phone VARCHAR(20) UNIQUE
);

 INSERT INTO contacts(name, phone)
VALUES
   ('Alice','(408)-102-2456'),
   ('John', NULL),
   ('Jane', NULL);   
   
SELECT * FROM contacts;

-- MySQL UNIQUE constraints and indexes 
-- When you define a unique constraint for a column or a group of columns, MySQL creates a corresponding UNIQUE index and uses this index to enforce the rule.

--  SHOW CREATE TABLE statement shows the definition of the suppliers table:

SHOW CREATE TABLE suppliers;
--  SHOW INDEX statement displays all indexes associated with the suppliers table.

SHOW INDEX FROM suppliers;

-- Drop a unique constraint 
-- To drop a UNIQUE constraint, you can use DROP INDEX or ALTER TABLE statement:

--  drop the uc_name_address constraint on the suppliers table:
DROP INDEX uc_name_address ON suppliers;

SHOW INDEX FROM suppliers;
--   use ALTER TABLE ADD CONSTRAINT to  add  a unique constraint to a column of an existing table:
ALTER TABLE suppliers
ADD CONSTRAINT uc_name_address 
UNIQUE (name,address);
 














