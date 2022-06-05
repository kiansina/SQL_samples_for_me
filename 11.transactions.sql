drop table fav;
create table fav (
  id serial,
  post_id integer,
  account_id integer,
  howmuch integer,
  unique(post_id, account_id),
  primary key(id)
);

insert into fav (post_id, account_id, howmuch)
  values(1,1,1)
  on conflict (post_id, account_id)
  do update set howmuch = fav.howmuch+1
  returning *;

-- start of transactions:
begin;
select howmuch from fav where account_id = 1 and post_id = 1 for update of fav;
-- time passes
update fav set howmuch = 999 where account_id = 1 and post_id = 1;
  select howmuch from fav where account_id = 1 and post_id = 1;
  rollback;
  select howmuch from fav where account_id = 1 and post_id = 1;



  begin;
  select howmuch from fav where account_id = 1 and post_id = 1 for update of fav;
  -- time passes
  update fav set howmuch = 999 where account_id = 1 and post_id = 1;
    select howmuch from fav where account_id = 1 and post_id = 1;
    commit;
    select howmuch from fav where account_id = 1 and post_id = 1;
