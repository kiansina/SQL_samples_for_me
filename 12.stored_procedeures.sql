-- !!!!!!!!!!!!! stored procedures are not portable to other databases.




-- for auto updating update time column
update fav set howmuch = howmuch+1
  where post_id = 1 and account_id = 1
returning *;

-- The above code won't update, the column update_at which is showing update's last date.

-- First solution:
update fav set howmuch = howmuch+1, updated_at = now()
  where post_id = 1 and account_id = 1
returning *;

-- Second solution stored procedures
create or replace function trigger_set_timestramp()
  returns trigger as $$
begin
new.update_at = now(); --new. means everything new happens like a change or an update.
return new;
end;
$$ language plpgsql;

create trigger set_timestamp
  before update on post
  for each row
  execute procedure trigger_set_timestamp();

create trigger set_timestamp
  before update on fav
  for each row
  execute procedure trigger_set_timestamp();

create trigger set_timestamp
  before update on comment
  for each row
  execute procedure trigger_set_timestamp();


-- after writing above code, now if we update something, the update_at column would be updated.
update fav set howmuch = howmuch+1
  where post_id = 1 and account_id = 1
returning *;
