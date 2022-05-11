CREATE TABLE student (
    id SERIAL,
    name VARCHAR(128) UNIQUE,
    PRIMARY KEY(id)
);

--DROP TABLE course CASCADE;
CREATE TABLE course (
    id SERIAL,
    title VARCHAR(128) UNIQUE,
    PRIMARY KEY(id)
);

--DROP TABLE roster CASCADE;
CREATE TABLE roster (
    id SERIAL,
    student_id INTEGER REFERENCES student(id) ON DELETE CASCADE,
    course_id INTEGER REFERENCES course(id) ON DELETE CASCADE,
    role INTEGER,
    UNIQUE(student_id, course_id),
    PRIMARY KEY (id)
);


insert into student (name) values ('Rachel');
insert into student (name) values ('Kris');
insert into student (name) values ('Linden');
insert into student (name) values ('Marie');
insert into student (name) values ('Safeena');
insert into student (name) values ('Ceiran');
insert into student (name) values ('Audrey');
insert into student (name) values ('Chidera');
insert into student (name) values ('Kier');
insert into student (name) values ('Parkash');
insert into student (name) values ('Jadon');
insert into student (name) values ('Addison');
insert into student (name) values ('Fiachra');
insert into student (name) values ('Natasha');
insert into student (name) values ('Ryden');



insert into course (title) values ('si106');
insert into course (title) values ('si110');
insert into course (title) values ('si206');



insert into roster (student_id, course_id, role) values (1, 1, 1);
insert into roster (student_id, course_id, role) values (2, 1, 0);
insert into roster (student_id, course_id, role) values (3, 1, 0);
insert into roster (student_id, course_id, role) values (4, 1, 0);
insert into roster (student_id, course_id, role) values (5, 1, 0);

insert into roster (student_id, course_id, role) values (6, 2, 1);
insert into roster (student_id, course_id, role) values (7, 2, 0);
insert into roster (student_id, course_id, role) values (8, 2, 0);
insert into roster (student_id, course_id, role) values (9, 2, 0);
insert into roster (student_id, course_id, role) values (10, 2, 0);

insert into roster (student_id, course_id, role) values (11, 3, 1);
insert into roster (student_id, course_id, role) values (12, 3, 0);
insert into roster (student_id, course_id, role) values (13, 3, 0);
insert into roster (student_id, course_id, role) values (14, 3, 0);
insert into roster (student_id, course_id, role) values (15, 3, 0);

SELECT student.name, course.title, roster.role
    FROM student
    JOIN roster ON student.id = roster.student_id
    JOIN course ON roster.course_id = course.id
    ORDER BY course.title, roster.role DESC, student.name;
