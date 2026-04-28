show databases;
create database constraints;
use constraints;

#1.What are Constraints in SQL?
#Constraints = Rules applied on table columns
#They control what type of data can be stored.
#Simple line you can say tomorrow:
#Constraints are rules in SQL that ensure only valid and correct data is stored in a table.”

#2.Why we use Constraints?
#Without constraints 
#Duplicate IDs can come
#Empty values can come
#Wrong data can come

#With constraints
#Data becomes clean, accurate, reliable

#parent table:-
CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

#child table:-
create table students (
    id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    age INT CHECK (age >= 18),
    course VARCHAR(50) DEFAULT 'ECE',
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);
INSERT INTO departments VALUES
(1, 'IT'),
(2, 'HR'),
(3, 'Sales');

INSERT INTO students (id, name, email, age, dept_id) VALUES
(1, 'Ram', 'ram@gmail.com', 22, 1),
(2, 'Sam', 'sam@gmail.com', 25, 2),
(3, 'John', 'john@gmail.com', 19, 1);

select * from students;
select * from departments;

#1.PRIMARY KEY
#id INT PRIMARY KEY
#Meaning:
#Each student must have unique id Cannot be NULL
#eg:
INSERT INTO students VALUES (1, 'A', 'a@gmail.com', 20, 'ECE', 1);
#does not allow duplicates

#2.NOT NULL 
#name VARCHAR(50) NOT NULL
#Meaning:
#should not be null, allows duplicate
#eg:
INSERT INTO students (id) VALUES (4);
#does not allow null

#3.UNIQUE
#email VARCHAR(100) UNIQUE
#Meaning:
#No two students can have same email
INSERT INTO students VALUES (4, 'Raj', 'ram@gmail.com', 21, 'ECE', 1);
#does not allows duplicate, but null is allowed.

#4.CHECK
#age INT CHECK (age >= 18)
#Meaning:
#Adds condition to restrict values like, age must be 18 or above.
INSERT INTO students VALUES (5, 'Mini', 'mini@gmail.com', 15, 'ECE', 1);
#allows only the given condition is satisfied

#5.DEFAULT
#course VARCHAR(50) DEFAULT 'BCA'
#Meaning:
#If course not given → automatically "ECE"
INSERT INTO students (id, name, email, age, dept_id)
VALUES (6, 'Anu', 'anu@gmail.com', 20, 2);
#course = ECE automatically added

#6.FOREIGN KEY
#FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
#Meaning:
#Links one table to another table and maintain relationship - dept_id must exist in departments table
INSERT INTO students VALUES (7, 'Tom', 'tom@gmail.com', 22, 'ECE', 10);
#does not allow the invalid values - there is no dept_id 10 in department.

#parent table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50)
);
INSERT INTO customers VALUES
(1, 'Vijay'),
(2, 'Vikram'),
(3, 'Jai');

#child table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
INSERT INTO orders VALUES
(101, 'Laptop', 1),
(102, 'Mobile', 2),
(103, 'Tablet', 1);

select * from customers;
select * from orders;

INSERT INTO customers VALUES (4, 'Vishal');
INSERT INTO orders VALUES (104, 'Camera', 4);

#for delete first have to delete the child table and after that only parent table

DELETE FROM orders WHERE customer_id = 4;
DELETE FROM customers WHERE customer_id = 4;











