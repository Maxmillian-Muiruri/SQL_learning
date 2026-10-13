-- MySQL Export Table to CSV

-- The CSV stands for comma-separated values. The CSV file format is often used to exchange data between applications
--  such as Microsoft Excel, Open Office, Google Docs, and so on

-- 1 Exporting a table to a CSV file using SELECT … INTO OUTFILE statement 
-- First, open the Command Prompt on Windows or 
-- Terminal on Unix-like systems and connect to the MySQL server:

-- mysql -u root -p
-- Second, change the current database to classicmodels:

USE classicmodels;
-- Third, show the value of the secure_file_priv variable:

SHOW VARIABLES LIKE "secure_file_priv";


SELECT * FROM orders
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/orders.csv' 
FIELDS ENCLOSED BY '"'       -- Wraps every cell value inside double quotes (")
TERMINATED BY ','           -- Separates column values with commas
ESCAPED BY '"'              -- Defines character used to escape special markers
LINES TERMINATED BY '\r\n';  -- Windows style line-endings (Carriage Return + Newline)
 --  the orders.csv file must not exist in the directory C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/. Otherwise, the statement will issue an error:


SELECT * FROM orders;

-- specify the CSV output file (orders.csv) stored in the 
-- allowed directory (C:/ProgramData/MySQL/MySQL Server 8.0/Uploads)  in the INTO OUTFILE clause:

-- Adding a timestamp to the CSV output file 
-- Because MySQL won't overwrite an existing file, adding a timestamp ensures unique
-- filenames every time you run your export. This requires a "Prepared Statement".

-- 1. Generate the timestamp string (Format: _YYYY_MM_DD_HH_MM_SS)
SET @ts = DATE_FORMAT(NOW(), '_%Y_%m_%d_%H_%i_%s');

-- 2. Build the full path, safely fixing Windows backslashes automatically
SET @filename = CONCAT(REPLACE(@@secure_file_priv, '\\', '/'), 'orders', @ts, '.csv');

-- 3. Check what the final file name will look like
SELECT @filename;

-- 4. Piece together the raw SQL text string dynamically
SET @cmd = CONCAT("SELECT * FROM orders INTO OUTFILE '", 
				   @filename,
				   "' FIELDS ENCLOSED BY '\"' TERMINATED BY ',' ESCAPED BY '\"'",
				   "  LINES TERMINATED BY '\r\n';");

-- 5. Compile, run, and discard the memory for the statement
PREPARE statement FROM @cmd;
EXECUTE statement;
DEALLOCATE PREPARE statement;


-- method 3: Creating a stored procedure that exports a query result into a CSV file 

-- To avoid writing complex string concats every time, you can pack this logic into
-- a clean, reusable database procedure that exports any query text you feed it.

DELIMITER //

CREATE PROCEDURE ExportToCSV(
	IN query_text TEXT, 
    IN filename VARCHAR(255)
)
BEGIN
    DECLARE cmd VARCHAR(1000);
    
    -- Format folder backslashes to forward slashes safely
    SET filename = CONCAT(REPLACE(@@secure_file_priv, '\\', '/'), filename);

    -- Assemble the dynamic text
    SET @cmd = CONCAT(
        query_text,
        " INTO OUTFILE '", filename,
        "' FIELDS ENCLOSED BY '\"' TERMINATED BY ',' ESCAPED BY '\"'",
        "  LINES TERMINATED BY '\r\n';"
    );

    -- Execute the combined command safely
    PREPARE statement FROM @cmd;
    EXECUTE statement;
    DEALLOCATE PREPARE statement;
    
    -- Echo out the final path where the user can find the file
    SELECT filename;
END //

DELIMITER ;

-- How to use the stored procedure:
CALL ExportToCSV('SELECT * FROM employees', 'employees.csv');


-- Adding column heading to the CSV output file 
-- By default, INTO OUTFILE drops raw data without column headers. You can append 
-- headers by creating an artificial row of text and joining it via UNION.
SELECT 'Order no', 'Order date', 'Required Date', 'Shipped Date', 'Status', 'Comments', 'Customer No'
UNION 
SELECT * FROM orders
INTO OUTFILE '/var/lib/mysql-files/orders_heading.csv'
FIELDS ENCLOSED BY '"' 
TERMINATED BY ',' 
ESCAPED BY '"' 
LINES TERMINATED BY '\r\n';

-- checking the paht of into outline: SELECT @@secure_file_priv;

-- METHOD 5: HANDLING NULL VALUES (IFNULL REPLACEMENT)
-- When native database records contain NULL values, standard CSV output leaves 
-- an ugly, unreadable string: "\N". Use IFNULL() to replace them with "N/A"


SELECT 'Order no', 'Order date', 'Required Date', 'Shipped Date', 'Status', 'Comments', 'Customer No'
UNION 
SELECT 
    orderNumber, 
    orderDate, 
    requiredDate, 
    IFNULL(shippedDate, "N/A"), 
    status, 
    IFNULL(comments, "N/A"),    
    customerNumber 
FROM orders
INTO OUTFILE '/var/lib/mysql-files/orders_full_v2.csv' -- Changed filename here!
FIELDS ENCLOSED BY '"' 
TERMINATED BY ',' 
ESCAPED BY '"' 
LINES TERMINATED BY '\r\n';


-- METHOD 6: THE MYSQL WORKBENCH GUI EXPORT TOOL (LOCAL WORKSTATION)

-- If your database is remote or you lack admin access to your server's local file 
-- system to retrieve files, use the Workbench UI to download data straight to your local PC.
--
-- Steps to execute:
--   1. Run your standard select query in a Workbench tab (e.g., SELECT * FROM orders;).
--   2. In the lower "Result Grid" panel where rows appear, click the "Export" button.
--      (It looks like a small grid icon with an arrow or a disk icon).
--   3. Choose your local computer directory (e.g., your local Desktop).
--   4. Select "CSV (Comma Separated)" from the file type dropdown menu.
--   5. Save the file.
