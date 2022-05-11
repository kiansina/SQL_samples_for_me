create database music with owner 'sina' encoding 'UTF8'

create table artist (
  id serial,
  name varchar(128) unique,
  primary key(id)
);

create table album (
  id serial,
  title varchar(128) unique,
  artist_id integer references artist(id) on delete cascade,
  primary key(id)
);

create table genre (
  id serial,
  name varchar(128) unique,
  primary key (id)
);

create table track(
  id serial,
  title varchar(128),
  len integer,
  rating integer,
  count integer,
  album_id integer references album(id) on delete cascade,
  genre_id integer references genre(id) on delete cascade,
  unique (title, album_id),
  primary key(id)
);

insert into artist (name) values ('Led Zeppelin');
insert into artist (name) values ('AC\DC');

insert into album (title, artist_id) values ('who made who', 2);
insert into album (title, artist_id) values ('IV', 1);

insert into genre (name) values ('Rock');
insert into genre (name) values ('Metal');
select * from genre;

insert into track (title, rating, len, count, album_id, genre_id) values ('Black Dog', 5, 297, 0, 2, 1);
insert into track (title, rating, len, count, album_id, genre_id) values ('Stairway', 5, 482, 0, 2, 1);
insert into track (title, rating, len, count, album_id, genre_id) values ('About to Rock', 5, 313, 0, 1, 2);
insert into track (title, rating, len, count, album_id, genre_id) values ('Who Made Who', 5, 207, 0, 1, 2);
select * from track;



-- -- -- -- -- -- JOIN tables.
select * from album;
select * from artist;
select album.title, artist.name
from album join artist
on album.artist_id = artist.id;
--
--
--
select album.title, album.artist_id, artist.id, artist.name
from album inner join artist
on album.artist_id = artist.id;
--
--
--
select track.title, track.genre_id, genre.id, genre.name
from track cross join genre;

--
select track.title, artist.name, album.title, genre.name
from track
    join genre on track.genre_id = genre.id
    join album on track.album_id = album.id
    join artist on album.artist_id = artist.id;

-- -- -- -- -- -- -- -- CASCADE effect
select * from track;
select * from genre;
delete from genre where name = 'Metal';
select * from track;
select * from genre;
-- !!!!!!!!!!!!!!!!!!!!!!!!!! POINT:
-- -- -- On delete choices:
--              1. default / restrict : Don't allow changes that break the constrain.
--              2. cascade : adjust child rows by removing or updating to maintain consistency
--              3. set null : set the foreign key columns in the child rows to null


Update genre set name='POP' where name='Metal';
