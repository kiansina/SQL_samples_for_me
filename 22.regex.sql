-- ^ : the beginning of a line
-- $ : the end of the line
-- . : any character
-- * : repeat a character 0 or more times
-- *? : repeat a character 0 or more times (non-greedy)
-- + : repeat a character 1 or more times
-- +? : repeat a character 1 or more times (non-greedy)
-- [aeiou] : matches a single character in the listed set
--[^XYZ] : matches a single character not in the listed set
-- [a-z0-9] : the set of characters can include a range
-- ( : indicates where string extraction is to start
-- ) : indicates where string extraction is to end




-- In postgreSQL: where clause operates:
-- ~ : matches
-- ~* : matches case insensitive
-- !~ : does not match
-- !~* : does not match case insensitive

create table em(
  id serial,
  primary key(id),
  email text
);

insert into em (email) values ('csv@umich.edu');
insert into em (email) values ('coleen@umich.edu');
insert into em (email) values ('sally@uiuc.edu');
insert into em (email) values ('ted79@umuc.edu');
insert into em (email) values ('glenn1@apple.com');
insert into em (email) values ('nobody@apple.com');

select email from em where email ~ 'umich';

select email from em where email like '%umich%';


select email from em where email ~ '^c';

select email from em where email ~ 'edu$';

select email from em where email ~ '^[gnt]';

select email from em where email ~ '^[^gnt]';

select email from em where email ~ '[0-9]';

select email from em where email ~ '[0-9][0-9]';

select substring(email from '[0-9]+')
from em where email ~ '[0-9]';

select substring(email from '.+@(.*)$')
from em;

select distinct substring(email from '.+@(.*)$')
from em;

select substring(email from '.+@(.*)$'),
 count(substring(email from '.+@(.*)$'))
from em group by substring(email from '.+@(.*)$');


-- Substring() gets the first match in a text column
-- we can get an array of matches using regexp_matches()


create table tw(
  id serial,
  primary key(id),
  tweet text
);

insert into tw (tweet) values ('This is #SQL and #FUN stuff');
insert into tw (tweet) values ('More people should learn #SQL from #UMSI');
insert into tw (tweet) values ('#UMSI also teaches #PYTHON');

select tweet from tw;

select id, tweet from tw where tweet ~ '#SQL';

select regexp_matches(tweet,'#([A-Za-z0-9_]+)','g') from tw; -- 'g' means all way across
select distinct regexp_matches(tweet,'#([A-Za-z0-9_]+)','g') from tw;

select id,regexp_matches(tweet,'#([A-Za-z0-9_]+)','g') from tw;
