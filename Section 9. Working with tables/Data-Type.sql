-- MySQL Data Types
/*A table contains multiple columns with specific data types such as numeric or string. MySQL provides more data types other than just numeric and string*/

-- MySQL numeric data types 
-- Numeric types can be signed or unsigned, except BIT. They cover integers, fixed-point, floating-point, and bit values.

-- ============================================
-- MySQL Data Types Demo
-- One database, one table per category
-- ============================================

DROP DATABASE IF EXISTS datatypes_demo;
CREATE DATABASE datatypes_demo;
USE datatypes_demo;

-- ============================================
-- 1. NUMERIC TYPES (+ BOOLEAN)
-- ============================================
CREATE TABLE numeric_demo (
    id            INT AUTO_INCREMENT PRIMARY KEY,
    tiny_col      TINYINT UNSIGNED,       -- very small integer (0 to 255)
    small_col     SMALLINT,               -- small integer
    medium_col    MEDIUMINT UNSIGNED,     -- medium integer
    int_col       INT,                    -- standard integer
    big_col       BIGINT,                 -- large integer
    decimal_col   DECIMAL(10,2),          -- exact fixed-point (money)
    float_col     FLOAT,                  -- approximate, single precision
    double_col    DOUBLE,                 -- approximate, double precision
    bit_col       BIT(4),                 -- bit field
    is_active     BOOLEAN                 -- same as TINYINT(1)
);

INSERT INTO numeric_demo
    (tiny_col, small_col, medium_col, int_col, big_col,
     decimal_col, float_col, double_col, bit_col, is_active)
VALUES
    (21, 3500, 1200000, 2000000000, 9876543210123,
     1499.99, 36.6, 12.345678901, b'1010', TRUE);

SELECT *, BIN(bit_col) AS bit_as_binary FROM numeric_demo;

-- ============================================
-- 2. STRING TYPES
-- ============================================
CREATE TABLE string_demo (
    id            INT AUTO_INCREMENT PRIMARY KEY,
    char_col      CHAR(2),                -- fixed length text
    varchar_col   VARCHAR(100),           -- variable length text
    binary_col    BINARY(4),              -- fixed length binary
    varbinary_col VARBINARY(64),          -- variable length binary
    tinyblob_col  TINYBLOB,               -- very small binary object
    blob_col      BLOB,                   -- small binary object
    mediumblob_col MEDIUMBLOB,            -- medium binary object
    longblob_col  LONGBLOB,               -- large binary object
    tinytext_col  TINYTEXT,               -- very small text
    text_col      TEXT,                   -- small text
    mediumtext_col MEDIUMTEXT,            -- medium text
    longtext_col  LONGTEXT,               -- large text
    enum_col      ENUM('pending','shipped','delivered'),  -- ONE value from list
    set_col       SET('sql','js','python')                -- ZERO or MORE from list
);

INSERT INTO string_demo
    (char_col, varchar_col, binary_col, varbinary_col,
     tinyblob_col, blob_col, mediumblob_col, longblob_col,
     tinytext_col, text_col, mediumtext_col, longtext_col,
     enum_col, set_col)
VALUES
    ('KE', 'Maxmillin', UNHEX('A1B2C3D4'), UNHEX('FFAA'),
     'tiny', 'small', 'medium', 'large',
     'Call back tomorrow', 'This is a blog post body.',
     'A longer article goes here.', 'A very long book or log goes here.',
     'shipped', 'sql,js');

SELECT * FROM string_demo;

-- ============================================
-- 3. DATE AND TIME TYPES
-- ============================================
CREATE TABLE datetime_demo (
    id            INT AUTO_INCREMENT PRIMARY KEY,
    date_col      DATE,                   -- YYYY-MM-DD
    time_col      TIME,                   -- hh:mm:ss
    datetime_col  DATETIME,               -- date + time, stored as entered
    timestamp_col TIMESTAMP DEFAULT CURRENT_TIMESTAMP
                  ON UPDATE CURRENT_TIMESTAMP,  -- auto-updates on row change
    year_col      YEAR                    -- year only
);

INSERT INTO datetime_demo (date_col, time_col, datetime_col, year_col)
VALUES ('2000-05-14', '08:30:00', '2026-10-09 16:00:00', 2026);

SELECT * FROM datetime_demo;

-- ============================================
-- 4. SPATIAL TYPES
-- ============================================
CREATE TABLE spatial_demo (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    geometry_col    GEOMETRY,             -- any spatial type
    point_col       POINT,                -- one X-Y location
    line_col        LINESTRING,           -- a line (road)
    polygon_col     POLYGON,              -- a closed area
    geomcoll_col    GEOMETRYCOLLECTION,   -- mixed group
    multipoint_col  MULTIPOINT,           -- many points
    multiline_col   MULTILINESTRING,      -- many lines
    multipoly_col   MULTIPOLYGON          -- many polygons
);

INSERT INTO spatial_demo VALUES (
    NULL,
    ST_GeomFromText('POINT(1 1)'),
    ST_GeomFromText('POINT(37.0 -0.3)'),
    ST_GeomFromText('LINESTRING(0 0, 5 5, 10 5)'),
    ST_GeomFromText('POLYGON((0 0, 4 0, 4 4, 0 4, 0 0))'),
    ST_GeomFromText('GEOMETRYCOLLECTION(POINT(1 1), LINESTRING(0 0, 2 2))'),
    ST_GeomFromText('MULTIPOINT((0 0), (5 5))'),
    ST_GeomFromText('MULTILINESTRING((0 0, 1 1), (2 2, 3 3))'),
    ST_GeomFromText('MULTIPOLYGON(((0 0, 1 0, 1 1, 0 1, 0 0)), ((2 2, 3 2, 3 3, 2 3, 2 2)))')
);

-- ST_AsText makes the spatial values readable
SELECT
    ST_AsText(point_col)   AS point_text,
    ST_AsText(line_col)    AS line_text,
    ST_AsText(polygon_col) AS polygon_text
FROM spatial_demo;

-- ============================================
-- 5. JSON TYPE
-- ============================================
CREATE TABLE json_demo (
    id   INT AUTO_INCREMENT PRIMARY KEY,
    data JSON                             -- validated JSON document
);

INSERT INTO json_demo (data)
VALUES ('{"name": "Maxmillin", "skills": ["Node", "SQL"]}');

SELECT
    data->>'$.name'        AS name,
    data->>'$.skills[0]'   AS first_skill
FROM json_demo;

-- ============================================
-- CHECK EVERYTHING
-- ============================================
SHOW TABLES;
DESCRIBE numeric_demo;
DESCRIBE string_demo;
DESCRIBE datetime_demo;
DESCRIBE spatial_demo;
DESCRIBE json_demo;