-- Date types:
-- 1. Date - 'YYYY-MM-DD'
-- 2. Time - 'HH:MM:SS'
-- 3. Timestamp - 'YYYY-MM-DD HH:MM:SS' (4714 BC, 294276 AD)
-- 4. Timestamptz - 'Timestamp with time zone'
-- 5. Built-in PostgreSQL function now()
select now();
select now() at time zone 'UTC'; --preferred is the default.
select now() at time zone 'HST';
--
--
--
select * from pg_timezone_names;
select * from pg_timezone_names where name like '%Hawai%';
select * from pg_timezone_names where name like '%Europe%';
select * from pg_timezone_names where name like '%Rome%';
--
--
--
select now()::date;
select cast(now() as date);
select cast(now() as time);


select now()::date, cast(now() as date), cast(now() as time);

select now(), now() - interval '2 days';
select (now() - interval '2 days')::date;

-- some times we want to discard some of the accuracy that is in a timestamp:
-- Option 1: (this is a fast query)
select id, content, created_at from comment
              where created_at >= date_trunc('day',now())
              and created_at < date_trunc('day', now()+interval '1 day')

-- Option 2: another method: (this is a slow query)
select id, content, created_at from comment
              where created_at::date = now()::date;
