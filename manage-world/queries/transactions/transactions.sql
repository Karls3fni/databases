use world;

-- Part 6
-- Start a transaction and insert a new city into the city table. Rollback the transaction after checking the inserted data.

-- Starts transition
BEGIN;

-- Insert a new city in the city table 
INSERT INTO city (name, countrycode, population)
VALUES ('NewCity', 'USA', 500000);

-- Verify insert data 
SELECT * FROM city WHERE name = 'NewCity';

-- ROLLBACK to undo the changes made  
ROLLBACK;

-- Verify that city were delete after rollback 
SELECT * FROM city WHERE name = 'NewCity';  -- Dont have to show

-- Begin a transaction that inserts a new city into the city table and updates the population of an existing country in the country table. 
-- Commit the transaction only if both operations are successful. If any operation fails, rollback the transaction.

-- Starts transition
BEGIN;

-- Insert a new city
INSERT INTO city (name, countrycode, population)
VALUES ('NewCity', 'USA', 500000);

-- Update population from country that exists 
UPDATE country
SET population = population + 500000
WHERE code = 'USA';

-- Commit transition if both operations success 
COMMIT;

-- If some operation fails, we will use ROLLBACK instead 
-- In error case, transition will completly throw back

-- Use SAVEPOINT and ROLLBACK TO SAVEPOINT to manage partial rollbacks during the transaction

-- Starts transition
BEGIN;

-- Insert new city
INSERT INTO city (name, countrycode, population)
VALUES ('NewCity', 'USA', 500000);

-- Set savepoint to do partial rollback if we need it 
SAVEPOINT my_savepoint;

-- Try to do update operation 
UPDATE country
SET population = population + 500000
WHERE code = 'USA';

-- Emulate that an error happen in update operation for exampple: 
-- If there's no country with "USA" code, update won't correctly execute

-- Do partial rollback until SAVEPOINT if was error 
ROLLBACK TO SAVEPOINT my_savepoint;

-- Confirms that only the city insert was execute 
SELECT * FROM city WHERE name = 'NewCity';  -- Debe aparecer
SELECT * FROM country WHERE code = 'USA';  -- La población no se habrá actualizado

-- Create a situation where you simulate an error in the middle of a transaction to show how rollback works.

-- Starts transition
BEGIN;

-- Insert new city
INSERT INTO city (name, countrycode, population)
VALUES ('NewCity', 'USA', 500000);

-- Emulate an erorr on next step 
-- This could be a foreign key violation failure, such as trying to insert a non-existent country
-- Suppose we try to insert a city with an invalid country code
INSERT INTO city (name, countrycode, population)
VALUES ('InvalidCity', 'XXX', 1000000);  -- 'XXX' not a valid city code

-- If an error happen, completly transition will throw back 