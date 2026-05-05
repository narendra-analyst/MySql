show databases;
create database subquery_task;
use subquery_task;

#Types of Subqueries:-
#1. Single Row Subquery - Returns only one value
SELECT name
FROM Employees
WHERE salary > (SELECT salary FROM Employees WHERE emp_id = 1);
#Compare with one value only

#2.Multiple Row Subquery - Returns multiple values
#Use operators like: (IN, ANY, ALL)
#Using IN
SELECT name
FROM Employees
WHERE dept_id IN (
    SELECT dept_id FROM Departments WHERE location = 'Chennai'
);
#Means: get employees from departments in Chennai

#Using ANY
SELECT name
FROM Employees
WHERE salary > ANY (
    SELECT salary FROM Employees WHERE dept_id = 101
);
#Salary greater than at least one value

#Using ALL
SELECT name
FROM Employees
WHERE salary > ALL (
    SELECT salary FROM Employees WHERE dept_id = 101
);
#Salary greater than all values

#3.Correlated Subquery
#Inner query depends on outer query
SELECT e1.name
FROM Employees e1
WHERE salary > (
    SELECT AVG(salary)
    FROM Employees e2
    WHERE e1.dept_id = e2.dept_id
);
#How it works:
#For each row in outer query
#Inner query runs again
#Result: Employees earning more than their department average

#4.Nested Subqueries
#Subquery inside another subquery
SELECT name
FROM Employees
WHERE dept_id = (
    SELECT dept_id
    FROM Departments
    WHERE manager_id = (
        SELECT emp_id FROM Employees WHERE name = 'Harry Potter'
    )
);

#5.Subquery in SELECT
SELECT name,
       (SELECT AVG(salary) FROM Employees) AS avg_salary
FROM Employees;
#Adds extra column

#6.Subquery in FROM (Derived Table)
SELECT dept_id, AVG(salary)
FROM (
    SELECT * FROM Employees WHERE salary > 50000
) AS temp
GROUP BY dept_id;

#Operators Used with Subqueries
#Operator	 Meaning
#=	         Equal to single value
#IN	         Matches any value
#ANY	     Compare with any
#ALL	     Compare with all
#EXISTS	     Checks if rows exist

#EXISTS Example
SELECT name
FROM Employees e
WHERE EXISTS (
    SELECT 1 FROM Orders o WHERE e.emp_id = o.emp_id
);
#Returns employees who have orders

#Task:-
CREATE TABLE Departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    dept_id INT,
    salary INT,
    FOREIGN KEY (dept_id) REFERENCES Departments(dept_id)
);

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

#Departments
INSERT INTO Departments VALUES
(101, 'HR'),
(102, 'IT'),
(103, 'Finance'),
(104, 'Marketing');

#Employess
INSERT INTO Employees VALUES
(1, 'Harry', 101, 40000),
(2, 'Hermione', 101, 60000),
(3, 'Ron', 101, 60000),
(4, 'Dumbledore', 102, 90000),
(5, 'Snape', 102, 80000),
(6, 'Draco', 102, 50000),
(7, 'Voldemort', 103, 30000),
(8, 'Bellatrix', 103, 30000),
(9, 'Sirius', 104, 70000);

#Customers
INSERT INTO Customers VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Charlie'),
(4, 'David');

#Orders
INSERT INTO Orders VALUES
(101, 1),
(102, 1),
(103, 2);

#1.Find employees who work in departments named 'HR' or 'IT'(using IN)
SELECT name
FROM Employees
WHERE dept_id IN (
    SELECT dept_id 
    FROM Departments 
    WHERE dept_name IN ('HR', 'IT')
);

#2.Find employees who are not in departments 'HR' or 'Finance'(using NOT IN)
SELECT name
FROM Employees
WHERE dept_id NOT IN (
    SELECT dept_id 
    FROM Departments 
    WHERE dept_name IN ('HR', 'Finance')
);

#3.Find employees whose salary is greater than any employee in HR department(using ANY)
SELECT name
FROM Employees
WHERE salary > ANY (
    SELECT salary 
    FROM Employees 
    WHERE dept_id = (
        SELECT dept_id FROM Departments WHERE dept_name = 'HR'
    )
);

#4.Find employees whose salary is greater than all employees in HR department(using ALL)
SELECT name
FROM Employees
WHERE salary > ALL (
    SELECT salary 
    FROM Employees 
    WHERE dept_id = (
        SELECT dept_id FROM Departments WHERE dept_name = 'HR'
    )
);

#5.Find customers who have placed at least one order(using EXISTS (Correlated))
SELECT name
FROM Customers c
WHERE EXISTS (
    SELECT 1 
    FROM Orders o 
    WHERE c.customer_id = o.customer_id
);

#6.Find customers who have never placed any orders(using NOT EXISTS)
SELECT name
FROM Customers c
WHERE NOT EXISTS (
    SELECT 1 
    FROM Orders o 
    WHERE c.customer_id = o.customer_id
);

#7.Show employee name with their department average salary(using Scalar Subquery)
SELECT name,
       (SELECT AVG(salary) 
        FROM Employees e2 
        WHERE e2.dept_id = e1.dept_id) AS avg_salary
FROM Employees e1;

#8.Find employees who earn more than the average salary of their own department(using Correlated Subquery)
SELECT name
FROM Employees e1
WHERE salary > (
    SELECT AVG(salary)
    FROM Employees e2
    WHERE e1.dept_id = e2.dept_id
);

#9.Find total salary per department and show department name(using Subquery in FROM (Derived Table))
SELECT d.dept_name, t.total_salary
FROM (
    SELECT dept_id, SUM(salary) AS total_salary
    FROM Employees
    GROUP BY dept_id
) t
JOIN Departments d ON t.dept_id = d.dept_id;

#10.Find employees who work in departments where average salary > 50000(using Nested Subquery (Multi-level))
SELECT name
FROM Employees
WHERE dept_id IN (
    SELECT dept_id
    FROM (
        SELECT dept_id, AVG(salary) AS avg_sal
        FROM Employees
        GROUP BY dept_id
    ) temp
    WHERE avg_sal > 50000
);

#11.Find employees who have the maximum salary in their department
SELECT name, dept_id, salary
FROM Employees e1
WHERE salary = (
    SELECT MAX(salary)
    FROM Employees e2
    WHERE e1.dept_id = e2.dept_id
);

#12.Find employees who share the same salary with someone else in their department
SELECT name, dept_id, salary
FROM Employees e1
WHERE salary IN (
    SELECT salary
    FROM Employees e2
    WHERE e1.dept_id = e2.dept_id
    GROUP BY salary
    HAVING COUNT(*) > 1
);

#13.Find employees who belong to departments having more than 1 employee (Count Employees per Department (>1))
SELECT name
FROM Employees
WHERE dept_id IN (
    SELECT dept_id
    FROM Employees
    GROUP BY dept_id
    HAVING COUNT(*) > 1
);

#14. Find employees who have the minimum salary in their department
SELECT name, dept_id, salary
FROM Employees e1
WHERE salary = (
    SELECT MIN(salary)
    FROM Employees e2
    WHERE e1.dept_id = e2.dept_id
);











