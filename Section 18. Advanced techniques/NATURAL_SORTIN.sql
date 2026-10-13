--  NATURAL SORTING IN MYSQL
-- Natural sorting "human sorting" or "alphanumeric sorting"  arranges mixed text 
-- and numbers intuitively based on their value (e.g., '2' comes before '10').
--
-- The Problem:
--   Standard string sorting (`ORDER BY`) reads character-by-character. It puts '10Z' 
--   before '2' because '1' is smaller than '2'. 
--
-- The Solution:
--   MySQL has no built-in natural sort function. We must use Regular Expressions 
--   (`REGEXP_SUBSTR`) to split strings into numeric prefixes and alphabetical suffixes, 
--   then sort by those independent parts.

-- Step 1: Select your database context
USE classicmodels;

-- Step 2: Setup a sample table to demonstrate the sorting difference
CREATE TABLE IF NOT EXISTS items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- Step 3: Insert sample data mixing single digits, double digits, and letters
INSERT INTO items(name)
VALUES ('1'), ('1C'), ('10Z'), ('2A'), ('2'), ('3C'), ('20D');

-- TEST 1: THE BAD WAY (STANDARD STRING SORTING)
-- Notice how '10Z' incorrectly appears BEFORE '2' because it sorts purely by text.

SELECT name 
FROM items 
ORDER BY name;

-- Broken Output Result:
-- '1', '10Z', '1C', '2', '20D', '2A', '3C'

-- TEST 2: MySQL natural sorting using regular expressions 
-- We use regular expressions to view exactly how MySQL splits the column values:
--  - '^\d+' extracts one or more digits from the start of the string.
--  - '\D\$' extracts the non-digit letter character from the end of the string.
--  - CAST(... AS SIGNED) converts the extracted text number into a true integer.

SELECT
  name, 
  CAST(REGEXP_SUBSTR(name, '^\\d+') AS SIGNED) AS prefix, 
  REGEXP_SUBSTR(name, '\\D\$') AS suffix 
FROM items;


-- TEST 3: THE GOOD WAY (NATURAL SORT OUTPUT WITH HELPER COLUMNS)
-- Sorting by prefix numerically first, then by suffix alphabetically second.

SELECT 
  name, 
  CAST(REGEXP_SUBSTR(name, '^\\d+') AS SIGNED) AS prefix, 
  REGEXP_SUBSTR(name, '\\D\$') AS suffix 
FROM items 
ORDER BY prefix, suffix;

-- TEST 4: CLEAN NATURAL SORT 
-- This performs the exact same human-friendly sorting, but hides the temporary 
-- prefix and suffix calculation columns from the final displayed result set.

SELECT name 
FROM items 
ORDER BY 
  CAST(REGEXP_SUBSTR(name, '^\\d+') AS SIGNED), 
  REGEXP_SUBSTR(name, '\\D\$');   -- shows Correct Human-Friendly Output:


-- SUMMARY CHECKLIST
-- 1. Standard sorting fails when numbers and text blend together.
-- 2. Extract leading numbers using: CAST(REGEXP_SUBSTR(field, '^\\d+') AS SIGNED)
-- 3. Extract trailing strings using: REGEXP_SUBSTR(field, '\\D\$')
-- 4. Order by both custom expressions to achieve seamless human alphanumeric sorting.
