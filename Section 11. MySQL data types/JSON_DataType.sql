--  MySQL JSON Data Type
-- JSON stores a JSON document inside a column.
-- JSON = JavaScript Object Notation, a simple text format for data
-- that is easy for humans to read and for computers to process.
-- It is used for config files and for sending data between a
-- client and a server.

-- JSON basics
-- JSON has two building blocks:
--
-- 1) OBJECT:
--  key-value pairs inside curly braces { }
--    Keys MUST be in double quotes.
--      {"name": "John Doe", "age": 22}
--
-- 2) ARRAY: an ordered list inside square brackets [ ]
--    It can hold any JSON value, including objects and other arrays.
--      ["John Doe", 22]
--
-- JSON value types:
--   String   - "JSON"
--   Number   - 10, 12.25
--   Boolean  - true, false
--   Null     - null

-- The MySQL JSON data type
-- Available since MySQL 5.7.8.
-- Benefits:
--   1. MySQL VALIDATES the document. Invalid JSON gives an error.
--   2. It is stored in a binary format that is fast to search.
--   3. Storage size is about the same as LONGBLOB or LONGTEXT.
--
-- Syntax:
--   column_name JSON
--
-- Extra facts:
--   - A JSON column can hold NULL.
--   - From MySQL 8.0.13 a JSON column can have a default value.
--   - You cannot index a JSON column directly.
--     Instead, create a functional index on a value extracted from it.

-- PART 1: Create a table with a JSON column

CREATE TABLE productss (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    properties JSON          -- stores things like colors and sizes
);

-- PART 2: Insert JSON data
-- The JSON document goes inside single quotes ' '.
-- Inside it, keys and text use double quotes " ".
-- MySQL first checks the JSON is valid, then converts it to binary.

INSERT INTO productss(name, price, properties)
VALUES ('T-Shirt', 25.99,
        '{"sizes": ["S","M","L","XL"], "colors": ["white","black"]}');

-- PART 3: Query JSON data

SELECT name, properties
FROM productss;

-- JSON_PRETTY formats the JSON so it is easy to read
SELECT JSON_PRETTY(properties)
FROM productss;

-- PART 4: Get the keys of a JSON document
-- JSON_KEYS returns a JSON array of all top-level keys.

SELECT JSON_KEYS(properties)
FROM productss;

-- PART 5: Extract data from a JSON document
-- To point to a spot inside a JSON document, use a PATH expression:
--   $            -> the whole document
--   $.colors     -> the value of the key "colors"
--   $.colors[0]  -> the FIRST item in the colors array (index starts at 0)
--   $.sizes[2]   -> the THIRD item in the sizes array

SELECT JSON_EXTRACT(properties, '$.colors[0]')
FROM productss;

-- Same thing with the shortcut operator ->
SELECT properties->'$.colors[0]'
FROM productss;

-- - also removes the quotes around text values
SELECT properties->>'$.colors[0]'
FROM productss;

-- SUMMARY
-- 1. JSON column = stores a validated JSON document (MySQL 5.7.8+).
-- 2. JSON uses objects { } and arrays [ ].
-- 3. Stored in binary format for fast searching.
-- 4. JSON_PRETTY()   - makes the JSON easy to read.
-- 5. JSON_KEYS()     - lists the keys of the document.
-- 6. JSON_EXTRACT()  - gets a value using a path like $.colors[0].
-- 7. A JSON column cannot be indexed directly (use a functional index).