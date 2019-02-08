create table ers.roles(
	role_name VARCHAR(20) primary key
);
create table ers.users (
	id serial primary key,
	first_name VARCHAR(20) not null,
	last_name VARCHAR(40) not null,
	email VARCHAR(40) not null unique,
	password varchar(20) not null
);
create table ers.user_roles(
	user_id int4 not null references ers.users(id),
	role_name varchar(20) not null references ers.roles(role_name),
	primary key(user_id, role_name)
);
create table if not exists ers.ers_reimbursement (
	remimb_id serial primary key,
	reimb_amount decimal,
	reimb_submitted date,
	reimb_resolved date,
	reimb_description varchar(300),
	reimb_author_id integer references ers.users(id),
	reimb_resolver_id integer references ers.users(id),
	reimb_status_id integer references ers_reimbursement_status(reimb_status_id),
	reimb_type_id integer references ers_reimbursement_type(reimb_type_id)
);
create table if not exists ers.ers_reimbursement_status (
	reimb_status_id serial primary key,
	reimb_status varchar(10)
);
create table if not exists ers.ers_reimbursement_type (
	reimb_type_id serial primary key,
	reimb_type varchar (10)
);


insert into ers.roles (role_name) values ('Manager'), ('Employee');
insert into ers.users(first_name, last_name, email, password) values ('Adam', 'Gray', 'adamgray13@gmail.com', 'password');
insert into ers.users(first_name, last_name, email, password) values ('Eric', 'Webb', 'EricWebb@gmail.com', 'password');
insert into ers.user_roles(user_id, role_name) values (1, 'Manager');
insert into ers.user_roles(user_id, role_name) values (2, 'Employee');

insert into ers.ers_reimbursement_status(reimb_status) values('open');
insert into ers.ers_reimbursement_status(reimb_status) values('approved');
insert into ers.ers_reimbursement_status(reimb_status) values('rejected');
insert into ers_reimbursement_status(reimb_status_id, reimb_status) values(1, 'open');
insert into ers_reimbursement_status(reimb_status_id, reimb_status) values(2, 'approved');
insert into ers_reimbursement_status(reimb_status_id, reimb_status) values(3, 'rejected');

insert into ers_reimbursement_type(reimb_type)values('Lodging');
insert into ers_reimbursement_type(reimb_type)values('Travel');
insert into ers_reimbursement_type(reimb_type)values('Food');
insert into ers_reimbursement_type(reimb_type)values('Other');
insert into ers.ers_reimbursement_type(reimb_type_id, reimb_type) values (1, 'Lodging');
insert into ers.ers_reimbursement_type(reimb_type_id, reimb_type) values (2, 'Travel');
insert into ers.ers_reimbursement_type(reimb_type_id, reimb_type) values (3, 'Food');
insert into ers.ers_reimbursement_type(reimb_type_id, reimb_type) values (4, 'Other');

select ers.ers_reimbursement.remimb_id, ers.ers_reimbursement.reimb_amount, ers.ers_reimbursement.reimb_submitted, ers.ers_reimbursement.reimb_resolved, ers.ers_reimbursement.reimb_description, ers.ers_reimbursement_type.reimb_type, ers.ers_reimbursement_status.reimb_status 
from ers.ers_reimbursement
join ers.ers_reimbursement_status
on ers.ers_reimbursement_status.reimb_status_id = ers.ers_reimbursement.reimb_status_id
join ers.ers_reimbursement_type
on ers.ers_reimbursement_type.reimb_type_id = ers.ers_reimbursement.reimb_type_id
group by ers.ers_reimbursement.remimb_id, ers.ers_reimbursement_type.reimb_type, ers.ers_reimbursement_status.reimb_status;

select *
from ers.ers_reimbursement
join ers_reimbursement_type on ers_reimbursement.reimb_type_id = ers_reimbursement_type.reimb_type_id
join ers_reimbursement_status on ers.ers_reimbursement.reimb_status_id = ers_reimbursement_status.reimb_status_id
join ers.users on ers_reimbursement.reimb_author_id = ers.users.id
group by ers_reimbursement.remimb_id, ers_reimbursement_type.reimb_type_id, ers_reimbursement_status.reimb_status_id, users.id;

select id, first_name, last_name, email, password, role_name from ers.users
	join ers.user_roles
	on ers.users.id = user_roles.user_id
	group by ers.users.email, ers.users.id, ers.user_roles.user_id, ers.user_roles.role_name
	having email = 'adamgray13@gmail.com';

select id, first_name, last_name, email, password, role_name from ers.users
	join ers.user_roles
	on ers.users.id = user_roles.user_id
	group by ers.users.email, ers.users.id, ers.user_roles.user_id, ers.user_roles.role_name
	having email = 'EricWebb@gmail.com';

select * from ers.users;

select * from ers.ers_reimbursement_type;
select * from ers.ers_reimbursement_status;
select * from ers.ers_reimbursement;
select * from ers.roles;

select * from ers.user_roles;

drop table ers.roles;
drop table ers.users;
drop table ers.user_roles;
drop table ers_reimbursement;
drop table ers_reimbursement_status;
drop table ers_reimbursement_type;
truncate table ers.ers_reimbursement;

commit;