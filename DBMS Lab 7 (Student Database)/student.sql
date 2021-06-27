create database studentdb;
use studentdb;


create table student(
	snum int, 
    sname varchar(10), 
    major varchar(2), 
    lvl varchar(2), 
    age int,
    primary key(snum)
);
desc student;
create table class(
	cname varchar(8),
    meetsat time,
    room varchar(5),
    fid int,
    primary key (cname)
);
desc class;
create table enrolled(
	snum int,
    cname varchar(10),
    primary key (snum, cname),
    foreign key (snum) references student(snum),
    foreign key (cname) references class(cname)
);
desc enrolled;
create table faculty(
	fid int,
    fname varchar(10),
    deptid int,
    primary key (fid)
);
desc faculty;
insert into student values(1,'John', 'CS','Jr',19);
insert into student values(2,'Smith', 'CS','Jr',20);
insert into student values(3,'Jacob', 'CV','Sr',20);
insert into student values(4,'Tom', 'CS','Jr',20);
insert into student values(5,'Rahul', 'CS','Jr',20);
insert into student values(6,'Rita', 'CS','Sr',21);
insert into student values(7,'McGregor', 'CV','Sr',22);
insert into student values(8,'Smilga', 'CS','Jr',19);
insert into student values(9,'Price', 'CV','Sr',22);
commit;

insert into faculty values (11, 'Harish', 1000);
insert into faculty values (12, 'MV', 1000);
insert into faculty values (13, 'Mira', 1001);
insert into faculty values (14, 'Shiva', 1002);
insert into faculty values (15, 'Nupur', 1000);
commit;

insert into class values('Class1', '10:15:15' , 'R1', 14);
insert into class values('Class10', '10:15:16' , 'R128', 11);
insert into class values('Class11', '10:15:16' , 'R1', 11);
insert into class values('Class3', '10:15:16' , 'R3', 11);
insert into class values('Class13', '10:15:16' , 'R2', 11);
insert into class values('Class12', '10:15:16' , 'R4', 11);
insert into class values('Class2', '10:15:20' , 'R2', 12);
insert into class values('Class3', '10:15:45' , 'R3', 11);
insert into class values('Class4', '10:15:20' , 'R4', 12);
insert into class values('Class5', '20:15:20' , 'R3', 15);
insert into class values('Class6', '13:20:20' , 'R2', 12);
insert into class values('Class7', '10:10:10' , 'R3', 12);

commit;
select * from class;
insert into enrolled values(1, 'Class1');
insert into enrolled values(2, 'Class1');
insert into enrolled values(6, 'Class1');
insert into enrolled values(7, 'Class1');
insert into enrolled values(8, 'Class1');
insert into enrolled values(3, 'Class3');
insert into enrolled values(4, 'Class2');
insert into enrolled values(5, 'Class4');

commit;

select * from student;
select * from faculty;
select * from class;
select * from enrolled;

--  Query 1
select sname from student where lvl='Jr' and snum in 
	(select snum from enrolled where cname in 
	(select cname from class where fid in 
	(select fid from faculty where fname='Shiva')
));



-- Query 2
select cname from class where cname in(
select cname from class where room  = 'R128') or cname in
(select cname from enrolled group by cname having count(cname)>=5);

-- Query 3
select sname from student where snum in(
select snum from enrolled where cname in(
select cname from class where meetsat in (select meetsat from class group by meetsat having count(meetsat)>1)));
-- Query 4
SELECT f.fname,f.fid
			FROM faculty f
	     	WHERE f.fid in ( SELECT fid FROM class
			GROUP BY fid HAVING COUNT(*)=(SELECT COUNT(DISTINCT room) FROM class) );
-- Query 5
select distinct fid from class where cname in (select cname from enrolled group by cname having count(cname)<5) or cname not in (select distinct cname from enrolled);
-- Query 6

select sname from student where snum not in (select distinct snum from enrolled);

-- Query 7

SELECT S.age, S.lvl
FROM student S
GROUP BY S.age, S.lvl
HAVING S.lvl IN(SELECT S1.lvl
	FROM student S1
	WHERE S1.age=S.age
	GROUP BY S1.age, S1.lvl
	HAVING COUNT(*)  >= ALL (SELECT COUNT(*) 
		FROM student S2
		WHERE S1.age=S2.age
		GROUP BY S2.lvl, S2.age))
ORDER BY S.age;
