show databases;
create database subquery;
use subquery;

#What is a Subquery?
#A subquery is a query inside another query
#Inner query → gives result
#Outer query → uses that result

#Simple Example
#Find customers who placed orders
SELECT name
FROM Customers
WHERE customer_id IN (
    SELECT customer_id
    FROM Orders
);

#How it works
#Inner query runs first:
#SELECT customer_id FROM Orders;
#Output: 1, 2, 3, 4, 5

#Outer query becomes:
SELECT name
FROM Customers
WHERE customer_id IN (1,2,3,4,5);
#Result
#All customers who have orders

#Types of Subqueries:-
#1.Types of Subqueries - Returns only one value
SELECT name
FROM Customers
WHERE customer_id = (
    SELECT customer_id
    FROM Orders
    ORDER BY order_id DESC
    LIMIT 1
);

#2.Multiple Value Subquery - Returns multiple values
SELECT name
FROM Customers
WHERE customer_id IN (
    SELECT customer_id
    FROM Orders
);

#3.Correlated Subquery - Inner query depends on outer query
#Example - Find customers who have more than 1 order
SELECT name
FROM Customers c
WHERE (
    SELECT COUNT(*)
    FROM Orders o
    WHERE o.customer_id = c.customer_id
) > 1;

#Task:-
create table Employees (emp_id int primary key,emp_name varchar(50),dept_id int,salary int);
insert into Employees values
(1, 'Harry Potter',10,80000),
(2, 'Hermione Granger',10,70000),
(3, 'Ron Weasley',10,65000),
(4, 'Albus Dumbledore',1,500000),
(5, 'Lord Voldemort',20,200000);
insert into Emplooyes values (6, 'Draco Mallfoy',null,60000);

create table Departments (dept_id int,dept_name varchar(20),location varchar(20));
insert into Departments values
(10, 'GD', 'Scottish Highlands'),
(1, 'HM', 'Scottish Highlands'),
(20, 'MA', 'Dufftown');

select * from Employees;
select * from Departments;

#1.Write a query to find employees whose salary is greater than the average salary of all employees using a single-row subquery in where.
select emp_name, salary
from Employees
where salary > (select avg(salary) from Employees);

#2.Write a query to display employee names who work in departments located in Scottish Highlands using IN with a subquery in where.
select emp_name
from Employees
where dept_id in (
  select dept_id from Departments where location = 'Chennai'
);

#3.Write a query to find employees whose salary is greater than ANY salary of employees in department 10 using ANY operator.
select emp_name, salary
from Employees
where salary > any (
  select salary from Employees where dept_id = 10
);

#4.Write a query to find employees whose salary is greater than ALL salaries of employees in department 20 using ALL operator.
select emp_name, salary
from Employees
where salary > all (
  select salary from Employees where dept_id = 20
);

#5.Write a query to display employees who are not assigned to any department using NOT IN with a subquery.
select emp_name
from Employees
where dept_id not in (select dept_id from Departments);

#6.Write a query to display each employee name along with the overall average salary using a subquery in SELECT.
select emp_name,
       salary,
       (select avg(salary) from Employees) as avg_salary
from Employees;

#7.Write a query to display each employee name along with the maximum salary in the company using a scalar subquery in SELECT.
select emp_name,
       salary,
       (select max(salary) from Employees) as max_salary
from Employees;

#8.Write a query to find employees who earn the highest salary in each department using a correlated subquery in WHERE.
select emp_name, dept_id, salary
from Employees e
where salary = (
  select max(salary)
  from Employees
  where dept_id = e.dept_id
);

#9.Write a query to display departments and their average salaries using a subquery in FROM.
select d.dept_name, avg_sal
from (
  select dept_id, avg(salary) as avg_sal
  from Employees
  group by dept_id
) e
join Departments d
on e.dept_id = d.dept_id;

#10.Write a query to find employees whose salary is equal to the minimum salary in the company using a single-row subquery.
select emp_name, salary
from Employees
where salary = (select min(salary) from Employees);

#11.Write a query to find employees whose department ID matches any department that has more than 3 employees using ANY.
select emp_name
from Employees
where dept_id = any (
  select dept_id
  from Employees
  group by dept_id
  having count(*) > 3
);

#12.Write a query to display employee names who work in the same department as 'Harry Potter' using a subquery in WHERE.
select emp_name
from Employees
where dept_id = (
  select dept_id from Employees where emp_name = 'Harry Potter'
);



