--  MySQL join clauses 

/* A join is a method of linking data between one (self-join) 
 or more tables based on the values of the common column between the tables.*/

-- MySQL supports the following types of joins:
-- 1. Inner join An INNER JOIN only keeps the rows that have a perfect match in both lists.
-- 2. Left join A LEFT JOIN keeps everything from the Left list, plus any matching info it can find from the Right list. If the Right list has no match, it just leaves that space blank (NULL).
-- 3. Right join  A RIGHT JOIN is the exact opposite of a Left Join. It keeps everything from the Right list, plus any matching info it can find from the Left list. If the Left list has no match, it leaves that space blank.

-- Setting up sample tables #

CREATE TABLE members (
    member_id INT AUTO_INCREMENT,
    name VARCHAR(100),
    PRIMARY KEY (member_id)
);

CREATE TABLE committees (
    committee_id INT AUTO_INCREMENT,
    name VARCHAR(100),
    PRIMARY KEY (committee_id)
);

INSERT INTO members(name)
VALUES('John'),('Jane'),('Mary'),('David'),('Amelia');

INSERT INTO committees(name)
VALUES('John'),('Mary'),('Amelia'),('Joe');



SELECT * FROM members;
SELECT * FROM committees;

-- INNER join

/* use an inner join clause to find members who are also
 the committee members:*/
SELECT 
    m.member_id, 
    m.name AS member, 
    c.committee_id, 
    c.name AS committee
FROM
    members m
INNER JOIN committees c ON c.name = m.name;

/*This query returns the order number, order status,
 and total sales from the orders and orderdetails
 tables using the INNER JOIN clause with the GROUP BYclause:*/
SELECT 
    t1.orderNumber,
    t1.status,
    SUM(quantityOrdered * priceEach) total
FROM
    orders t1
INNER JOIN orderdetails t2 
    ON t1.orderNumber = t2.orderNumber
GROUP BY t1.orderNumber;

--  using the INNER JOIN with the USING syntax:
SELECT 
    orderNumber,
    status,
    SUM(quantityOrdered * priceEach) total
FROM
    orders
INNER JOIN orderdetails USING (orderNumber)
GROUP BY orderNumber;

/*using two INNER JOIN clauses to join three tables:
 orders, orderdetails, and products:*/
 SELECT 
    orderNumber,
    orderDate,
    orderLineNumber,
    productName,
    quantityOrdered,
    priceEach
FROM
    orders
INNER JOIN
    orderdetails USING (orderNumber)
INNER JOIN
    products USING (productCode)
ORDER BY 
    orderNumber, 
    orderLineNumber;

-- LEFT JOIN clause 
 /*use a left join clause to join the members with the committees table: */

SELECT 
    m.member_id, 
    m.name AS member, 
    c.committee_id, 
    c.name AS committee
FROM
    members m
LEFT JOIN committees c USING(name);

/* using  the left join clause with the USING syntax:
*/
SELECT 
    m.member_id, 
    m.name AS member, 
    c.committee_id, 
    c.name AS committee
FROM
    members m
LEFT JOIN committees c USING(name);

/* To find members who are not the committee members, 
you add a WHERE clause and IS NULL operator */
SELECT 
    m.member_id, 
    m.name AS member, 
    c.committee_id, 
    c.name AS committee
FROM
    members m
LEFT JOIN committees c USING(name)
WHERE c.committee_id IS NULL;

/* using the LEFT JOIN clause to find all customers and their corresponding 
 orders:*/
 SELECT 
    customers.customerNumber, 
    customerName, 
    orderNumber, 
    status
FROM
    customers
LEFT JOIN orders ON 
    orders.customerNumber = customers.customerNumber;

/* using the LEFT JOIN to find customers without any orders:
SELECT */
SELECT 
    c.customerNumber, 
    c.customerName, 
    o.orderNumber, 
    o.status
FROM
    customers c
LEFT JOIN orders o 
    ON c.customerNumber = o.customerNumber
WHERE
    orderNumber IS NULL;
    
    /*using two LEFT JOIN clauses to join the three tables: employees,
    customers, and payments.*/
SELECT 
    lastName, 
    firstName, 
    customerName, 
    checkNumber, 
    amount
FROM
    employees
LEFT JOIN customers ON 
    employeeNumber = salesRepEmployeeNumber
LEFT JOIN payments ON 
    payments.customerNumber = customers.customerNumber
ORDER BY 
    customerName, 
    checkNumber;
    
-- MySQL RIGHT JOIN clause

--  using  the right join to join the members and committees tables:
SELECT 
    m.member_id, 
    m.name AS member, 
    c.committee_id, 
    c.name AS committee
FROM
    members m
RIGHT JOIN committees c on c.name = m.name;
 
--   finding the committee members who are not in the members table,
SELECT 
    m.member_id, 
    m.name AS member, 
    c.committee_id, 
    c.name AS committee
FROM
    members m
RIGHT JOIN committees c USING(name)
WHERE m.member_id IS NULL;

/* using the RIGHT JOIN clause to find employees who are not
 in charge of any customers:*/
 SELECT 
    employeeNumber, 
    customerNumber
FROM
    customers
RIGHT JOIN employees ON 
	salesRepEmployeeNumber = employeeNumber
WHERE customerNumber is NULL
ORDER BY employeeNumber;

-- MySQL CROSS JOIN clause 

-- using  the cross join clause to join the members with the committees tables:
SELECT 
    m.member_id, 
    m.name AS member, 
    c.committee_id, 
    c.name AS committee
FROM
    members m
CROSS JOIN committees c;

CREATE TABLE suits (
    suit_id INT,
    suit_name VARCHAR(10)
);

CREATE TABLE ranks (
    rank_id INT,
    rank_name VARCHAR(5)
);

INSERT INTO suits (suit_id, suit_name) VALUES
    (1, 'Hearts'),
    (2, 'Diamonds'),
    (3, 'Clubs'),
    (4, 'Spades');

INSERT INTO ranks (rank_id, rank_name) VALUES
    (1, 'Ace'),
    (2, '2'),
    (3, '3'),
    (4, '4'),
    (5, '5'),
    (6, '6'),
    (7, '7'),
    (8, '8'),
    (9, '9'),
    (10, '10'),
    (11, 'Jack'),
    (12, 'Queen'),
    (13, 'King');

SELECT 
  suit_name, 
  rank_name 
FROM 
  suits CROSS 
  JOIN ranks 
ORDER BY 
  suit_name, 
  rank_name;





-- MySQL Self Join
/*A self join allows you to join a table to itself. Since MySQL does not
 have specific self join syntax, you need to perform a self join via a
 regular join such as left join or inner join.*/

--  Performing a self join using an inner join 

/*To obtain the entire organization structure, you can perform a self
 join on the employees table using the
 employeeNumber and reportsTo columns:*/
 SELECT 
    CONCAT(m.lastName, ', ', m.firstName) AS Manager,
    CONCAT(e.lastName, ', ', e.firstName) AS 'Direct report'
FROM
    employees e
INNER JOIN employees m ON 
    m.employeeNumber = e.reportsTo
ORDER BY 
    Manager;
    
-- Performing a self join using a left join 

/*The President is the employee who does not have any manager or value
 in the reportsTo column is NULL .*/
 /*The following statement uses the LEFT JOIN
 clause instead of INNER JOIN to include the President:
*/

SELECT 
    IFNULL(CONCAT(m.lastname, ', ', m.firstname),
            'Top Manager') AS 'Manager',
    CONCAT(e.lastname, ', ', e.firstname) AS 'Direct report'
FROM
    employees e
LEFT JOIN employees m ON 
    m.employeeNumber = e.reportsto
ORDER BY 
    manager DESC;

-- Using a self join to compare successive rows within the same table

/*By using the MySQL self join, you can display a list of customers who are located in the same city by 
joining the customers table to itself.*/

SELECT 
    c1.city, 
    c1.customerName, 
    c2.customerName
FROM
    customers c1
INNER JOIN customers c2 ON 
    c1.city = c2.city
    AND c1.customername > c2.customerName
ORDER BY 
    c1.city;

