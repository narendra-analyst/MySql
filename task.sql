
show databases;
create database Employees_detail;
use Employees_details;
#1.Create a table named Employees with columns:emp_id (INT, PRIMARY KEY), name (VARCHAR), department (VARCHAR), salary (INT), joining_date (DATE).
create table Employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(100),
    department VARCHAR(100),
    salary INT,
    joining_date DATE
);

#2.Insert at least 5 records into Employees with different departments and salaries.
insert into Employees (emp_id, name, department, salary, joining_date) VALUES
(1, 'Arun', 'HR', 30000, '2023-01-15'),
(2, 'Priya', 'IT', 45000, '2022-11-20'),
(3, 'Rahul', 'Finance', 40000, '2023-03-10'),
(4, 'Sneha', 'Marketing', 35000, '2022-12-05'),
(5, 'Vikram', 'IT', 50000, '2023-02-18');
select * from Employees;

#3.Create a table Departments with columns:dept_id (INT), dept_name (VARCHAR), location (VARCHAR), and insert sample data.
create table Departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(100),
    location VARCHAR(100)
);
INSERT INTO Departments (dept_id, dept_name, location) VALUES
(1, 'HR', 'Chennai'),
(2, 'IT', 'Bangalore'),
(3, 'Finance', 'Mumbai'),
(4, 'Marketing', 'Delhi'),
(5, 'Sales', 'Hyderabad');
select * from Departments;

#4.Write a query to select DISTINCT department names from Employees.
select distinct department
FROM Employees;

update Employees
set salary = "60000"
where emp_id = 5;

#5.Retrieve employees whose salary is greater than 50000 AND department is 'IT'.
SELECT * FROM Employees
WHERE salary > 50000 AND department = 'IT';

#6.Find employees whose name starts with 'A'
select * from Employees
where name like 'A%';
#% - many, _ one

#7.Get employees who are NOT in 'HR' department.
select * from Employees
where department != 'HR';

#8.Retrieve employees who belong to 'IT' OR 'Finance'.
select * from Employees
where department in ('IT', 'Finance');

#9.Display all employees ordered by salary in descending order.
select * from Employees
order by salary desc;

#10.Fetch top 3 highest paid employees.
select * from Employees
order by salary desc
limit 3;

#11.Skip first 2 records and fetch next 3 employees.
select * from Employees
order by salary
limit 3 offset 2;

#12.Update salary by 10% for employees in 'IT' department.
update Employees
set salary = salary * 1.10
where department = 'IT';

#13.Delete employees whose salary is less than 30000.
delete from Employees
where salary > 30000;

#14.Alter Employees table to add a new column email (VARCHAR).
alter table Employees
add column email varchar(30);

#15.Create a temporary table Temp_HighSalaryEmployees containing employees with salary > 40000.
create temporary table HighSalaryEmployees as
select * from Employees
where salary > 40000;

#16.Using CTAS (CREATE TABLE AS SELECT), create a new table HighEarners from Employees where salary > 45000.
create table HighEarners as
select * from Employees
where salary > 45000;

#17.Write a CTE(common table expression) to find employees earning above average salary.
with HighSalaryEmployees as
(select * from Employees
where salary > 35000)
select * from HighSalaryEmployees

#18.Retrieve employees where department is 'IT' AND salary > 40000 OR name LIKE '%n'.
select * from Employees
where (department = 'IT' AND salary > 4000) or name like '%m';

#19.Combine WHERE, AND, OR, NOT, LIKE to find employees not in 'HR',name contains 'a',salary between 30000 and 80000,order result by salary ascending with LIMIT 3 OFFSET 1.
select * from Employees
where department not in ('HR') AND name like '%a' AND salary between 30000 AND 80000
order by salary ASC
limit 3 offset 1;
