create database student_enroll;
use student_enroll;

create table student(
regno varchar(15),
name varchar(20),
major varchar(20),
bdate date,
primary key(regno));
desc student;

create table course(
courseno int,
cname varchar(20),
dept varchar(20),
primary key(courseno));
desc course;

create table enroll(
regno varchar(15),
courseno int,
sem int,
marks int,
primary key(regno,courseno),
foreign key(regno) references student(regno),
foreign key(courseno) references course(courseno));
desc enroll;
create table textbook(
book_isbn int,
book_title varchar(20),
publisher varchar(20),
author varchar(20),
primary key(book_isbn));
desc textbook;

create table book_adoption(
courseno int,
sem int,
book_isbn int,
primary key(courseno,book_isbn),
foreign key(courseno) references course(courseno),
foreign key(book_isbn) references textbook(book_isbn));
desc book_adoption;

insert into student values('1BM11CS001','A','Sr','19931230');
insert into student values('1BM11CS002','B','Sr','19930924');
insert into student values('1BM11CS003','C','Sr','19931127');
insert into student values('1BM11CS004','D','Sr','19930413');
insert into student values('1BM11CS005','E','Jr','19940824');
commit;
select * from student;

insert into course values(111,'OS','CSE');
insert into course values(112,'EC','ECE');
insert into course values(113,'SS','ISE');
insert into course values(114,'DBMS','CSE');
insert into course values(115,'SIGNALS','ECE');
commit;
select * from course;

insert into textbook values(10,'DATABASE SYSTEMS','PEARSON','SCHIELD');
insert into textbook values(900,'OPERATING SYSTEMS','PEARSON','LELAND');
insert into textbook values(901,'CIRCUITS','HALL INDIA','BOB');
insert into textbook values(902,'SYSTEM SOFTWARE','PETERSON','JACOB');
insert into textbook values(903,'SCHEDULING','PEARSON','PATIL');
insert into textbook values(904,'DATABASE SYSTEMS','PEARSON','JACOB');
insert into textbook values(905,'DATABASE MANAGER','PEARSON','BOB');
insert into textbook values(906,'SIGNALS','HALL INDIA','SUMIT');
commit;
select * from textbook;

insert into enroll values('1BM11CS001',115,3,100);
insert into enroll values('1BM11CS002',114,5,100);
insert into enroll values('1BM11CS003',113,5,100);
insert into enroll values('1BM11CS004',111,5,100);
insert into enroll values('1BM11CS005',112,3,100);
commit;
select * from enroll;

insert into book_adoption values(111,5,900);
insert into book_adoption values(111,5,903);
insert into book_adoption values(111,5,904);
insert into book_adoption values(112,3,901);
insert into book_adoption values(113,3,10);
insert into book_adoption values(114,5,905);
insert into book_adoption values(113,5,902);
insert into book_adoption values(115,3,906);
commit;
select * from book_adoption;
#Query1
insert into textbook values(908,'UNIX CONCEPTS','TATA MCGRAW HILL','SUMITABHA DAS');
insert into book_adoption values(113,4,908);
select * from textbook;
select * from book_adoption;

#Query2
select c.courseno,t.book_isbn,t.book_title
from course c,book_adoption ba,textbook t
where c.courseno=ba.courseno
and ba.book_isbn=t.book_isbn
and c.dept='CSE'
and 2<(select COUNT(book_isbn)
from book_adoption b
where c.courseno=b.courseno)
order by t.book_title;

#Query3
select distinct c.dept
from course c
where c.dept in(select c.dept
     from course c,book_adoption b,textbook t
     where c.courseno=b.courseno
     and t.book_isbn=b.book_isbn
     and t.publisher='PEARSON')
     and c.dept not in(select c.dept
     from course c,book_adoption b,textbook t
     where c.courseno=b.courseno
     and t.book_isbn=b.book_isbn
     and t.publisher != 'PEARSON');