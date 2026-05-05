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






