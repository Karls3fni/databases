use sakila;

-- Execute a query to retrieve all movies released after 2005 from the film table.
select * from film where release_year > 2005;

-- Store the result in a new table called recent_films
create table recent_films as
select * from film where release_year > 200;

