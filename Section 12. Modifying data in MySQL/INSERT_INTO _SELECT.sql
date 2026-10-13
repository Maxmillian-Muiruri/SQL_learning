-- MySQL INSERT INTO SELECT

-- Normally INSERT gets its data from a VALUES list:
--   INSERT INTO table_name(c1, c2, ...)
--   VALUES (v1, v2, ...);

-- With INSERT INTO SELECT, the data comes from the RESULT of a SELECT
-- query instead:
--   INSERT INTO table_name(column_list)
--   SELECT select_list
--   FROM another_table
--   WHERE condition;

-- Remeber
--   1. The number of columns in column_list must equal the number of
--      columns in select_list.
--   2. The SELECT can read from one table or from several tables.
--   3. Both tables can even be the SAME table (you copy rows of a table
--      into itself).
--
-- When it is useful:
--   - Copying data from one table to another.
--   - Summarizing data from several tables into one table.

-- use the customers, products, and orders tables from the MySQL sample database "classicmodels".


-- EXAMPLE 1: Copy rows from one table into another

CREATE TABLE suppliers (
    supplierNumber INT AUTO_INCREMENT,
    supplierName VARCHAR(50) NOT NULL,
    phone VARCHAR(50),
    addressLine1 VARCHAR(50),
    addressLine2 VARCHAR(50),
    city VARCHAR(50),
    state VARCHAR(50),
    postalCode VARCHAR(50),
    country VARCHAR(50),
    customerNumber INT,
    PRIMARY KEY (supplierNumber)
);

-- Situation: every customer in California, USA becomes a supplier.

-- Step 1: first check which rows the SELECT returns
SELECT
    customerNumber,
    customerName,
    phone,
    addressLine1,
    addressLine2,
    city,
    state,
    postalCode,
    country
FROM customers
WHERE country = 'USA' AND state = 'CA';

-- Step 2: insert those rows into suppliers
-- The columns line up by POSITION:
--   supplierName   <- customerName
--   phone          <- phone
--   addressLine1   <- addressLine1
--   ... and so on
-- supplierNumber is left out because AUTO_INCREMENT fills it in.
INSERT INTO suppliers (
    supplierName,
    phone,
    addressLine1,
    addressLine2,
    city,
    state,
    postalCode,
    country,
    customerNumber
)
SELECT
    customerName,
    phone,
    addressLine1,
    addressLine2,
    city,
    state,
    postalCode,
    country,
    customerNumber
FROM customers
WHERE country = 'USA' AND state = 'CA';

-- MySQL replies with a message like:
--   11 row(s) affected  Records: 11  Duplicates: 0  Warnings: 0
-- Records = rows inserted, Duplicates = duplicates skipped,
-- Warnings = problems MySQL noticed.

-- Step 3: check the result
SELECT * FROM suppliers;

-- EXAMPLE 2: Using SELECT inside the VALUES list
-- You can also put a small SELECT in place of EACH single value.
-- Each SELECT in brackets must return exactly ONE value.

CREATE TABLE stats (
    totalProduct INT,
    totalCustomer INT,
    totalOrder INT
);

-- COUNT(*) counts the rows in a table.
-- Each count becomes one value of the new row.
INSERT INTO stats(totalProduct, totalCustomer, totalOrder)
VALUES (
    (SELECT COUNT(*) FROM products),
    (SELECT COUNT(*) FROM customers),
    (SELECT COUNT(*) FROM orders)
);

SELECT * FROM stats;

-- SUMMARY
-- 1. INSERT INTO ... SELECT inserts the result of a query into a table.
-- 2. It replaces the VALUES clause.
-- 3. Column count in the INSERT list and the SELECT list must match,
--    and they match by position, not by name.
-- 4. Use WHERE in the SELECT to copy only some of the rows.
-- 5. Use it to copy data or to build summary tables.
-- 6. You can also use single-value SELECTs inside VALUES (...).