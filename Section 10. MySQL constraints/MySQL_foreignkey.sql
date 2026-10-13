-- MySQL Foreign Key


-- A foreign key is a column or group of columns in a table that links to a column or group of columns in another table.  

CREATE DATABASE fkdemo;

USE fkdemo;

CREATE TABLE categories(
  categoryId INT AUTO_INCREMENT PRIMARY KEY, 
  categoryName VARCHAR(100) NOT NULL
) ENGINE = INNODB;
CREATE TABLE products(
  productId INT AUTO_INCREMENT PRIMARY KEY, 
  productName VARCHAR(100) NOT NULL, 
  categoryId INT, 
  CONSTRAINT fk_category FOREIGN KEY (categoryId) 
                         REFERENCES categories(categoryId)
) ENGINE = INNODB;


-- Because we don’t specify any ON UPDATE and ON DELETE clauses, the default action is RESTRICT for both update and delete operations.
 
--   illustrate the RESTRICT action.
INSERT INTO categories(categoryName)
VALUES
    ('Smartphone'),
    ('Smartwatch');
    
SELECT * FROM categories;

INSERT INTO products(productName, categoryId)
VALUES('iPhone',1);

-- Insert a product with a category that doesn’t exist
INSERT INTO products(productName, categoryId)
VALUES('iPad',3)
--  you will get an error 

UPDATE categories
SET categoryId = 100
WHERE categoryId = 1;
--  you will get an error
/* Because of the RESTRICT option, you cannot delete or update categoryId 1 since
 it is referenced by the productId1 in the products table. */
 
--  CASCADE action
--  illustrate how ON UPDATE CASCADE and ON DELETE CASCADE actions work. 
DROP TABLE products;

--  Create the products table with the ON UPDATE CASCADE and ON DELETE CASCADE options for the foreign key:
CREATE TABLE products(
    productId INT AUTO_INCREMENT PRIMARY KEY,
    productName varchar(100) not null,
    categoryId INT NOT NULL,
    CONSTRAINT fk_category
    FOREIGN KEY (categoryId) 
    REFERENCES categories(categoryId)
        ON UPDATE CASCADE
        ON DELETE CASCADE
) ENGINE=INNODB;
 -- inseert rows in the table we createddd
 INSERT INTO products(productName, categoryId)
VALUES
    ('iPhone', 1), 
    ('Galaxy Note',1),
    ('Apple Watch',2),
    ('Samsung Galary Watch',2);

-- select from the product table

SELECT * FROM products;


--  Update categoryId 1 to 100 in the categories table:
UPDATE categories
SET categoryId = 100
WHERE categoryId = 1;

-- confirm the updates 
SELECT * FROM categories;
 -- get from the product table the data in it 
 SELECT * FROM products;

--  Delete categoryId 2 from the categories table:
DELETE FROM categories
WHERE categoryId = 2;

-- confirm the deletion
SELECT * FROM categories;

-- check the product table
SELECT * FROM products;
--   SET NULL action 

-- These steps illustrate how the ON UPDATE SET NULL and ON DELETE SET NULL actions work.
-- ON DELETE SET NULL
-- When you delete a parent row, MySQL sets the matching child rows’ foreign key to NULL instead of blocking the delete or deleting the children.

-- ON UPDATE SET NULL
-- When you change a parent row’s key, MySQL sets the matching child rows’ foreign key to NULL instead of blocking the update.

-- drop the categories and product table
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS products;

--  Create the categories and products tables:

CREATE TABLE categories(
    categoryId INT AUTO_INCREMENT PRIMARY KEY,
    categoryName VARCHAR(100) NOT NULL
)ENGINE=INNODB;

CREATE TABLE products(
    productId INT AUTO_INCREMENT PRIMARY KEY,
    productName varchar(100) not null,
    categoryId INT,
    CONSTRAINT fk_category
    FOREIGN KEY (categoryId) 
        REFERENCES categories(categoryId)
        ON UPDATE SET NULL
        ON DELETE SET NULL 
)ENGINE=INNODB;

--  foreign key in the products table changed to ON UPDATE SET NULL and ON DELETE SET NULL options.

--  Insert rows into the categories table:

INSERT INTO categories(categoryName)
VALUES
    ('Smartphone'),
    ('Smartwatch');

--  Insert rows into the products table:

INSERT INTO products(productName, categoryId)
VALUES
    ('iPhone', 1), 
    ('Galaxy Note',1),
    ('Apple Watch',2),
    ('Samsung Galary Watch',2);


-- Update categoryId from 1 to 100 in the categories table:

UPDATE categories
SET categoryId = 100
WHERE categoryId = 1;



-- confirm updates
SELECT * FROM categories;

SELECT * FROM products;
-- The rows with the categoryId 1 in the products table was automatically set to NULL due to the ON UPDATE SET NULL action.

-- Delete the categoryId 2 from the categories table:
DELETE FROM categories 
WHERE categoryId = 2;
-- Check the products table:

SELECT * FROM products;
-- The values in the categoryId column of the rows with categoryId 2 in the products table was automatically set to NULL due to the ON DELETE SET NULL action.

-- Drop MySQL foreign key constraints 

-- To obtain the generated constraint name of a table, you use the SHOW CREATE TABLE statement:
SHOW CREATE TABLE products;

--  drop the foreign key constraint of the products table:
ALTER TABLE products 
DROP FOREIGN KEY fk_category;

SHOW CREATE TABLE products

-- Disabling foreign key checks 
-- To disable foreign key checks, you use the following statement:

SET foreign_key_checks = 0;
-- And you can enable it by using the following statement:

SET foreign_key_checks = 1;








