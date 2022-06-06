CREATE TABLE album (
  id SERIAL,
  title VARCHAR(128) UNIQUE,
  PRIMARY KEY(id)
);

CREATE TABLE track (
    id SERIAL,
    title VARCHAR(128),
    len INTEGER, rating INTEGER, count INTEGER,
    album_id INTEGER REFERENCES album(id) ON DELETE CASCADE,
    UNIQUE(title, album_id),
    PRIMARY KEY(id)
);

DROP TABLE IF EXISTS track_raw;
CREATE TABLE track_raw
 (title TEXT, artist TEXT, album TEXT, album_id INTEGER,
  count INTEGER, rating INTEGER, len INTEGER);

\copy track_raw(title,artist,album,count,rating,len) from 'library.csv' with delimiter ',' csv;

INSERT INTO album (title) SELECT DISTINCT title FROM track_raw order by title;
select * from album;
-- i made a mistake, we should start again:
delete from album;
ALTER SEQUENCE album_id_seq RESTART WITH 1;


INSERT INTO album (title) SELECT DISTINCT album FROM track_raw order by album;
select * from album;

UPDATE track_raw SET album_id = (SELECT album.id FROM album WHERE album.title = track_raw.album);
SELECT * FROM track_raw;

INSERT INTO track (title,len,rating,count,album_id) SELECT DISTINCT title,len,rating,count,album_id FROM track_raw;
select * from track;
