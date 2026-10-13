-- MySQL Primary Key
-- , a primary key is a column or a set of columns that uniquely identifies each row in the table. A primary key column must contain unique values
--  Defining a single-column primary key example 


CREATE TABLE products(
   id INT PRIMARY KEY,
   name VARCHAR(255) NOT NULL
);

-- When you insert data into the products table, you need to ensure the uniqueness of values in the id column. For example:

INSERT INTO products (id, name) 
VALUES 
    (1, 'Laptop'),
    (2, 'Smartphone'),
    (3, 'Wireless Headphones');
    
    
--     If you attempt to insert a duplicate value into the primary key column, you’ll get an error:

INSERT INTO products (id, name) 
VALUES 
  (1, 'Bluetooth Speaker');     -- 0	191	09:30:33	INSERT INTO products (id, name)   VALUES (1, 'Bluetooth Speaker')	Error Code: 1062. Duplicate entry '1' for key 'products.PRIMARY'	0.015 sec
  
--    Defining a single-column primary key with AUTO_INCREMENT attribute 
DROP TABLE products; 

CREATE TABLE products(
   id INT AUTO_INCREMENT PRIMARY KEY,
   name VARCHAR(255) NOT NULL
);


INSERT INTO products (name) 
VALUES 
    ('Laptop'),
    ('Smartphone'),
    ('Wireless Headphones');
    
SELECT * FROM products;

-- Defining a multi-column primary key example 
-- We’ll create a new table called customers:
CREATE TABLE customers(
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL
);

-- The favorites table has a primary that consists of two columns customer_id and product_id

CREATE TABLE faviorites(
    customer_id INT,
    product_id INT,
    favorite_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(customer_id, product_id)
);

--  Adding a primary key to a table 
CREATE TABLE tags(
    id INT,
    name VARCHAR(25) NOT NULL
);
ALTER TABLE tags
ADD PRIMARY KEY(id);

-- Removing the primary key from a table 
ALTER TABLE tags
DROP PRIMARY KEY;




