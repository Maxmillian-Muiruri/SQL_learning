-- How to Compare Successive Rows within the Same Table in MySQL

-- create a new table:
 
 CREATE TABLE inventory(
  id INT AUTO_INCREMENT PRIMARY KEY,
  counted_date date NOT NULL,
  item_no VARCHAR(20) NOT NULL,
  qty INT NOT NULL
);


--  insert some rows into the inventory table:

INSERT INTO inventory(counted_date,item_no,qty)
VALUES ('2014-10-01','A',20),
	   ('2014-10-02','A',30),
	   ('2014-10-03','A',45),
	   ('2014-10-04','A',80),
	   ('2014-10-05','A',100);
       
     -- retrieve data 
     SELECT * FROM inventory;
-- Comparing the current row with the next row within the same table 

-- uses a Common Table Expression (CTE) and the LAG window function to 
-- calculate the received quantity of items per day by comparing the on-hand quantity of a particular day with its successive day:

WITH cte AS (
  SELECT 
    item_no, 
    counted_date from_date, 
    LEAD(counted_date, 1) OVER ( ORDER BY counted_date) to_date, 
    qty, 
    LEAD(qty, 1) OVER (ORDER BY counted_date) new_qty 
  FROM 
    inventory
) 
SELECT 
  item_no, 
  from_date, 
  to_date, 
  (new_qty - qty) AS received_qty 
FROM 
  cte 
WHERE 
  to_date IS NOT NULL;
--   SUMMARY 
-- 1. DELETE JOIN: Simplest method. Filter `t1.id < t2.id` to retain high primary keys.
-- 2. Intermediary Table: Highly secure method. Filters duplicates out via GROUP BY.
-- 3. ROW_NUMBER(): Modern system pattern. Isolates data row windows via CTE/Subqueries.