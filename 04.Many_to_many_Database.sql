create table student (
  id serial,
  name varchar(128),
  email varchar (128) unique,
  primary key (id)
);

create table course(
  id serial,
  title varchar(128) unique,
  primary key (id)
);


-- Middle table (join table):
create table member(
  student_id integer references student(id) on delete cascade,
  course_id integer references course(id) on delete cascade,
  role integer,
  primary key(student_id,course_id)
);


insert into student (name, email) values ('Sina', 'sina@tsugi.org');
insert into student (name, email) values ('Kalle', 'kalleh@tsugi.org');
insert into student (name, email) values ('Gozal', 'pishan@tsugi.org');
select * from student;



insert into course (title) values ('Python');
insert into course (title) values ('SQL');
insert into course (title) values ('PHP');
select * from course;


insert into member (student_id, course_id, role) values (1, 1, 1);
insert into member (student_id, course_id, role) values (2, 1, 0);
insert into member (student_id, course_id, role) values (3, 1, 0);

insert into member (student_id, course_id, role) values (1, 2, 0);
insert into member (student_id, course_id, role) values (2, 2, 1);

insert into member (student_id, course_id, role) values (2, 3, 1);
insert into member (student_id, course_id, role) values (3, 3, 0);

select * from member;

select student.name, member.role, course.title
from student
join member on member.student_id = student.id
join course on member.course_id = course.id
order by course.title, member.role desc, student.name;
