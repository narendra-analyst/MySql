show databases;
create database constraints;
  

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

#task
#1.Parent table for Orders
create table Customers (
    customer_id int primary key,
    customer_name varchar(50)
);

#2.Parent table for Enrollments
create table Courses (
    course_id int primary key,
    course_name varchar(50)
);

#1.Employees table
create table Employees (
    emp_id int primary key,
    email varchar(100) unique,
    salary decimal(10,2),
    dept varchar(50) default 'IT',
    check (salary > 15000)
);

#2.Students table
create table Students (
    student_id int primary key,
    age int,
    course varchar(50) not null,
    check (age between 18 AND 30)
);

#3. Orders table (Foreign Key)
create table Orders (
    order_id int primary key,
    customer_id int,
    foreign key (customer_id) references Customers(customer_id)
);

#4.Add CHECK to Products,Add a rule that price must be greater than
create table Products (
    product_id int primary key,
    price decimal(10,2)
);
alter table Products
add constraint chk_price check (price > 0);

#5.Add UNIQUE to Users, Make sure phone number is unique
create table Users (
    user_id int primary key,
    phone varchar(15)
);
alter table Users
add constraint uq_phone unique (phone);

#6.Try to insert duplicate phone number in Users table.
insert into Users values (1, '9876543210');
insert into Users values (2, '9876543210');

#7.Create an Enrollments table (foreign Key), student_id + course_id together form primary key
create table Enrollments (
    student_id int,
    course_id int,
    primary key (student_id, course_id),
    foreign key (student_id) references Students(student_id),
    foreign key (course_id) references Courses(course_id)
);

#8.Create payments table
create table Payments (
    payment_id int primary key,
    order_id int,
    payment_mode varchar(10),
    amount decimal(10,2),
    foreign key (order_id) references Orders(order_id),
    check (payment_mode in ('UPI', 'Card', 'Cash')),
    check (amount > 0)
);

#9.Drop CHECK constraintRemove the price check condition from Products table (drop)
alter table Products drop check chk_price;

#10.Create an Accounts table
create table Accounts (
    account_id int primary key,
    balance decimal(10,2) default 5000,
    check (balance >= 0)
);


