create database insurance;
use insurance;

create table person( 
	driver_id varchar(10),
    name varchar(20),
	address varchar(30),
	primary key(driver_id)
);

desc person;

create table car(
	reg_num varchar(10),
	model varchar(10),
	year int,
	primary key(reg_num)
);

desc car;

create table accident(
	report_num int,
	accident_date date,
	location varchar(20),
	primary key(report_num)
);

create table owns(
	driver_id varchar(10),
	reg_num varchar(10),
	primary key(driver_id,reg_num),
	foreign key(driver_id) references person(driver_id),
	foreign key(reg_num) references car(reg_num)
);

desc owns;

create table participated(
	driver_id varchar(10),
	reg_num varchar(10),
	report_num int,
	damage_amount int,
	primary key(driver_id,reg_num,report_num),
	foreign key(driver_id) references person(driver_id),
	foreign key(reg_num) references car(reg_num),
	foreign key(report_num) references accident(report_num)
);

desc participated;

insert into person values('A01','Richard',' Srinivas Nagar');
insert into person values('A02','Pradeep','Rajajinagar');
insert into person values('A03','Smith','Ashoknagar');
insert into person values('A04','Venu','N.R.Colony');
insert into person values('A05','John','Hanumanth Nagar');

commit;

select * from person;

insert into car values('KA031181','Lancer',1957);
insert into car values('KA041702','Audi',2005);
insert into car values('KA043408','Honda',2008);
insert into car values('KA052250','Indica',1990);
insert into car values('KA095477','Toyota',1998);

commit;

select * from car;


insert into accident values(11,'2001-01-03','Mysore Road');
insert into accident values(12,'2021-01-03','Southend Circle');
insert into accident values(13,'2020-03-03',' Bulltemple Road');
insert into accident values(14,' 2017-02-08',' Mysore Road');
insert into accident values(15,'2004-03-05','Kanakpura Road');
commit;

select * from accident;

insert into owns values ('A01','KA052250');  
insert into owns values ('A02','KA043408');
insert into owns values ('A03','KA031181');
insert into owns values ('A04','KA095477');
insert into owns values ('A05','KA041702');
commit;

select * from owns;

insert into participated values ('A01','KA052250',11, 25000);
insert into participated values ('A02','KA043408',12, 50000);
insert into participated values ('A03','KA031181',13, 25000);
insert into participated values ('A04','KA095477',14, 3000);
insert into participated values ('A05','KA041702',15, 5000);
commit;

select * from participated;

update participated 
set damage_amount = 2500
where reg_num='KA031111';

select * from participated;

insert into accident values(101,'2020-12-01','Xavier Road');
insert into participated values('A01','KA031111',101, 1001);
commit;
select * from accident;
select * from participated;

insert into car values('KA01010', 'Accord', 2002);
insert into owns values('A02', 'KA01010');
insert into accident values(200, '2008-12-01', 'Pinto Road');
insert into participated values('A02', 'KA01010', 200, 500);
commit;

select * from car;
select * from owns;
select * from accident;
select * from participated;

select count(*) from accident where year(accident_date)=2008;
select count(*) from participated where reg_num in ( select reg_num from car where model="Accord");