create table textfun(
  content text
);

create index textfun_b on textfun (content);

select pg_relation_size('textfun'), pg_indexes_size('textfun');

insert into textfun (content)
  select (case when (random() < 0.5)
          then 'https://www.pg4e.com/neon/'
          else 'http://www.pg4e.com/Lemons/'
          end) || generate_series(100000,200000);

select pg_relation_size('textfun'), pg_indexes_size('textfun');

select content from textfun where content like '%150000%';
--https://www.pg4e.com/neon/150000
select upper(content) from textfun where content like '%150000%';
--HTTPS://WWW.PG4E.COM/NEON/150000
select lower(content) from textfun where content like '%150000%';
--https://www.pg4e.com/neon/150000
select right(content,4) from textfun where content like '%150000%';
--0000
select left(content,4) from textfun where content like '%150000%';
--http


-- More on this:
select strpos(content, 'ttps://') from textfun where content like '%150000%';
-- 2
select substr(content, 2,4) from textfun where content like '%150000%';
-- ttps
select split_part(content, '/',4) from textfun where content like '%150000%';
-- neon
select translate(content, 'th.p/', 'TH!P_') from textfun where content like '%150000%';
-- HTTPs:__www!Pg4e!com_neon_150000



explain analyze select content from textfun where content like 'racing%';
explain analyze select content from textfun where content like '%racing%';
explain analyze select content from textfun where content ilike 'racing%';




explain analyze select content from textfun where content like '%racing%';
explain analyze select content from textfun where content like '%racing%' limit 1;


explain analyze select content from textfun where content in ('https://www.pg4e.com/neon/150000','http://www.pg4e.com/neon/150000');




explain analyze select content from textfun where content in (select content from textfun where content like '%150000%');
