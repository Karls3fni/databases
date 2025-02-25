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