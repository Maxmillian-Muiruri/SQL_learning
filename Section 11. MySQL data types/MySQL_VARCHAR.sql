-- MySQL VARCHAR Data Type

/*MySQL VARCHAR is the variable-length string whose length can be up to 65,535. MySQL stores a VARCHAR value as a 1-byte or 2-byte length prefix plus actual data.*/


--  create a new table that has two columns s1 and s2 with the length of 32765(+2 for length prefix) and 32766 (+2). Note that 32765+2+32766+2=65535, which is the maximum row size.

CREATE TABLE IF NOT EXISTS varchar_test (
    s1 VARCHAR(32765) NOT NULL,
    s2 VARCHAR(32766) NOT NULL
)  CHARACTER SET 'latin1' COLLATE LATIN1_DANISH_CI;


-- if we increase the length of the s1 column by 1.

CREATE TABLE IF NOT EXISTS varchar_test_2 (
    s1 VARCHAR(32766) NOT NULL, -- error
    s2 VARCHAR(32766) NOT NULL
)  CHARACTER SET 'latin1' COLLATE LATIN1_DANISH_CI;

-- MySQL will issue the error message:

-- If you insert a string whose length is greater than the length of a VARCHAR column, MySQL will issue an error and skip inserting data. For example:

CREATE TABLE itemss (
    id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(3)
);

INSERT INTO itemss(title)
VALUES('ABCD');


-- MySQL VARCHAR and spaces 
/* MySQL does not pad VARCHAR values with spaces. It stores only what you give it.
 MySQL keeps trailing spaces when you insert and retrieve VARCHAR values. This is different from CHAR, which pads on storage and trims on retrieval.*/


-- example
INSERT INTO itemss(title)
VALUES('AB ');


SELECT 
    id, title, length(title)
FROM
    itemss;
    
    /* MySQL will truncate the trailing spaces when inserting a VARCHAR value that contains trailing spaces which cause the column length exceeded.
    In addition, MySQL issues a warning*/
    
    -- example:

INSERT INTO items(title)
VALUES('ABC '); -- it brings an error
  /*0	403	22:05:25	INSERT INTO items(title)
 VALUES('ABC ')	Error Code: 1054. Unknown column 'title' in 'field list'	0.016 sec*/  

-- To show the warning message, you can use the SHOW WARNINGS statement:

SHOW WARNINGS;

SELECT 
    title, LENGTH(title)
FROM
    itemss;







 