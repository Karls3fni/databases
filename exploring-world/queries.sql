USE world;
SHOW TABLES;
SELECT * FROM country;
SELECT * FROM countrylanguage;
SELECT * FROM city;
-- Retrieve all country names and their official languages.
SELECT NAME, LANGUAGE
FROM country
INNER JOIN countrylanguage
WHERE country.Code = countrylanguage.CountryCode;
-- List all cities in Germany along with their population.
SELECT city.name, city.population
FROM city
INNER JOIN country 
WHERE country.name = "Germany" AND city.countrycode = country.code;
-- Find the five smallest countries by surface area.
SELECT country.name, country.SurfaceArea
FROM country
ORDER BY country.SurfaceArea asc
LIMIT 5;
-- Find all countries with a population greater than 50 million and sort them in descending order of population.
SELECT country.name, population
FROM country
WHERE population > 50000000
ORDER BY population DESC;
-- Retrieve the average life expectancy per continent.
SELECT continent, AVG(LifeExpectancy) AS AverageLifeExpectancy
FROM country
GROUP BY continent;
-- Calculate the total population per region.
SELECT Region, SUM(Population) AS TotalPopulation
FROM country
GROUP BY Region;
-- Count the number of cities in each country and sort by the highest count.
SELECT country.Name AS Pais, COUNT(city.ID) AS CityNumber
FROM country
JOIN city ON country.Code = city.CountryCode
GROUP BY country.Name
ORDER BY CityNumber DESC;
-- Display the top 10 largest cities along with their country name.
SELECT city.Name AS City, country.Name AS Country, city.Population AS Population
FROM city
JOIN country ON city.CountryCode = country.Code
ORDER BY city.Population DESC
LIMIT 10;
-- Retrieve the names of all countries that have an official language of French.
SELECT country.Name AS Pais
FROM country
JOIN countrylanguage ON country.Code = countrylanguage.CountryCode
WHERE countrylanguage.Language = 'French' AND countrylanguage.IsOfficial = 'T';
-- Find all countries where English is spoken, but it is not the official language.
SELECT DISTINCT country.Name AS Pais
FROM country
JOIN countrylanguage ON country.Code = countrylanguage.CountryCode
WHERE countrylanguage.Language = 'English' AND countrylanguage.IsOfficial = 'F';
-- Find countries where the population tripled in the past 50 years (if historical data is available).
SELECT Name AS Pais
FROM country
WHERE IndepYear IS NOT NULL
AND Population >= 3 * 1000000; -- Ajusta el valor según tu criterio de "triplicado"
-- List the richest and poorest countries in each continent based on GNP (Gross National Product).
SELECT Continent, 
       MAX(Name) AS PaisMasRico, MAX(GNP) AS MayorGNP,
       MIN(Name) AS PaisMasPobre, MIN(GNP) AS MenorGNP
FROM country
WHERE GNP > 0
GROUP BY Continent;
-- Identify countries with a life expectancy below the global average.
SELECT Name AS Pais, LifeExpectancy
FROM country
WHERE LifeExpectancy < (SELECT AVG(LifeExpectancy) FROM country)
AND LifeExpectancy IS NOT NULL;
-- Retrieve the capital cities of countries with a population above 100 million.
SELECT city.Name AS Capital, country.Name AS Pais
FROM country
JOIN city ON country.Capital = city.ID
WHERE country.Population > 100000000;
-- Find the continent with the highest number of countries.
SELECT Continent, COUNT(Code) AS NumeroPaises
FROM country
GROUP BY Continent
ORDER BY NumeroPaises DESC
LIMIT 1;