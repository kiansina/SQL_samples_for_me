-- Subqueries Should not be used in online systems. they decrease optimization.
-- If we use it once, 5 seconds does not chane any thing. But if it is online and millions of people would use that it would be problem.
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

-- it can be done with more tables and IDs

  select * from racing
  where model ='Impreza';

  select make from racing
  where (year, price)=('1997','1000');

  select make from racing
  where (year) = (select year from racing where model='Impreza');




  select year from racing
  where model ='Impreza';

  select make from racing
  where year=('1997');

  select make from racing
  where (year) = (select year from racing where model='Impreza');





-- do you remember below code? including 'having' ?
-- Imagine there was not 'having' option, how could you query using subqueries?

select count(model) as CntMdl, model from racing
where year = '2001' group by model having count(model)>1;

-- Using Subqueries:
select CntMdl , model from
(
   select count(model) as CntMdl, model
   from racing
   where year='2001' group by model
) as side_table
where CntMdl>1;
