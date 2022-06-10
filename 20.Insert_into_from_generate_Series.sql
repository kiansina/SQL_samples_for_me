create table bigtext  (
 content TEXT
);

 insert into bigtext (content) select 'This is record number ' || generate_series(100000 ,199999 )|| ' of quite a few text records.' ;
