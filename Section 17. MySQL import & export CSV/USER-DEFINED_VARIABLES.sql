--  MYSQL USER-DEFINED VARIABLES

-- User-defined variables allow you to pass a value from one SQL statement to 
-- subsequent statements within the exact same database session.
--
-- Core Rules:
--  1. They always start with the '@' symbol (e.g., @my_variable).
--  2. They are CASE-INSENSITIVE (@id and @ID are the exact same variable).
--  3. They can only hold a SINGLE value at a time (a scalar value).
--  4. They are a MySQL-specific extension and may not work in other SQL systems.

-- Choose your database context
USE classicmodels;

-- METHOD 1: ASSIGNING VARIABLES USING THE "SET" STATEMENT
-- The SET statement is the standard way to assign values. You can use either the 
-- '=' operator or the ':=' operator.

-- Assigning using '='
SET @max_limit = 100;

-- Assigning using ':=' (Both work identically in SET statements)
SET @discount_rate := 0.15;

-- View the variables you just created
SELECT @max_limit, @discount_rate;


-- METHOD 2: ASSIGNING VARIABLES WITHIN A "SELECT" STATEMENT (INTO)
-- You can extract data dynamically out of a table and inject it into a variable 
-- using the "INTO" clause.

-- Practical Example: Find the most expensive product price and save it to @msrp
SELECT MAX(msrp) INTO @msrp FROM products;
-- To select the value of the @msrp, you use the following statement:

SELECT @msrp;

-- Step 2: Use the stored variable in a completely separate query
 -- uses the @msrp variable to query the information of the most expensive product.SELECT 
   SELECT
   productCode, 
    productName, 
    productLine, 
    msrp 
FROM products 
WHERE msrp = @msrp;



 -- Using a user-defined variable in a query that returns multiple values
 -- Because a user-defined variable can only hold a single item, assigning a query 
-- that returns multiple rows into a variable will throw a system error.

-- [THIS WILL FAIL]: The query returns multiple rows where buyPrice > 95
SELECT buyPrice INTO @buy_price
FROM products 
WHERE buyPrice > 95 
ORDER BY buyPrice;

-- Expected Output Error:
-- "ERROR 1172 (42000): Result consisted of more than one row"
-- Note: MySQL will still fallback and store the value from the VERY FIRST row (95.34).

-- To safely view what fallback value was stored:
SELECT @buy_price;


-- SUMMARY SUMMARY BLUEPRINT
-- 1. Create variables using: @variable_name
-- 2. Set values with: SET @var = 10; OR SELECT column INTO @var FROM table LIMIT 1;
-- 3. Pass values smoothly across queries without hardcoding values manually.
