create table cr1(
  id serial,
  url varchar(128) unique,
  content text
);


insert into cr1(url)
select repeat('Neon', 1000) || generate_series(1,5000);
--ERROR:  value too long for type character varying(128)



create table cr2(
  id serial,
  url text,
  content text
);

insert into cr2(url)
select repeat('Neon', 1000) || generate_series(1,5000);
-- Look at the size without index:
select pg_relation_size('cr2'), pg_indexes_size('cr2');

--###################################################
-- Create index type 1:
create unique index cr2_unique on cr2 (url);
-- Look at the size with index:
select pg_relation_size('cr2'), pg_indexes_size('cr2');

--###################################################
-- Drop first index and Create index type 2:
drop index cr2_unique;
create unique index cr2_md5 on cr2 (md5(url));
select pg_relation_size('cr2'), pg_indexes_size('cr2');
--###################################################

explain select * from cr2 where url='lemons'; --Here it makes a seq scan because url='lemon' is not in the index

explain select * from cr2 where md5(url)=md5('lemons'); --But here it makes a index scan because md5(url) is in the index

explain analyze select * from cr2 where md5(url)=md5('lemons');

explain analyze select * from cr2 where url='lemons';

--###################################################
-- Hashing with a separate column:
create table cr3(
  id serial,
  url text,
  url_md5 uuid unique, --uuid datatype is exactly the width of an MD5
  content text
);

insert into cr3(url)
select repeat('Neon', 1000) || generate_series(1,5000);
update  cr3 set url_md5=md5(url)::uuid;
select pg_relation_size('cr3'), pg_indexes_size('cr3');

explain analyze select * from cr3 where url_md5=md5('lemons')::uuid;




-- PostgreSQL Index Types:
--1) B-Tree - maintains order - Usually Preferred:
--              Helps on exact lookup, prefix lookup, <, >, range, sort

--2) HASH:
--              Smaller - helps only on exact lookup



create table cr4(
  id serial,
  url text,
  content text
);

insert into cr4(url)
select repeat('Neon', 1000) || generate_series(1,5000);

create index cr4_hash on cr4 using hash (url);

select pg_relation_size('cr4'), pg_indexes_size('cr4');

explain analyze select * from cr4 where url='lemons';
