show databases;
create database windows_fucntion;
use windows_fucntion;

#What is a Window Function?
# A window function performs a calculation across a set of rows, but does NOT collapse rows (unlike GROUP BY)

#Simple idea:
# GROUP BY → gives 1 row per group
# Window function → keeps all rows + adds extra info

#Example
SELECT name, dept_id, salary,
       AVG(salary) OVER (PARTITION BY dept_id) AS dept_avg
FROM Employees;
#Output:
# Each employee row stays
# But adds department average salary

#Syntax:
#FUNCTION(column) OVER (
#    PARTITION BY column
#    ORDER BY column
#)

#Three Important Parts
#1.PARTITION BY (like GROUP BY)
# Divides data into groups
# PARTITION BY dept_id

#2.ORDER BY
# Defines order inside each group
# ORDER BY salary DESC

#Types of Window Functions
# 1. Aggregate Window Functions
# Same as normal functions but used with OVER()
#eg:AVG()
SELECT name, dept_id, salary,
       AVG(salary) OVER (PARTITION BY dept_id) AS avg_salary
FROM Employees;

#eg: SUM()
SELECT name, dept_id, salary,
       SUM(salary) OVER (PARTITION BY dept_id) AS total_salary
FROM Employees;

#2.Ranking Functions 
# ROW_NUMBER() - Unique ranking
SELECT name, dept_id, salary,
       ROW_NUMBER() OVER (PARTITION BY dept_id ORDER BY salary DESC) AS rn
FROM Employees;
#No duplicates → always unique

#RANK()
# Same rank → skips numbers
# RANK() OVER (PARTITION BY dept_id ORDER BY salary DESC)
# Example:1, 2, 2, 4

#DENSE_RANK()
# Same rank → no gaps
# DENSE_RANK() OVER (PARTITION BY dept_id ORDER BY salary DESC)
# Example: 1, 2, 2, 3

#3. Value Functions
#eg: LAG()
# Previous row value
SELECT name, salary,
       LAG(salary) OVER (ORDER BY salary) AS prev_salary
FROM Employees;

#eg: LEAD()
# Next row value
SELECT name, salary,
       LEAD(salary) OVER (ORDER BY salary) AS next_salary
FROM Employees;

#Real Example (Very Important)
# Compare salary with previous employee:
SELECT name, salary,
       salary - LAG(salary) OVER (ORDER BY salary) AS diff
FROM Employees;

#4. FIRST_VALUE() / LAST_VALUE()
SELECT name, dept_id, salary,
       FIRST_VALUE(salary) OVER (PARTITION BY dept_id ORDER BY salary DESC) AS highest
FROM Employees;

# Window Function vs GROUP BY
#Feature	GROUP BY	Window Function
#Rows	    Reduced	    Not reduced
#Detail  	Lost	    Preserved
#Use	    Summary	    Analysis

#Task:-
#1.ROW_NUMBER() – Basic Ordering
CREATE TABLE students (
    student_id INT,
    name VARCHAR(50),
    marks INT
);
INSERT INTO students VALUES
(1, 'Aman', 85),
(2, 'Bala', 90),
(3, 'Chitra', 78),
(4, 'Deepak', 92),
(5, 'Esha', 88);

#1.Assign row numbers based on marks in descending order
select *,
row_number() over(order by marks desc) as row_num
from students;

#2.Get top 3 students based on marks
select *
from( select *,
row_number() over(order by marks desc) as row_num
from students)t
where row_num <= 3;

#2.PARTITION BY – Group-wise Ranking
CREATE TABLE employees (
    emp_id INT,
    name VARCHAR(50),
    department VARCHAR(50),
    salary INT
);
INSERT INTO employees VALUES
(1, 'Aman', 'IT', 60000),
(2, 'Bala', 'IT', 70000),
(3, 'Chitra', 'HR', 50000),
(4, 'Deepak', 'HR', 55000),
(5, 'Esha', 'IT', 65000);

#3.Assign row numbers within each department based on salary
select *,
row_number() over(partition by department order by salary desc) as dept_rank
from employees;

#4.Find the highest paid employee in each department
select *
from ( select*,
row_number() over(partition by department order by salary desc) as dept_rank
from employees) t
where dept_rank = 1;

#3.RANK and DENSE_RANK
CREATE TABLE scores (
    player_id INT,
    player_name VARCHAR(50),
    score INT
);
INSERT INTO scores VALUES
(1, 'A', 100),
(2, 'B', 200),
(3, 'C', 200),
(4, 'D', 150),
(5, 'E', 100);

#5.Assign rank to players based on score in descending order
select *,
rank() over(order by score desc) as rank_val
from scores;

#6.Assign dense rank to players based on score in descending order
select *,
dense_rank() over(order by score desc) as dense_rank_val
from scores;

#7.Find top 2 distinct scores
select *
from ( select*,
dense_rank() over(order by score desc) as rnk
from scores)t
where rnk <=2;

#4.Row Comparison
CREATE TABLE sales (
    sale_id INT,
    sale_date DATE,
    amount INT
);
INSERT INTO sales VALUES
(1, '2023-01-01', 500),
(2, '2023-01-02', 700),
(3, '2023-01-03', 600),
(4, '2023-01-04', 900),
(5, '2023-01-05', 800);

#8.Show previous row amount for each row based on date
select *,
lag(amount) over(order by sale_date) as per_amount
from sales;

#9.Show next row amount for each row based on date
select*,
lead(amount) over(order by sale_date) as per_amount
from sales;

#10.Find difference between current row and previous row
select *,
amount - lag(amount) over(order by sale_date) as diff
from sales;

#5.Running Total
CREATE TABLE orders (
    order_id INT,
    order_date DATE,
    amount INT
);
INSERT INTO orders VALUES
(1, '2023-01-01', 100),
(2, '2023-01-02', 200),
(3, '2023-01-03', 300),
(4, '2023-01-04', 400),
(5, '2023-01-05', 500);

#11.Calculate running total of amount ordered by date
select *,
sum(amount) over(order by order_date) as running_total
from orders;

#12.Calculate cumulative sum of amount for all rows
select *,
sum(amount) over() as total_sum
from orders;

#6.Window Frame
CREATE TABLE temperature (
    day INT,
    temp INT
);
INSERT INTO temperature VALUES
(1, 30),
(2, 32),
(3, 31),
(4, 29),
(5, 35);

#13.Calculate moving average of last 3 rows
SELECT *,
AVG(temp) OVER (
    ORDER BY day
    ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
) AS moving_avg
FROM temperature;

#14.Calculate average including current row and previous row
SELECT *,
AVG(temp) OVER (
    ORDER BY day
    ROWS BETWEEN 1 PRECEDING AND CURRENT ROW
) AS avg_last_2
FROM temperature;

#7.Duplicate Handling
CREATE TABLE customers (
    id INT,
    name VARCHAR(50),
    city VARCHAR(50)
);
INSERT INTO customers VALUES
(1, 'Aman', 'Chennai'),
(2, 'Aman', 'Chennai'),
(3, 'Bala', 'Delhi'),
(4, 'Bala', 'Delhi'),
(5, 'Chitra', 'Mumbai');

#15.Remove duplicate rows and keep only one record
select id, name, city
from( select *,
row_number() over(partition by name order by id) as duplicates_removed
from customers) t
where duplicates_removed =1;




