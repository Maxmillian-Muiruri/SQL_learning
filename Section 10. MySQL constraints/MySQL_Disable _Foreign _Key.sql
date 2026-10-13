-- MySQL Disable Foreign Key Checks
-- foreign_key_checks is a MySQL setting that is ON by default. When you turn it OFF, MySQL stops enforcing foreign key rules, so you can insert, update, or delete rows that would normally be blocked.

-- To disable foreign key checks, you set the foreign_key_checks variable to zero as follows:

SET foreign_key_checks = 0;
-- To enable the foreign key constraint check, you set the value of the foreign_key_checks to 1:

SET foreign_key_checks = 1;
--   create  new tabl
CREATE TABLE countries(
    country_id INT AUTO_INCREMENT,
    country_name VARCHAR(255) NOT NULL,
    PRIMARY KEY(country_id)
);

CREATE TABLE cities(
    city_id INT AUTO_INCREMENT,
    city_name VARCHAR(255) NOT NULL,
    country_id INT NOT NULL,
    PRIMARY KEY(city_id),
    FOREIGN KEY(country_id) 
		REFERENCES countries(country_id)
);

-- insert a new row into cities
INSERT INTO cities(city_name, country_id)
VALUES('New York',1);


-- brings error
/* 0	246	12:39:39	INSERT INTO cities(city_name, country_id)
 VALUES('New York',1)	Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails (`fkdemo`.`cities`, CONSTRAINT `cities_ibfk_1` FOREIGN KEY (`country_id`) REFERENCES `countries` (`country_id`))	0.031 sec
 */
--   disable foreign key checks:
SET foreign_key_checks = 0;

--  insert a new row into the cities table:

INSERT INTO cities(city_name, country_id)
VALUES('New York',1);  -- INSERT statement executed successfully due to the foreign key check being disabled.

SELECT * FROM cities;

SET foreign_key_checks = 1;

--  insert a row into the countries table whose value in the column country_id is 1 to make the data consistent in both tables:
 
 INSERT INTO countries(country_id, country_name)
VALUES(1,'USA');
 
--  drop country table
DROP TABLE countries;   
-- it brings error to fix youn either drop the table cities and remove the countries table or disable foreign key checks and drop tables in any sequence 
 
--  disable the foreign key check:

SET foreign_key_checks = 0;
 
--   drop both tables countries and cities:

DROP TABLE countries;
DROP TABLE cities;
 
--  enable the foreign key check:

SET foreign_key_checks = 1;
 
 
 
 
 
 
 
 