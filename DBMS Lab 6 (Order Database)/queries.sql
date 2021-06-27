create database orderdb;
use orderdb;

create table salesman (
	salesman_id int(4), 
	name varchar (20), 
	city varchar (20), 
	commission varchar (20), 
	primary key (salesman_id)
);
desc salesman;
create table customer1 (
	customer_id int(4), 
	cust_name varchar (20), 
	city varchar (20), 
	grade int (3), 
    salesman_id int(4), 
	primary key (customer_id), 
	foreign key (salesman_id) references salesman(salesman_id) on delete set null
);
desc customer1;
create table orders (
	ord_no int (5), 
	purchase_amt int (10), 
	ord_date date, 
    customer_id int(4), 
	salesman_id int(4), 
	primary key (ord_no), 
	foreign key (customer_id) references customer1 (customer_id) on delete cascade, 
	foreign key (salesman_id) references salesman (salesman_id) on delete cascade
);
desc orders;
insert into salesman values (1000, 'john','bangalore','25 %'); 
insert into salesman values (2000, 'ravi','bangalore','20 %'); 
insert into salesman values (3000, 'kumar','mysore','15 %'); 
insert into salesman values (4000, 'smith','delhi','30 %'); 
insert into salesman values (5000, 'harsha','hydrabad','15 %'); 
select * from salesman;
insert into customer1 values (10, 'preethi','bangalore', 100, 1000); 
insert into customer1 values (11,'vivek','mangalore', 300, 1000); 
insert into customer1 values (12, 'bhaskar','chennai', 400, 2000); 
insert into customer1 values (13, 'chethan','bangalore', 200, 2000); 
insert into customer1 values (14, 'mamatha','bangalore', 400, 3000); 
select * from customer1;
insert into orders values (50, 5000, '04-06-17', 10, 1000); 
insert into orders values (51, 450, '20-01-17', 10, 2000);
insert into orders values (52, 1000, '24-02-17', 13, 2000); 
insert into orders values (53, 3500, '13-04-17', 14, 3000); 
insert into orders values (54, 550, '09-03-17', 12, 2000);
select * from orders;

-- Query 1

select grade, count(distinct customer_id) 
from customer1 
group by grade 
having grade > (select avg(grade) 
from customer1 
where city='bangalore'
);

-- Query 2

select salesman_id, name 
from salesman a 
where 1 < (select count(*) 
from customer1 
where salesman_id=a.salesman_id
);

-- Query 3

select salesman.salesman_id, name, cust_name, commission 
from salesman, customer1 
where salesman.city = customer1.city 
union 
select salesman_id, name, 'no match', commission 
from salesman 
where not city = any 
(select city 
from customer1) 
order by 2 desc;

-- Query 4

create view highsalesman as 
select b.ord_date, a.salesman_id, a.name 
from salesman a, orders b
where a.salesman_id = b.salesman_id 
and b.purchase_amt=(select max(purchase_amt) 
from orders c 
where c.ord_date = b.ord_date
);
select * from highsalesman;

-- Query 5

delete from salesman 
where salesman_id=1000;

select * from salesman;
select * from orders;