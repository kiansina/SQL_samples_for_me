DROP TABLE unesco_raw;
CREATE TABLE unesco_raw
 (name TEXT, description TEXT, justification TEXT, year INTEGER,
    longitude FLOAT, latitude FLOAT, area_hectares FLOAT,
    category TEXT, category_id INTEGER, state TEXT, state_id INTEGER,
    region TEXT, region_id INTEGER, iso TEXT, iso_id INTEGER);

CREATE TABLE category (
  id SERIAL,
  name VARCHAR(128) UNIQUE,
  PRIMARY KEY(id)
);

\copy unesco_raw(name,description,justification,year,longitude,latitude,area_hectares,category,state,region,iso) FROM 'whc-sites-2018-small.csv' WITH DELIMITER ',' CSV HEADER;  -- Adding HEADER causes the CSV loader to skip the first line in the CSV file.
--\copy unesco_raw(name,description,justification,year,longitude,latitude,area_hectares,category,state,region,iso) FROM 'whc-sites-2018-small.csv?PHPSESSID=bc68c653885797948ea86f3af6fe213f"' WITH DELIMITER ',' CSV HEADER;
select category_id from unesco_raw limit 12;
insert into category (name) SELECT DISTINCT category FROM unesco_raw;

--alter table unesco_raw add column category_id integer REFERENCES category(id) ON DELETE CASCADE;
--alter table unesco_raw drop column category_id;
UPDATE unesco_raw SET category_id = (SELECT category.id FROM category WHERE unesco_raw.category = category.name);

CREATE TABLE state (
  id SERIAL,
  name VARCHAR(128) UNIQUE,
  PRIMARY KEY(id)
);
insert into state (name) SELECT DISTINCT state FROM unesco_raw;
UPDATE unesco_raw SET state_id = (SELECT state.id FROM state WHERE unesco_raw.state = state.name);
select state_id from unesco_raw limit 12;


CREATE TABLE region (
  id SERIAL,
  name VARCHAR(128) UNIQUE,
  PRIMARY KEY(id)
);
insert into region (name) SELECT DISTINCT region FROM unesco_raw;
UPDATE unesco_raw SET region_id = (SELECT region.id FROM region WHERE unesco_raw.region = region.name);
select region_id from unesco_raw limit 12;


CREATE TABLE iso (
  id SERIAL,
  name VARCHAR(128) UNIQUE,
  PRIMARY KEY(id)
);
insert into iso (name) SELECT DISTINCT iso FROM unesco_raw;
UPDATE unesco_raw SET iso_id = (SELECT iso.id FROM iso WHERE unesco_raw.iso = iso.name);
select iso_id from unesco_raw limit 12;


CREATE TABLE unesco
 (name TEXT, description TEXT, justification TEXT, year INTEGER,
    longitude FLOAT, latitude FLOAT, area_hectares FLOAT,
    category_id INTEGER, state_id INTEGER,
    region_id INTEGER, iso_id INTEGER);

insert into unesco(name, description, justification, year,
   longitude, latitude, area_hectares,
   category_id, state_id,
   region_id, iso_id) select name, description, justification, year,
      longitude, latitude, area_hectares,
      category_id, state_id,
      region_id, iso_id from unesco_raw;




--auto grader
SELECT unesco.name, year, category.name, state.name, region.name, iso.name
  FROM unesco
  JOIN category ON unesco.category_id = category.id
  JOIN iso ON unesco.iso_id = iso.id
  JOIN state ON unesco.state_id = state.id
  JOIN region ON unesco.region_id = region.id
  ORDER BY iso.name, unesco.name
  LIMIT 3;
