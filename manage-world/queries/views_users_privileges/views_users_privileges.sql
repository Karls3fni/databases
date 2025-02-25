use world;

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