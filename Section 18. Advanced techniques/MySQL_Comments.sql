-- MySQL Comments

 --  Single-Line Comments
-- Single-line comments are used to add comments on a single line.

-- MySQL supports two types of single-line comments:

-- Using (--)
-- You can add a single-line comment using two hyphens (--) followed by your comment text.
--  Any text following -- on the same line is treated as a comment. For example:

-- This is a single-line comment
SELECT * FROM employees;

-- Using # #
-- you can use the hash (#) symbol to add single-line comments. 
# Any text following # on the same line is treated as a comment. For example:

# This is another single-line comment
SELECT * FROM customers;


#  Multi-Line Comments 
/* Multi-line comments allow you to add comments spanning multiple lines.
 MySQL supports two types of multi-line comments: */

# Delimited by /* ... */ 
-- You can enclose your comments within /* and */ to create multi-line comments. 
-- Everything between the opening /* and closing */ is treated as a comment. For example:

/* This is a
   multi-line comment */
SELECT * FROM orders;


-- Using -- for Multi-Line Comments #
-- While -- is primarily for single-line comments,
--  you can use it for multi-line comments by adding -- at the beginning of each line:

-- This is a multi-line comment
-- that spans multiple lines
SELECT * FROM products;


#  Executable comments 

-- These are special comments that maintain portability. Other database engines (like
-- PostgreSQL or Oracle) treat them as regular comments and ignore them. However, 
-- MySQL will actively parse and execute the code contained inside them.

-- Example A: Basic Executable Statement
-- Other SQL servers return: 1. MySQL parses the comment block and returns: 2
SELECT 1 /*! +1 */;

-- Example B: Version-Specific Executable Statements
-- Syntax: /*!##### Code */ where ##### represents: Major Version (1 digit), 
-- Minor Version (2 digits), and Patch Level (2 digits).
--
-- The clause below will ONLY execute if the running MySQL version is 5.1.10 or higher:
CREATE TABLE IF NOT EXISTS t1 (
    k INT AUTO_INCREMENT,
    KEY (k)
) /*!50110 KEY_BLOCK_SIZE=1024; */;

-- SUMMARY 
-- 1. Standard single lines: Use `-- comment_text` (don't forget the space!).
-- 2. Clean visual blocks: Use `/* comment_text */` for long multi-line summaries.
-- 3. Dynamic engine tuning: Use `/*! code */` to write code exclusive to MySQL servers.
