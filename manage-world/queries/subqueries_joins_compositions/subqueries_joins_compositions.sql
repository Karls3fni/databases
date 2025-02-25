use world;

-- Part 4
-- Write a subquery that lists countries that have more than 5 cities with a population greater than 1 million.
SELECT name
FROM country
WHERE countrycode IN (
    SELECT countrycode
    FROM city
    WHERE population > 1000000
    GROUP BY countrycode
    HAVING COUNT(*) > 5
);

-- Use a subquery in the WHERE clause to find all countries with more than 3 official languages.
SELECT name
FROM country
WHERE code IN (
    SELECT countrycode
    FROM countrylanguage
    WHERE isofficial = 'T'
    GROUP BY countrycode
    HAVING COUNT(*) > 3
);

-- Write a query that joins city, country, and countrylanguage to find cities with at least one official language spoken that is not English.
SELECT c.name AS city_name, co.name AS country_name
FROM city c
JOIN country co ON c.countrycode = co.code
JOIN countrylanguage cl ON co.code = cl.countrycode
WHERE cl.isofficial = 'T' AND cl.language != 'English';

-- Use a derived table to calculate the total population of each country (i.e., sum the populations of all cities in each country)
SELECT co.name AS country_name, SUM(c.population) AS total_population
FROM country co
JOIN city c ON co.code = c.countrycode
GROUP BY co.name;