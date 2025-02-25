use world;

-- Part 5
-- Write a query that retrieves the 10 cities with the highest populations. (This will involve sorting and limiting the results).
SELECT name, population
FROM city
ORDER BY population DESC
LIMIT 10;

-- Investigate the performance of this query by running EXPLAIN on the query plan and observing what indexes are being used.
EXPLAIN SELECT name, population
FROM city
ORDER BY population DESC
LIMIT 10;

-- Rewrite the query using LIMIT and an appropriate index to optimize performance.
CREATE INDEX idx_population ON city(population);

SELECT name, population
FROM city
ORDER BY population DESC
LIMIT 10;

-- Write a query that searches for all cities with a population greater than 1 million and a name starting with "A". Ensure that the query is optimized using indexing.
SELECT name, population
FROM city
WHERE population > 1000000 AND name LIKE 'A%';

CREATE INDEX idx_population_name ON city(population, name);

SELECT name, population
FROM city
WHERE population > 1000000 AND name LIKE 'A%';
