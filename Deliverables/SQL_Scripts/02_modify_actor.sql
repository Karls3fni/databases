use sakila;
select * from actor;

-- Using the actor table, insert a new record with fictitious data
insert into actor (first_name, last_name) values ("CRISTIANO", "RONALDO");

-- Update an existing record by changing the last name of an actor
update actor
set first_name = "KYLIAN", last_name = "MBAPPE"
where actor_id > 200;

-- Delete an actor from the table.
delete from actor
where actor_id > 200;