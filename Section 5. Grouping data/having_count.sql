-- MySQL HAVING COUNT
--  HAVING COUNT is used to filter groups of data based on the number of items in that group.
--  Simple HAVING COUNT example #
CREATE TABLE sales (
    id INT AUTO_INCREMENT,
    product_name VARCHAR(50) NOT NULL,
    sale_amount DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY(id)
);

INSERT INTO sales (product_name, sale_amount)
VALUES
    ('Product A', 100.50),
    ('Product B', 75.25),
    ('Product A', 120.75),
    ('Product C', 50.00),
    ('Product B', 90.80);
    SELECT product_name, COUNT(id)
FROM sales
GROUP BY product_name;

-- find which product had one sale, use the HAVING clause with the COUNT function
SELECT 
  product_name, 
  COUNT(id) 
FROM 
  sales 
GROUP BY 
  product_name 
HAVING 
  COUNT(id) = 1;

 /* use  the HAVING clause with the COUNT function to get the 
 customers who placed more than four orders: */
 
 SELECT 
  customerName, 
  COUNT(*) order_count 
FROM 
  orders 
  INNER JOIN customers using (customerNumber) 
GROUP BY 
  customerName 
HAVING 
  COUNT(*) > 4 
ORDER BY 
  order_count;
  
-- Use the HAVING COUNT clause to filter groups by the number of items in each group.
