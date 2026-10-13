-- Section 2. Sorting data 
-- the ORDER BY keyword is used to sort the result set of a query.

SELECT 
  contactLastname, 
  contactFirstname 
FROM 
  customers 
ORDER BY 
  contactLastname;
  
  SELECT 
  contactLastname, 
  contactFirstname 
FROM 
  customers 
ORDER BY 
  contactLastname DESC;
  
  SELECT 
  contactLastname, 
  contactFirstname 
FROM 
  customers 
ORDER BY 
  contactLastname DESC, 
  contactFirstname ASC;
  
  SELECT 
  orderNumber, 
  orderlinenumber, 
  quantityOrdered * priceEach 
FROM 
  orderdetails 
ORDER BY 
  quantityOrdered * priceEach DESC;
  
  
  SELECT 
  orderNumber, 
  status 
FROM 
  orders 
ORDER BY 
  FIELD(
    status, 
    'In Process', 
    'On Hold', 
    'Cancelled', 
    'Resolved', 
    'Disputed', 
    'Shipped'
  );
  
SELECT 
  firstName, 
  lastName, 
  reportsTo 
FROM 
  employees 
ORDER BY 
  reportsTo DESC;
  