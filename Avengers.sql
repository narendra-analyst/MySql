show databases;
create database employees_details;
create table employees (s_no int, name varchar(20), superpower varchar(20));
use employee_details;
show tables;
insert into employees values(1,"Tony Stark","Iron Man"),(2,"Bruce Banner","Hulk"),
(3,"Steve Rogers","Captain America"),(4,"Natasha","Black Widow");
select * from employees;

insert into employees values(5,"Loki","God of Evil");
DELETE FROM employees
WHERE s_no = 5;
truncate table employees; 
drop table employees;