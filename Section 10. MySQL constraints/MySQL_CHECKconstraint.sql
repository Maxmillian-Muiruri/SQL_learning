-- MySQL CHECK Constraint
-- Creating CHECK constraints as column constraints 
  
--   creete table The parts table has two column CHECK constraints: 
-- one for the cost column and the other for the price column.


CREATE TABLE parts (
    part_no VARCHAR(18) PRIMARY KEY,
    description VARCHAR(40),
    cost DECIMAL(10,2 ) NOT NULL CHECK (cost >= 0),
    price DECIMAL(10,2) NOT NULL CHECK (price >= 0)
);
SHOW CREATE TABLE parts;

/*After creating CHECK constraints, if you insert or update a value
 that causes the Boolean expression to be false, MySQL rejects the change and issues an error.*/
 
   -- example
   INSERT INTO parts(part_no, description,cost,price) 
VALUES('A-001','Cooler',0,-100);
 /*0	294	14:34:56	INSERT INTO parts(part_no, description,cost,price) 
 VALUES('A-001','Cooler',0,-100)	Error Code: 3819. Check constraint 'parts_chk_2' is violated.	0.015 sec*/
 
 /* the error happened the error happened Because the value of the price column is negative which causes the expression price > 0 evaluates to FALSE 
 that results in a constraint violation.*/
 
--   Creating CHECK constraints as a table constraints 
DROP TABLE IF EXISTS parts;


CREATE TABLE parts (
    part_no VARCHAR(18) PRIMARY KEY,
    description VARCHAR(40),
    cost DECIMAL(10,2 ) NOT NULL CHECK (cost >= 0),
    price DECIMAL(10,2) NOT NULL CHECK (price >= 0),
    CONSTRAINT parts_chk_price_gt_cost 
        CHECK(price >= cost)
);

SHOW CREATE TABLE parts;

--  attempts to insert a new part whose price is less than the cost: it will bring rror due to the constraint violation:
INSERT INTO parts(part_no, description,cost,price) 
VALUES('A-001','Cooler',200,100);



-- Adding a check constraint to a table 
-- If you want to explicitly specify the name of the CHECK constraint, you can use the ALTER TABLE ... ADD CONSTRAINT ... CHECK statement:

-- example, the following statement adds a CHECK constraint to the parts table:

ALTER TABLE parts
ADD CHECK (part_no <> description);

--  This CHECK constraint prevents you from having the part_no identical to the description.
-- example the folowing query will  be rejected 

INSERT INTO parts 
VALUES('A','A',100,120);


-- Removing a check constraint from a table 

-- To remove a CHECK constraint from a table, you use the ALTER TABLE ... DROP CHECK statement

--  the following statement removes the CHECK constraint parts_chk_3 from the parts table:

ALTER TABLE parts
DROP CHECK parts_chk_3;



