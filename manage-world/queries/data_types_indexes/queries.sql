use world;

-- Part 1
-- List all tables in the "world" database.
show tables from world;

-- Identify the different data types used in the country, city, and countrylanguage tables.
describe world.city;
describe world.country;
describe world.countrylanguage;

-- Add a new column is_population_large (BOOLEAN) to the city table
alter table world.city
ADD column is_population_large BOOLEAN;

-- This column will be TRUE if the population of the city is greater than 1 million, otherwise FALSE
update world.city
set is_population_large = (Population > 1000000);

-- Create a new column in the country table, region_code (CHAR(3)) with the DEFAULT 'NA' value.
alter table world.country
add column region_code char(3) default 'NA';

-- Add a CHECK constraint on the city table to ensure that the population value is never negative
alter table world.city
add constraint chk_population_non_negative
check (population >= 0);

-- Ensure that the country table’s code is unique using a UNIQUE constraint
alter table world.country
add constraint unique_country_code
unique (code);

-- Create an index on the city table for the name column. Analyze how the index improves search performance by querying the table with and without the index.
create index idx_city_name on world.city(name);
select * from world.city where name = 'Tokyo';

-- Part 2
-- Create a view named high_population_cities that shows cities with a population over 1 million. It should include the city name, country code, and population.
CREATE VIEW high_population_cities AS
SELECT name AS ciudad, countrycode AS codigo_pais, population AS poblacion
FROM world.city
WHERE population > 1000000;

-- Create another view countries_with_languages that joins country and countrylanguage to display country name and language spoken (excluding English language).
CREATE VIEW countries_with_languages AS
SELECT country.name AS nombre_pais, countrylanguage.language AS idioma
FROM world.country
JOIN world.countrylanguage ON country.code = countrylanguage.countrycode
WHERE countrylanguage.language != 'English';

-- Create a new user db_user with the following privileges:
CREATE USER 'db_user'@'localhost' IDENTIFIED BY 'contraseña123';
	-- Read access (SELECT) on the city and country tables.
	GRANT SELECT ON world.city TO 'db_user'@'localhost';
	GRANT SELECT ON world.country TO 'db_user'@'localhost';
    -- Write access (INSERT, UPDATE) on the city table.
	GRANT INSERT, UPDATE ON world.city TO 'db_user'@'localhost';
    
-- Revoke the ability of db_user to modify the country table.
REVOKE INSERT, UPDATE, DELETE ON world.country FROM 'db_user'@'localhost';

-- Grant the db_user full access to the high_population_cities view
GRANT SELECT, INSERT, UPDATE, DELETE ON world.high_population_cities TO 'db_user'@'localhost';