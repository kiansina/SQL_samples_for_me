create table account (
 id serial,
 email varchar(128) unique,
 created_at date not null default now(),
 updated_at date not null default now(),
 primary key(id)
);

create table post (
 id serial,
 title varchar(128) unique not null,
 content varchar(1024),
 account_id integer references account(id) on delete cascade,
 created_at timestamptz not null default now(),
 updated_at timestamptz not null default now(),
 primary key(id)
);




create table fav (
 id serial,
 oops text,
 post_id integer references post(id) on delete cascade,
 account_id integer references account(id) on delete cascade,
 unique(post_id,account_id),
 primary key(id)
);

alter table fav drop column oops;
alter table post alter column content type text;
alter table fav add column howmuch integer;
