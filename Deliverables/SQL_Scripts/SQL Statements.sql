use sakila;
show tables;

select * from actor;

insert into actor (first_name, last_name) values ("CRISTIANO", "RONALDO"); 

update actor
set first_name = "KYLIAN", last_name = "MBAPPE" 
where actor_id > 200;

delete from actor 
where actor_id > 200;

alter table actor
add premio_oscar VARCHAR(225);

	update actor
	set premio_oscar = "NO"
	where actor_id > 200;

alter table actor
drop column premio_oscar;

alter table actor
modify column premio_oscar VARCHAR(2);

create table skere (diablo int);

truncate table skere;
