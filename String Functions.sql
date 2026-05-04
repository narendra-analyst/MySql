show databases;
create database sqlfunctions;
use sqlfunctions;

#What is sql function?
#SQL funtions are built-in tools in SQL that helps you perform operations on data.

#What is String?
#String functions are used to work with text (characters) in a database.
#eg: name = 'narendra' , city =  'pondy'

#String Functions:
select upper ('narendra');
#converts upper text to capital letters

select lower ('NARENDRA');
#converts text to small letters

select length ('narendra');
#counts the number of characters

select concat ('narendra','','analyst');
#join two or more strings - eg: frist name and last name in one column

select substr('narendra', 1, 4);
#extracts the part of the string, like where to start and where to end

select substring_index('watermelon,orange,mango', ',' ,1);
#“SUBSTRING_INDEX() is used to split a string and return a part of it based on a specified symbol

select trim(' hello ');
#removes the extra spaces

select replace ('hello world', 'world', 'sql');
#replace text with another text

select instr('narendra','a');
#find the position of the character

#Where we use string functions?
#In real-time data analyst work cleaning messy data, formatting names, searching text, combining columns(first_name and last_name).

# Date time function():
# 		SQL provides many built-in date and time functions to handle 
# dates, times and timestamps. These functions vary slightly 
# depending on the database.

# current date and time:
select now(); - #show both current date and time
select current_timestamp();
select sysdate();
select current_date();
select current_time();

# date arithmetic:
select adddate(curdate(),10);
select subdate(curdate(), interval 20 day);

# difference b/w dates;
select datediff('2024-03-23','2024-03-19');

# Formatting dates & time:
select date_format(curdate(), '%d-%m-%y');
select time_format(curtime(), '%h:%i:%s %p');

# Extract parts of date:
select month('2026-04-01');
select day('2026-04-01');

select dayname('2026-04-27'+ interval 10 day);
select CAST('2026-03-21' AS DATE);

#select substr(first_name,1,3) from employees;
#select concat(first_name,' ', last_name) as full_name from employees;
#select dayname('2026-04-12'+ interval 10 day);

#
select abs(-100);

select ceil(10.1);
select floor(10.9);
select round(10.1);
select mod(10,2);
select sqrt(16);
select pow(10,2);

select * from employees;

select rand() from employees;

select * from employees
where first_name regexp '^a';

select * from employees
where first_name regexp 'i$';

select * from employees
where first_name regexp '[^rav]';

select coalesce(commission, 0) from employees;

#Task:
create table data_practice (
    id int primary key,
    name varchar(50),
    email varchar(100),
    order_date DATE,
    start_date DATE,
    end_date DATE,
    salary decimal(10,3)
);
insert into data_practice values
(1, ' John ', 'john@gmail.com', '2026-04-20', '2026-04-01', '2026-04-10', 25000.567),
(2, 'Alice', 'alice@yahoo.com', '2026-04-22', '2026-04-05', '2026-04-20', 32000.456),
(3, 'Bob', 'bob@gmail.com', '2026-04-25', '2026-04-10', '2026-04-25', 45000.789),
(4, 'Charlie', 'charlie@gmail.com', '2026-04-27', '2026-04-12', '2026-04-28', 28000.123),
(5, 'David', 'david@hotmail.com', '2026-05-01', '2026-04-15', '2026-04-30', 39000.999);

select * from data_practice;

#STRING FUNCTIONS:-
#1.Convert names to uppercase
select upper(name) as upper_name from data_practice;

#2.Convert names to lowercase
select lower(name) as lower_name from data_practice;

#3.Get first 3 letters of name
select substr(name , 1,3) from data_practice;

#4.Find length of each name
select name, length(name) from data_practice;

#5.Remove spaces from both sides
select trim(name) as cleaned_name from data_practice;

#6.Replace word in string (gmail → yahoo)
select replace(email, 'gmail.com' , 'yahoo.com') as updated_email from data_practice;

#7.Extract domain from email
select substring_index(email, '@', -1) as domain from data_practice;

#8.Extract username from email
select substring_index(email, '@', 1) as username from data_practice;

#DATE FUNCTIONS:-
#9.Show current date
select current_date();

#10.Show current date and time
select now();

#11.Extract year from date
select year (order_date) as year from data_practice;

#12.Extract month from date
select month (order_date) as month from data_practice;
select (order_date) as year from data_practice;

#12.Extract month from date
select (order_date) as month from data_practice;

#13.Extract day name
select dayname('2026-04-27') as day_name;

#14.Add 7 days to date
select date_add(order_date, interval 7 day) as new_date from data_practice; 

#15.Find difference between two dates
select datediff(end_date, start_date) as date_difference from data_practice;

#NUMERIC FUNCTIONS:-
#16.Round salary (nearest integer)
select round(salary) as round_salary from data_practice;

#17.Round salary to 2 decimal places
select round(salary,2) as rounded_salary from data_practice;

#18.Generate random number (0 to 1)
select rand();

#AGGREGATE FUNCTIONS:-
#19.Find highest and lowest salary
select max(salary) as high_salary, min(salary) as low_salary from data_practice;