show databases;
create database joins;
use joins;

#What is a JOIN?
#A JOIN is used to combine data from two or more tables based on a related column.
#Take data from multiple tables and show it together.

create table Customers (customer_id int primary key, name varchar(50));
insert into Customers values
(1, 'Harry Potter'),
(2, 'Hermione Granger'),
(3, 'Ron Weasley'),
(4, 'Allbus Dumbledore'),
(5, 'Lord Voldemort');
INSERT INTO Customers VALUES (6, 'Draco Malfoy');

create table Orders (order_id INT PRIMARY KEY,customer_id INT,order_date DATE);
insert into Orders values
(201, 1, '2026-01-10'),
(202, 1, '2026-02-15'),
(203, 2, '2026-03-20'),
(204, 2, '2026-03-20'),
(205, 3, '2026-03-21'),
(206, 4, '2026-04-01'),
(207, 5, '2026-04-02');

select * from Customers;
select * from Orders;

#Types of Joins
#INNER JOIN:-
#Shows only matching records in both tables
SELECT c.name, o.order_id
FROM Customers c
INNER JOIN Orders o
ON c.customer_id = o.customer_id;

#LEFT JOIN:-
#Shows:
#All records from left table
#Matching records from right table
#If no match → NULL
SELECT c.name, o.order_id
FROM Customers c
LEFT JOIN Orders o
ON c.customer_id = o.customer_id;

#RIGHT JOIN:-
#Opposite of LEFT JOIN:
#All records from right table
#Matching from left
SELECT c.name, o.order_id
FROM Customers c
RIGHT JOIN Orders o
ON c.customer_id = o.customer_id;

#FULL JOIN:-
#Shows:
#All records from both tables
#Non-matching → NULL
#MySQL doesn’t support FULL JOIN directly
#(we use UNION for that)
SELECT c.name, o.order_id
FROM Customers c
LEFT JOIN Orders o
ON c.customer_id = o.customer_id
union
SELECT c.name, o.order_id
FROM Customers c
RIGHT JOIN Orders o
ON c.customer_id = o.customer_id;

#What is SELF JOIN?
#A SELF JOIN means Joining a table with itself, Because sometimes data in the same table is related to itself.

create table Employee_s (emp_id int, emp_name varchar(50), manager_id int);
insert into Employee_s values 
(1, 'Harry', Null),
(2, 'Ron', 1),
(3, 'Hermione', 1),
(4, 'Draco', 2);

#Simple Example (Real-Life Idea)
#One employee has a manager and Manager is also an employee.
#So both are in the same table.
SELECT e.emp_name AS employee, m.emp_name AS manager
FROM Employee_s e
LEFT JOIN Employee_s m
ON e.manager_id = m.emp_id;


#Task:-
#DEPARTMENTS Table
CREATE TABLE Departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);
INSERT INTO Departments VALUES
(1, 'HR'),
(2, 'IT'),
(3, 'Finance'),
(4, 'Marketing');

#EMPLOYEES Table
CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    salary INT,
    dept_id INT,
    manager_id INT
);
INSERT INTO Employees VALUES
(101, 'Arun', 50000, 2, NULL),
(102, 'Bala', 40000, 1, 101),
(103, 'Charan', 45000, 2, 101),
(104, 'Divya', 30000, NULL, 102),
(105, 'Esha', 60000, 3, 101),
(106, 'Farhan', 35000, 2, 103),
(107, 'Gokul', 28000, 2, 103);

#1.Write a query to display employee names and their department names using INNER JOIN.
SELECT e.emp_name, d.dept_name
FROM Employees e
INNER JOIN Departments d
ON e.dept_id = d.dept_id;

#2.Write a query to show all employees and their department names, including employees who are not assigned to any department.
SELECT e.emp_name, d.dept_name
FROM Employees e
LEFT JOIN Departments d
ON e.dept_id = d.dept_id;

#3.Write a query to list all departments and the employees in them, including departments with no employees
SELECT d.dept_name, e.emp_name
FROM Employees e
RIGHT JOIN Departments d
ON e.dept_id = d.dept_id;

#4.Write a query to find employees who do not belong to any department using LEFT JOIN and IS NULL.
SELECT e.emp_name
FROM Employees e
LEFT JOIN Departments d
ON e.dept_id = d.dept_id
WHERE d.dept_id IS NULL;

#5.Write a query to display employee names, department names, and manager names.
SELECT e.emp_name AS employee, d.dept_name, m.emp_name AS manager
FROM Employees e
JOIN Departments d
ON e.dept_id = d.dept_id
LEFT JOIN Employees m
ON e.manager_id = m.emp_id;

#6.Write a query to find pairs of employees working in the same department using SELF JOIN.
SELECT e1.emp_name AS emp1, e2.emp_name AS emp2, e1.dept_id
FROM Employees e1
JOIN Employees e2
ON e1.dept_id = e2.dept_id AND e1.emp_id < e2.emp_id;

#10.Write a query to find departments where more than 3 employees work, and display:
SELECT d.dept_name, COUNT(e.emp_id) AS total_employees, AVG(e.salary) AS avg_salary,
MAX(e.salary) AS highest_salary
FROM Employees e
JOIN Departments d
ON e.dept_id = d.dept_id
GROUP BY d.dept_name
HAVING COUNT(e.emp_id) > 3;

#CUSTOMERS Table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50)
);
INSERT INTO Customers VALUES
(1, 'Ravi'),
(2, 'Sita'),
(3, 'John');

#ORDERS Table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE
);
INSERT INTO Orders VALUES
(201, 1, '2024-01-10'),
(202, 1, '2024-02-15'),
(203, 2, '2024-03-20');

#7.Write a query to show customer names and their order details using INNER JOIN.
SELECT c.customer_name, o.order_id, o.order_date
FROM Customers c
INNER JOIN Orders o
ON c.customer_id = o.customer_id;

#STUDENTS Table
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50)
);
INSERT INTO Students VALUES
(1, 'Amit'),
(2, 'Neha'),
(3, 'Rahul');

#COURSES Table
CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(50)
);
INSERT INTO Courses VALUES
(101, 'SQL'),
(102, 'Python'),
(103, 'Power BI');

#ENROLLMENTS Table
CREATE TABLE Enrollments (
    student_id INT,
    course_id INT
);
INSERT INTO Enrollments VALUES
(1, 101),
(1, 102),
(2, 103),
(3, 101);

#8.Write a query to display students who have enrolled in courses using JOIN.
SELECT s.student_name, c.course_name
FROM Students s
JOIN Enrollments e
ON s.student_id = e.student_id
JOIN Courses c
ON e.course_id = c.course_id;

#SUPPLIERS Table
CREATE TABLE Suppliers (
    supplier_id INT PRIMARY KEY,
    supplier_name VARCHAR(50),
    city VARCHAR(50)
);
INSERT INTO Suppliers VALUES
(1, 'ABC Traders', 'Chennai'),
(2, 'XYZ Suppliers', 'Mumbai'),
(3, 'Fresh Mart', 'Chennai');

#PRODUCTS Table
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    supplier_id INT
);
INSERT INTO Products VALUES
(101, 'Laptop', 1),
(102, 'Mouse', 2),
(103, 'Keyboard', 3);

#9.Write a query to retrieve product names and supplier names for products supplied by suppliers located in Chennai.
SELECT p.product_name, s.supplier_name
FROM Products p
JOIN Suppliers s
ON p.supplier_id = s.supplier_id
WHERE s.city = 'Chennai';