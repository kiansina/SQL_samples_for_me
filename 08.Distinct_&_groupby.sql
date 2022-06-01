-- DISTINCT only returns unique rows in a result set - and row will only appear once
--
-- DISTINCT ON limits duplicate removal to a set of columns
--
-- GROUP BY is combined with aggregate function like count(), max(), sum(), ave() ...


create table racing (
 make text,
 model text,
 year text,
 price text
);

insert into racing (make, model, year, price) values ('Nissan', 'Stanza', 1990, 2000);
insert into racing (make, model, year, price) values ('Dodge', 'Neon', 1995, 800);
insert into racing (make, model, year, price) values ('Dodge', 'Neon', 1998, 2500);
insert into racing (make, model, year, price) values ('Dodge', 'Neon', 1999, 3000);
insert into racing (make, model, year, price) values ('Ford', 'Mustang', 2001, 1000);
insert into racing (make, model, year, price) values ('Ford', 'Mustang', 2005, 2000);
insert into racing (make, model, year, price) values ('Subaru', 'Impreza', 1997, 1000);
insert into racing (make, model, year, price) values ('Mazda', 'Miata', 2001, 5000);
insert into racing (make, model, year, price) values ('Mazda', 'Miata', 2001, 3000);
insert into racing (make, model, year, price) values ('Mazda', 'Miata', 2001, 2500);
insert into racing (make, model, year, price) values ('Mazda', 'Miata', 2002, 5500);
insert into racing (make, model, year, price) values ('Opel', 'GT', 1972, 1500);
insert into racing (make, model, year, price) values ('Opel', 'GT', 1969, 7500);
insert into racing (make, model, year, price) values ('Opel', 'Cadet', 1973, 500);
--
-- DISTINCT
--
select distinct model from racing;
select distinct make,model from racing;
--
-- DISTINCT ON
--
select distinct on (make)
make, model from racing;
--
-- Group by
--
select count(model), model from racing group by model;

select count(model) as CntMdl, model from racing
where year = '2001' group by model having count(model)>1;

--HAVING is like a WHERE clause that happens after the calculation. HAVING is just kind of like another way to say WHERE, okay? It really looks the same.
--The difference is in the HAVING clause, you can put this COUNT model in that HAVING clause, but you can't put it in this WHERE clause and you can't move
--the WHERE clause after the GROUP BY.
