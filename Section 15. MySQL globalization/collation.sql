-- MySQL Collation

-- A collation is a set of rules used to compare characters in a
-- particular character set.
-- Each character set has at least one default collation.
-- A character set can have more than one collation, but two character
-- sets cannot have the same collation.

-- Get the default collations of the character sets

SHOW CHARACTER SET;
-- The "Default collation" column shows the default for each character set.

-- Naming convention: a collation starts with the character set name and
-- ends with:
--   _ci  = case insensitive
--   _cs  = case sensitive
--   _bin = binary

-- Get all collations for a given character set
SHOW COLLATION LIKE 'character_set_name%';

-- Example: all collations for the latin1 character set
SHOW COLLATION LIKE 'latin1%';
-- latin1_swedish_ci is the default collation of latin1.

-- Setting character sets and collations
-- You can set them at four levels: Server, Database, Table, Column.

-- 1) Server level
-- MySQL uses latin1 as the default character set, so the default
-- collation is latin1_swedish_ci. You can change this at server startup.
-- If you give only a character set, MySQL uses that character set's
-- default collation.
-- If you give both, they are used for all databases you create.
-- Command line example:
--   mysqld --character-set-server=utf8 --collation-server=utf8_unicode_cs

-- 2) Setting character sets and collations at the database level 
-- If you don't specify them, a new database uses the server's settings.
CREATE DATABASE database_name
CHARACTER SET character_set_name
COLLATE collation_name;

ALTER DATABASE database_name
CHARACTER SET character_set_name
COLLATE collation_name;
-- Tables created in the database use its settings by default.

-- 3 Setting character sets and collations at the database level 
-- A table can have different settings from its database.
-- You can specify the default character set and collation for a table when you create the table by using the CREATE TABLE
CREATE TABLE table_name(
   ........
)
CHARACTER SET character_set_name
COLLATE collation_name;
-- or when you alter the table using the ALTER TABLE  statement:


ALTER TABLE table_name(
  ...
)
CHARACTER SET character_set_name
COLLATE collation_name;

--  4 Setting character set and collation at column level 

-- A CHAR, VARCHAR, or TEXT column can have its own settings, different
-- from the table's.
-- CREATE TABLE and ALTER TABLE statement allows you to override the character set and collation for a specific column
-- column_name [CHAR | VARCHAR | TEXT] (length)
-- CHARACTER SET character_set_name
-- COLLATE collation_name

-- The rules for setting the character set and collation are:

-- 1. If you specify both a character set and a collation explicitly, the character set and collation are used.

-- 2.If you specify a character set and omit the collation,
--    the default collation of the character set is used.
-- 3. If you specify a collation without a character set, 
-- the character set associated with the collation is used.
-- 4.If you omit both character set and collation, the default character set and collation are used.

-- Examples of setting character sets and collation

-- First: create a database with utf8 and utf8_unicode_ci.
-- Because we set them explicitly, mydb does not take the server's defaults.
CREATE DATABASE mydb
CHARACTER SET utf8
COLLATE utf8_unicode_ci;

-- Second: create table t1 in mydb without giving settings.
-- It uses the database's settings: utf8 and utf8_unicode_ci.
USE mydb;

CREATE TABLE t1(
    c1 char(25)
);

-- Third: change the table's settings to latin1 and latin1_german1_ci.
ALTER TABLE t1
CHARACTER SET latin1
COLLATE latin1_german1_ci;
-- The c1 column now has latin1 and latin1_german1_ci.

-- Finally: change only the character set of column c1 to latin1.
ALTER TABLE t1
MODIFY c1 VARCHAR(25)
CHARACTER SET latin1;

-- Does c1 inherit latin1_german1_ci from the table? No.
-- The default collation of latin1 is latin1_swedish_ci,
-- so c1 gets latin1_swedish_ci.

-- Summary
-- A collation is a set of rules for comparing characters. You can set the
-- character set and collation at the server, database, table, and column
-- levels.