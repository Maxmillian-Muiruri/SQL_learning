-- How to Add Columns to a Table Using MySQL ADD COLUMN Statement
/*When adding a new column to a table, you can specify its position within the table. You can use te keyword FIRST if you want the new column to be positioned as the first column in the table.
*/
/* Alternatively, you can use the AFTER existing_column clause to specify that you want to add a new column after an existing column. */
/* If you do not explicitly specify the position of the new column, the statement will automatically add it as the last column in the table. */

-- MySQL ADD COLUMN examples 

CREATE TABLE vendors (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255)
);

ALTER TABLE vendors
ADD COLUMN phone VARCHAR(15) AFTER name;


DESC vendors;

ALTER TABLE vendors
ADD COLUMN vendor_group INT NOT NULL;

DESC vendors;
 
 -- insert rows into vendors
 
 INSERT INTO vendors(name,phone,vendor_group)
VALUES('IBM','(408)-298-2987',1),
      ('Microsoft','(408)-298-2988',1);
  
  SELECT 
  id, 
  name, 
  phone, 
  vendor_group 
FROM 
  vendors;
  
  ALTER TABLE vendors
ADD COLUMN email VARCHAR(100) NOT NULL,
ADD COLUMN hourly_rate decimal(10,2) NOT NULL;

SELECT 
  id, 
  name, 
  phone, 
  vendor_group, 
  email, 
  hourly_rate 
FROM 
  vendors;
  
  
--    Adding an auto-increment column 
-- MySQL allows a table to have up to one auto-increment column and that column must be defined as a key

CREATE TABLE contactsnew(
   name VARCHAR(255) NOT NULL
);

INSERT INTO contactsnew(name) 
VALUES 
   ('John'), 
   ('max');

SELECT * FROM contactsnew;

ALTER TABLE contactsnew 
ADD COLUMN id INT AUTO_INCREMENT 
PRIMARY KEY;

DESC contactsnew;

