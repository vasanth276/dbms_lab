create database supplier;

use supplier;
create table SUPPLIERS(sid integer,sname varchar(20),address varchar(40),primary key(sid));
INSERT INTO `supplier`.`suppliers` (`sid`, `sname`, `address`) VALUES ('10001', 'Acme Widget', 'Bangalore');
INSERT INTO `supplier`.`suppliers` (`sid`, `sname`, `address`) VALUES ('10002', 'Johns', 'Kolkata');
INSERT INTO `supplier`.`suppliers` (`sid`, `sname`, `address`) VALUES ('10003', 'Vimal', 'Mumbai');
INSERT INTO `supplier`.`suppliers` (`sid`, `sname`, `address`) VALUES ('10004', 'Reliance', 'Delhi');

commit;
select* from SUPPLIERS;

create table PARTS(pid integer,pname varchar(20),color varchar(30),primary key(pid));
INSERT INTO `supplier`.`parts` (`pid`, `pname`, `color`) VALUES ('20001', 'Book', 'Red');
INSERT INTO `supplier`.`parts` (`pid`, `pname`, `color`) VALUES ('20002', 'Pen', 'Red');
INSERT INTO `supplier`.`parts` (`pid`, `pname`, `color`) VALUES ('20003', 'Pencil', 'Green');
INSERT INTO `supplier`.`parts` (`pid`, `pname`, `color`) VALUES ('20004', 'Mobile', 'Green');
INSERT INTO `supplier`.`parts` (`pid`, `pname`, `color`) VALUES ('20005', 'Charger', 'Black');
commit;
select* from PART;

create table CATALOG(sid integer,pid integer,foreign key(sid)  references SUPPLIERS(sid),foreign key(pid) references PARTS(pid),
 cost integer,primary key(sid,pid));
INSERT INTO `supplier`.`catalog` (`sid`, `pid`, `cost`) VALUES ('10001', '20001', '10');
INSERT INTO `supplier`.`catalog` (`sid`, `pid`, `cost`) VALUES ('10001', '20002', '10');
INSERT INTO `supplier`.`catalog` (`sid`, `pid`, `cost`) VALUES ('10001', '20003', '30');
INSERT INTO `supplier`.`catalog` (`sid`, `pid`, `cost`) VALUES ('10001', '20004', '10');
INSERT INTO `supplier`.`catalog` (`sid`, `pid`, `cost`) VALUES ('10001', '20005', '10');
INSERT INTO `supplier`.`catalog` (`sid`, `pid`, `cost`) VALUES ('10002', '20001', '10');
INSERT INTO `supplier`.`catalog` (`sid`, `pid`, `cost`) VALUES ('10002', '20002', '20');
INSERT INTO `supplier`.`catalog` (`sid`, `pid`, `cost`) VALUES ('10003', '20003', '30');
INSERT INTO `supplier`.`catalog` (`sid`, `pid`, `cost`) VALUES ('10004', '20003', '40');

commit;
select* from CATALOG;


-- Query 1
SELECT DISTINCT P.pname
FROM Parts P, Catalog C
WHERE P.pid = C.pid;


-- Query 5
SELECT DISTINCT C.sid FROM Catalog C
WHERE C.cost > ( SELECT AVG (C1.cost)
FROM Catalog C1
WHERE C1.pid = C.pid );


-- Query 6
SELECT P.pid, S.sname
FROM Parts P, Suppliers S, Catalog C
WHERE C.pid = P.pid
AND C.sid = S.sid
AND C.cost = (SELECT MAX(C1.cost)
FROM Catalog C1
WHERE C1.pid = P.pid);


