use world;

-- Part 3
-- Write a query to find all countries where the population is greater than 50 million but less than 200 million.
SELECT name, population
FROM country
WHERE population > 50000000 AND population < 200000000;

-- Use IN to find all countries with population in a specific range (e.g., between 20 million and 50 million).
SELECT name, population
FROM country
WHERE population BETWEEN 20000000 AND 50000000;

-- Use the AND, OR, and NOT operators to write a query that retrieves all cities where the population is between 1 million and 10 million, but excludes cities in the "Asia" region.
SELECT name, population, countrycode
FROM city
WHERE population BETWEEN 1000000 AND 10000000
  AND NOT EXISTS (
    SELECT 1 FROM country WHERE countrycode = city.countrycode AND region = 'Asia'
  );

-- Write a query that retrieves countries where the population is either over 100 million or the region is “Europe”.
SELECT name, population, region
FROM country
WHERE population > 100000000 OR region = 'Europe';

-- Combine LIKE and NOT to find cities with names starting with 'A' but exclude those that end with 'n'.
SELECT name
FROM city
WHERE name LIKE 'A%' AND name NOT LIKE '%n';