create database bookdb;
use bookdb;

create table publisher (
	name varchar (20) primary key, 
	phone integer, 
	address varchar (20)
); 
desc publisher;

create table book (
	book_id integer primary key, 
	title varchar (20), 
	pub_year varchar (20), 
	publisher_name varchar (20),
	foreign key (publisher_name) references publisher (name) on delete cascade
);
desc book;

create table book_authors (
	author_name varchar (20), 
	book_id integer,
	foreign key (book_id) references book (book_id) on delete cascade, 
	primary key (book_id, author_name)
); 
desc book_authors;

create table library_branch (
	branch_id integer primary key, 
	branch_name varchar (50), 
	address varchar (50)
); 
desc library_branch;

create table book_copies (
	no_of_copies integer, 
	book_id integer,
	branch_id integer,
	foreign key (book_id) references book (book_id) on delete cascade, 
	foreign key (branch_id) references library_branch (branch_id) on delete cascade, 
	primary key (book_id, branch_id)
); 
desc book_copies;

create table card (
	card_no integer primary key
); 
desc card;
create table book_lending (
	date_out date, 
	due_date date, 
    book_id integer,
	branch_id integer,
    card_no integer,
	foreign key (book_id) references book (book_id) on delete cascade, 
	foreign key (branch_id) references library_branch (branch_id) on delete cascade, 
	foreign key (card_no) references card (card_no) on delete cascade, 
	primary key (book_id, branch_id, card_no)
);
desc book_lending;

insert into publisher values ('mcgraw-hill', 99890, 'bangalore'); 
insert into publisher values ('pearson', 98890, 'newdelhi'); 
insert into publisher values ('random house', 74556, 'hydrabad'); 
insert into publisher values ('hachette livre', 897086, 'chenai'); 
insert into publisher values ('grupo planeta', 77561, 'bangalore'); 

select * from publisher;

insert into book values (1,'dbms','01-2017', 'mcgraw-hill'); 
insert into book values (2,'adbms','06-2016', 'mcgraw-hill'); 
insert into book values (3,'cn','09-2016', 'pearson'); 
insert into book values (4,'cg','09-2015', 'grupo planeta'); 
insert into book values (5,'os','05-2016', 'pearson'); 
select * from book;
insert into book_authors values ('navathe', 1); 
insert into book_authors values ('navathe', 2); 
insert into book_authors values ('tanenbaum', 3); 
insert into book_authors values ('edward angel', 4); 
insert into book_authors values ('galvin', 5); 
select * from book_authors;
insert into library_branch values (10,'rr nagar','bangalore'); 
insert into library_branch values (11,'rnsit','bangalore'); 
insert into library_branch values (12,'rajaji nagar', 'bangalore'); 
insert into library_branch values (13,'nitte','mangalore'); 
insert into library_branch values (14,'manipal','udupi'); 
select * from library_branch;
insert into book_copies values (10, 1, 10); 
insert into book_copies values (5, 1, 11); 
insert into book_copies values (2, 2, 12); 
insert into book_copies values (5, 2, 13); 
insert into book_copies values (7, 3, 14); 
insert into book_copies values (1, 5, 10); 
insert into book_copies values (3, 4, 11); 
select * from book_copies;
insert into card values (100);
insert into card values (101); 
insert into card values (102); 
insert into card values (103); 
insert into card values (104);
select * from card;

insert into book_lending values ('01-01-17','01-06-17', 1, 10, 101); 
insert into book_lending values ('11-01-17','11-03-17', 3, 14, 101); 
insert into book_lending values ('21-02-17','21-04-17', 2, 13, 101); 
insert into book_lending values ('15-03-17','15-07-17', 4, 11, 101); 
insert into book_lending values ('12-08-17','12-08-17', 1, 11, 104); 
select * from book_lending;

-- Query 1

select b.book_id, b.title, b.pub_year, b.publisher_name, bc.no_of_copies, ba.author_name, lb.branch_name from book b, book_authors ba, 
library_branch lb, book_copies bc where b.book_id = ba.book_id and b.book_id = bc.book_id and lb.branch_id = bc.branch_id;

-- Query 2

select card_no from book_lending where year(date_out) >17 and month(date_out)<7 group by card_no having count(card_no) >2 ;

-- Query 3

delete from book where book_id = 3;
select * from book;
select * from book_authors;
select * from book_copies;
select * from book_lending;

-- Query 4
select * from book order by substring(pub_year, 4, 4);
-- select b1.book_id, b1.title, b1.pub_year
-- from book b1
-- inner join book b2 on substring(b1.pub_year, 4, 4) = substring(b2.pub_year, 4, 4) and b1.book_id <> b2.book_id;

create view q4_view as select pub_year from book; 
select * from q4_view;

-- Query 5

create view q5_view as select b.book_id, b.title, bc.no_of_copies from book b,
book_copies bc where b.book_id = bc.book_id;
select * from q5_view;