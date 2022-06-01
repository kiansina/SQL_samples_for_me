psql -- in command line make a connection with postgre sql server and communicate sql commands
-- postgres is superuser (it has a pound sign)
--
create user Sina with password 'sina'
--
Create DataBase Strategica with owner 'sina'
--
\l --list the databases
--
\q --gets me out of that particular session
--
psql Strategica Sina
--
\dt -- shows the tables
--
\i filenam.sql --Runs the sql script saved in filename.sql
--
create table Clients (
  Name varchar(128),
  Location varchar(128)
);
--
\d+ -- shows the schema of tables
--
Insert into clients (Name, Location) values ('Ariston','Italy');
--
Delete from Clients where Location='Italy';
--
Update Clients set Name='Sicit' where Location='Italy';
--
Select * from Clients; -- Instead of * we can give the names of columns that we want. Intead * gives us all columns.
select * from Clients where Location='Italy';
select * from Clients order by Name;
select * from Clients order by Name desc;
select * from Clients where Location like '%I%'; --Wildcard: This basically is looking for things where the Location has the letter e in it anywhere because the percent signs function as the wildcards.
--this actually probably would force what's called a full table scan,
--
select * from Clients order by Location offset 1 limit 2; --The OFFSET and ORDER BY clauses happen before the LIMIT / OFFSET are applied.
-- The OFFSET starts from row 0
--
select count(*) from clients;
select count(*) from Clients where Location='Italy';


-- -- -- Data types:
-- Text fields
-- Binary fields
-- Numeric fields
-- Auto_increment fields


-- char(n) : allocates the entire space
-- varchar(n) : allocates a variable amount of space


-- Integer Numbers: increasing bytes (memories) from top to bottom
-- 1. smallint
-- 2. integer
-- 3. bigint


-- floating point numbers
-- 1. Real
-- 2. Double Precision
-- 3. Numeric(Accuracy, decimal)


-- Dates
-- 1. Timestamp
-- 2. Date
-- 3. Time
-- 4. built in function Now()

--
drop table Clients;

create table clients (
  id Serial,
  Name varchar (128),
  Location varchar(128) unique, --unique is a logical key
  primary key(id)
);

-- Trees and hashes are the most common indexes.
-- Now the problem with hashes, and the reason we don't use them for everything, is that hashes are only good for exact match. You are prefix matching, they are no good. The data gets completely non-sorted, so that's no good.
-- So if you're looking up like a name or you're going to do sorting, then hash doesn't work
