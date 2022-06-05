drop table fav;
create table fav (
  id serial,
  post_id integer,
  account_id integer,
  howmuch integer,
  unique(post_id, account_id),
  primary key(id)
);

-- Do this twice:
insert into fav (post_id, account_id, howmuch)
  values(1,1,1)
  returning *;

update fav set howmuch=howmuch+1
  where post_id=1 and account_id=1
  returning *;

--
insert into fav (post_id, account_id, howmuch)
  values(1,1,1)
  on conflict (post_id, account_id)
  do update set howmuch = fav.howmuch+1
  returning *;

delete from fav;
