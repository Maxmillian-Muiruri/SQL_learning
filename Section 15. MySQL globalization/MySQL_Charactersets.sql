-- MySQL Character Sets
-- In MySQL, the character set and collation are essential concepts that define how data is stored and sorted in text columns.
-- Understanding character sets and collations are crucial for designing databases that can handle different languages and text requirements.

-- A character set is a collection of characters with a unique encoding. It defines the set of characters that can be used in a text column,
--  such as letters, numbers, symbols, and special characters.

-- MySQL supports various character sets, and the choice of character set 
-- determines the range of  characters that can be stored in a column.

-- Common character sets include utf8, utf8mb4, latin1, utf16, and many others
--  list all character sets in the current MySQL server, you use the following statement:

SHOW CHARACTER SET;

-- Converting between different character sets 
-- MySQL provides two functions that allow you to
--  convert strings between different character sets: CONVERT and CAST.
-- The syntax of the CONVERT function is as follows:
-- CONVERT(expression USING character_set_name)

-- The CAST function is similar to the CONVERT function. 
-- It converts a string to a different character set:

-- CAST(string AS character_type CHARACTER SET character_set_name)

-- example of using the CAST function:

SELECT CAST(_latin1'MySQL character set' AS CHAR CHARACTER SET utf8);

-- Setting character sets for client connections 
-- To configure a character set for a client connection, you can do one of the following ways:
-- 1 Using the SET NAMES statement 

--  to set a Unicode character set utf8mb4, you use the following statement:
SET NAMES 'utf8mb4';

-- 2) Using –default-character-set option 
-- If the application supports the --default-character-set  option, 
-- you can use it to set the character set.

--  example, mysql client tool supports --default-character-set option and you can set it up in the configuration file as follows:

-- [mysql] default-character-set=utf8mb4

-- 3  Using the charset in connection strings 

-- Some MySQL connectors allow you to specify a character set. 
-- For example, if you use PHP PDO, you can set the character set in the data source name as follows:

-- $dsn ="mysql:host=$host;dbname=$db;charset=utf8mb4";

-- Summary 
-- Character sets define how MySQL stores data in text columns.
-- Use the SHOW CHARACTER SET statement to list all character sets.
-- Use the CONVERT() or CAST() function to convert between character sets.




