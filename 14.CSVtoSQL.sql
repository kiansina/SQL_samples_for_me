drop table if exists xy_raw;
drop table if exists y;
drop table if exists xy;

create table xy_raw(x text, y text, y_id integer);
create table y (id serial, primary key(id), y text);
create table xy (id serial, primary key(id), x text, y_id integer, unique(x,y_id));

-- copy from csv to sql
\copy xy_raw(x,y) from "C:\Users\sina.kian\Desktop\New folder\Postgresql\2\03-Techniques.csv" with delimeter ',' csv;

select * from xy_raw;
select distinct y from xy_raw;
select distinct y from xy_raw order by y;

-- insert to one table querying other table:
INSERT INTO y (y) SELECT DISTINCT y FROM xy_raw order by y;
select * from y;

UPDATE xy_raw SET y_id = (SELECT y.id FROM y WHERE y.y = xy_raw.y);
SELECT * FROM xy_raw;

INSERT INTO xy (x, y_id) SELECT x, y_id FROM xy_raw;
SELECT * FROM xy;

-- making a join:
SELECT * FROM xy JOIN y ON xy.y_id = y.id;

ALTER TABLE xy_raw DROP COLUMN y;

DROP TABLE xy_raw;
