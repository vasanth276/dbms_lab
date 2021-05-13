create database bank;
use bank;

create table branch (
	branch_name varchar(25),
    branch_city varchar(15),
    assets int,
    primary key (branch_name)
);

create table bank_account (
	accno int,
    branch_name varchar(25), 
    balance int,
    primary key (accno),
    foreign key (branch_name) references branch(branch_name)
);

create table bank_customer (
	customer_name varchar(10),
    customer_street varchar(25),
    customer_city varchar(15),
    primary key (customer_name)
);

create table depositer (
	customer_name varchar(10),
	accno int,
    primary key(customer_name, accno),
    foreign key (customer_name) references bank_customer(customer_name),
    foreign key (accno) references bank_account(accno)
);

create table loan (
	loan_number int,
    branch_name varchar(25),
    amount int,
    primary key (loan_number),
    foreign key (branch_name) references branch(branch_name)
);

insert into branch values('SBI_Chamrajpet', 'Bangalore', 50000);
insert into branch values('SBI_ResidencyRoad', 'Bangalore', 10000);
insert into branch values('SBI_ShivajiRoad', 'Bombay', 20000);
insert into branch values('SBI_ParliamentRoad', 'Delhi', 10000);
insert into branch values('SBI_Jantarmantar', 'Delhi', 20000);
commit;

insert into bank_account values(1, 'SBI_Chamrajpet', 2000);
insert into bank_account values(2, 'SBI_ResidencyRoad', 5000);
insert into bank_account values(3, 'SBI_ShivajiRoad', 6000);
insert into bank_account values(4, 'SBI_ParliamentRoad', 9000);
insert into bank_account values(5, 'SBI_Jantarmantar', 8000);
insert into bank_account values(6, 'SBI_ShivajiRoad', 4000);
insert into bank_account values(8, 'SBI_ResidencyRoad', 4000);
insert into bank_account values(9, 'SBI_ParliamentRoad', 3000);
insert into bank_account values(10, 'SBI_ResidencyRoad', 5000);
insert into bank_account values(11, 'SBI_Jantarmantar', 2000);
commit;

insert into bank_customer values ('Avinash', 'Bull_Temple_Road', 'Bangalore');
insert into bank_customer values ('Dinesh', 'Bannergatta_Road', 'Bangalore');
insert into bank_customer values ('Mohan', 'National_College_Road', 'Bangalore');
insert into bank_customer values ('Nikhil', 'Akbar_Road', 'Delhi');
insert into bank_customer values ('Ravi', 'Prithviraj_Road', 'Delhi');
commit;

insert into depositer values('Avinash', 1);
insert into depositer values('Dinesh', 2);
insert into depositer values('Nikhil', 4);
insert into depositer values('Ravi', 5);
insert into depositer values('Avinash', 8);
insert into depositer values('Nikhil', 9);
insert into depositer values('Dinesh', 10);
insert into depositer values('Nikhil', 11);
commit;

insert into loan values(1, 'SBI_Chamrajpet', 1000);
insert into loan values(2, 'SBI_ResidencyRoad', 2000);
insert into loan values(3, 'SBI_ShivajiRoad', 3000);
insert into loan values(4, 'SBI_ParliamentRoad', 4000);
insert into loan values(5, 'SBI_Jantarmantar', 5000);
commit;


select * from branch;
select * from bank_account;
select * from bank_customer;
select * from depositer;
select * from loan;

-- Query 3
select distinct c.customer_name from bank_customer c,bank_account b where exists(select d.customer_name,count(d.customer_name) from depositer d,bank_account ba where ba.accno = d.accno and 
c.customer_name = d.customer_name and ba.branch_name = 'SBI_ResidencyRoad' group by d.customer_name having count(d.customer_name)>=2);

-- Query 4
select d.customer_name from depositer d,branch b,bank_account a 
where b.branch_name=a.branch_name
AND a.accno=d.accno
and branch_city='Delhi'
group by d.customer_name 
 HAVING COUNT(distinct b.branch_name)=(
                SELECT COUNT(branch_name)
                FROM branch
                WHERE branch_city='Delhi');
                
-- Query 5
delete from bank_account where branch_name in (select branch_name from branch where branch_city = 'Bombay');
select * from bank_account;