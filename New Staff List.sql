SHOW DATABASES;
CREATE DATABASE staff_details;
USE staff_details;
CREATE TABLE staffs (
    s_no INT PRIMARY KEY,
    name VARCHAR(20),
    designation VARCHAR(30),
    salary INT,
    mobile VARCHAR(15)
);
INSERT INTO staffs (s_no, name, designation, salary, mobile) VALUES
(1, 'Narendra', 'Data Analyst', 80000, '8610347810'),
(2, 'Venkat', 'Software Developer', 90000, '97665001132'),
(3, 'Srinivasan', 'Senior Developer', 90000, '9876543210');
SELECT * FROM staffs;

alter table staffs
add column age int;

alter table staffs
drop column age;

alter table staffs
rename column name to f_name;