create table automagic (
 id serial,
 name varchar(32),
 height float not null
);
--5.4. Constraints
--5.4.1. Check Constraints
-- EX:                     CREATE TABLE products (
--                             product_no integer,
--                             name text,
--                             price numeric CHECK (price > 0)
--                         );


-- 5.4.2. Not-Null Constraints
-- EX:                     CREATE TABLE products (
--                             product_no integer NOT NULL,
--                             name text NOT NULL,
--                             price numeric
--                         );


-- 5.4.3. Unique Constraints
-- EX:                     CREATE TABLE products (
--                             product_no integer UNIQUE,
--                             name text,
--                             price numeric
--                         );

-- 5.4.4. Primary Keys: it equals with both Unique and Not Null
-- EX:                     CREATE TABLE products (
--                             product_no integer PRIMARY KEY,
--                             name text,
--                             price numeric
--                         );

-- 5.4.5. Foreign Keys
-- EX:

-- 5.4.6. Exclusion Constraints
-- EX:

CREATE TABLE track_raw
 (title TEXT, artist TEXT, album TEXT,
  count INTEGER, rating INTEGER, len INTEGER);

\copy track_raw(title,artist,album,count,rating,len) FROM 'library.csv' WITH DELIMITER ',' CSV;

SELECT title, album FROM track_raw ORDER BY title LIMIT 3;
