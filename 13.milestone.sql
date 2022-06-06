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




create table comment (
 id serial,
 content text not null,
 account_id integer references account(id) on delete cascade,
 post_id integer references post(id) on delete cascade,
 created_at timestamptz not null default now(),
 updated_at timestamptz not null default now(),
 primary key(id)
);


create table fav (
 id serial,
 oops text,
 post_id integer references post(id) on delete cascade,
 account_id integer references account(id) on delete cascade,
 created_at timestamptz not null default now(),
 updated_at timestamptz not null default now(),
 unique(post_id, account_id),
 primary key(id)
);


alter table post alter column content type text;
alter table fav drop column oops;
alter table fav add column howmuch integer;



--
DELETE FROM account; -- Delet all records
ALTER SEQUENCE account_id_seq RESTART WITH 1; --after deleting records, id does not automatically strats from 1. we need this command to impose that.
ALTER SEQUENCE post_id_seq RESTART WITH 1;
ALTER SEQUENCE comment_id_seq RESTART WITH 1;
ALTER SEQUENCE fav_id_seq RESTART WITH 1;


INSERT INTO account(email) VALUES
('ed@umich.edu'), ('sue@umich.edu'), ('sally@umich.edu');

INSERT INTO post (title, content, account_id) VALUES
( 'Dictionaries', 'Are fun', 3),  -- sally@umich.edu
( 'BeautifulSoup', 'Has a complex API', 1), -- ed@mich.edu
( 'Many to Many', 'Is elegant', (SELECT id FROM account WHERE email='sue@umich.edu' ));

INSERT INTO comment (content, post_id, account_id) VALUES
( 'I agree', 1, 1), -- dict / ed
( 'Especially for counting', 1, 2), -- dict / sue
( 'And I don''t understand why', 2, 2), -- dict / sue
( 'Someone should make "EasySoup" or something like that',
    (SELECT id FROM post WHERE title='BeautifulSoup'),
    (SELECT id FROM account WHERE email='ed@umich.edu' )),
( 'Good idea - I might just do that',
    (SELECT id FROM post WHERE title='BeautifulSoup'),
    (SELECT id FROM account WHERE email='sally@umich.edu' ));
