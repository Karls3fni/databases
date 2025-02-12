use world;
show tables from world;
describe world;
describe world.city;
describe world.countrylanguage;

alter table world.city
ADD column is_population_large BOOLEAN;

update world.city
set is_population_large = (Population > 1000000);

alter table world.country
add column region_code char(3) default 'NA';

-- Verify

Describe world.city;
describe world.country;

alter table world.city
add constraint chk_population_non_negative
check (population >= 0);

alter table world.country
add constraint unique_country_code
unique (code);

show create table world.city;
show create table world.country;

create index idx_city_name on world.city(name);

explain select * from world.city where name = 'Tokyo';

