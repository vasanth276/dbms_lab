create database supplierdb;
use supplierdb;

create table suppliers(
	sid int,
    sname varchar(20),
	city varchar(15),
    primary key (sid)
);
desc suppliers;
create table parts (
	pid int,
    pname varchar(15),
    color varchar(10),
    primary key (pid)
);
desc parts;
create table catalog(
	sid int,
	pid int,
    cost int,
    primary key(pid, sid),
    foreign key (pid) references parts(pid),
    foreign key (sid) references suppliers(sid)
);
desc catalog;
insert into suppliers values (10001, 'Acme Widget', 'Bangalore');
insert into suppliers values (10002, 'Johns', 'Kolkata');
insert into suppliers values (10003, 'Vimal', 'Mumbai');
insert into suppliers values (10004, 'Reliance', 'Delhi');

insert into parts value(20001, 'Book', 'Red');
insert into parts value(20002, 'Pen', 'Red');
insert into parts value(20003, 'Pencil', 'Green');
insert into parts value(20004, 'Mobile', 'Green');
insert into parts value(20005, 'Charger', 'Black');

insert into catalog values(10001,20001,10);
insert into catalog values(10001,20002,10);
insert into catalog values(10001,20003,30);
insert into catalog values(10001,20004,10);
insert into catalog values(10001,20005,10);

insert into catalog values(10002,20001,10);
insert into catalog values(10002,20002,20);
insert into catalog values(10003,20003,30);
insert into catalog values(10004,20003,40);
commit;


select * from parts;
select * from suppliers;
select * from catalog;

-- Query 1
select distinct p.pname from parts p, catalog c where p.pid = c.pid;

-- Query 2

select distinct sname from suppliers where 
sid = 
(select sid from catalog group by sid having 
count(pid) = (select count(distinct pid) from parts));

-- Query 3

select distinct s.sname from suppliers s, parts p, catalog c where s.sid = c.sid and p.pid = c.pid and 
exists ((select sid from catalog group by sid having 
p.pid = c.pid and p.color='Red'));

-- Query 4

select p.pname from catalog c, suppliers s , parts p where c.pid in(
select pid from catalog group by pid having count(sid) = 1)
 and c.sid = s.sid and s.sname = 'Acme Widget'
 and p.pid = c.pid;
 
 -- Query 5
select c.sid from catalog c where c.cost > (
select avg(cost) from catalog where pid = c.pid and pid in
(select pid from catalog) group by pid);

-- Query 6
select s.sname, p.pname from parts p, suppliers s where exists(
select c.sid, c.pid from catalog c where s.sid = c.sid and p.pid = c.pid and c.cost = (
select max(cost) from catalog where pid = c.pid and pid in
(select pid from catalog) group by pid));


 
