-- MySQL DEFAULT

-- Introduction to the MySQL DEFAULT constraint 

-- MySQL DEFAULT constraint allows you to specify a default value for a column.

--  When you define a column without the NOT NULL constraint, the column will implicitly take NULL as the default value.

-- MySQL DEFAULT constraint example 

--  creates a new table named cart_items with four columns item_id, name, quantity, and sales_tax:

CREATE TABLE cart_items 
(
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    quantity INT NOT NULL,
    price DEC(5,2) NOT NULL,
    sales_tax DEC(5,2) NOT NULL DEFAULT 0.1, -- The sales_tax column has a default value 0.1 (10%
    CHECK(quantity > 0),
    CHECK(sales_tax >= 0) 
);

DESC cart_items;

--  adds a new item to the cart_items table:
INSERT INTO cart_items(name, quantity, price)
VALUES('Keyboard', 1, 50);

INSERT INTO cart_items(name, quantity, price)
VALUES('Keyboard', 1, 50);

--  the INSERT statement doesn’t provide a value for the sales_tax column. The sales_tax column useS the default value specified in the DEFAULT constraint:
SELECT * FROM cart_items;

--  you can explicitly use the DEFAULT keyword when you insert a new row into the cart_items table:

INSERT INTO cart_items(name, quantity, price, sales_tax)
VALUES('Battery',4, 0.25 , DEFAULT);

--  the sales_tax column takes the default value:

SELECT * FROM cart_items;

-- Adding a DEFAULT constraint to a column 

-- To add a default constraint to a column of an existing table, you use the ALTER TABLE statement:
ALTER TABLE cart_items
ALTER COLUMN quantity SET DEFAULT 1;

DESC cart_items;

--  inserts a new row into the cart_items table without specifying a value for the quantity column:
INSERT INTO cart_items(name, price, sales_tax)
VALUES('Maintenance services',25.99, 0);
SELECT * FROM cart_items;

-- Removing a DEFAULT constraint from a column 
-- To remove a DEFAULT constraint from a column, you use the ALTER TABLE statement:
ALTER TABLE cart_items
ALTER COLUMN quantity DROP DEFAULT;

DESC cart_items;

-- MySQL DEFAULT constraints set default values for columns.
-- Use DEFAULT default_value to set a default constraint to a column.
-- Use ALTER TABLE ... ALTER COLUMN ... SET DEFAULT to add a DEFAULT constraint to a column of an existing table.
-- Use ALTER TABLE ... ALTER COLUMN ... DROP DEFAULT to drop a DEFAULT constraint from a column of an existing table.




