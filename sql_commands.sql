show databases;
create database sql_commands;
use sql_commands;

#TCL Commands:-
#TCL stands for Transaction Control Language in SQL.It is used to manage transactions in a database.
#eg:
UPDATE accounts SET balance = balance - 1000 WHERE id = 1;
UPDATE accounts SET balance = balance + 1000 WHERE id = 2;

# Main TCL Commands:-
#1. COMMIT
#Saves all changes permanently in the database.
#Syntax - COMMIT;
#eg:
UPDATE employees
SET salary = salary + 5000
WHERE emp_id = 1;
COMMIT;
#Meaning
#Salary updated permanently. Cannot undo after commit.alter

#2.ROLLBACK
#Undo changes that are not committed yet.
#Syntax - ROLLBACK;
#eg:
UPDATE employees
SET salary = salary - 5000
WHERE emp_id = 1;
ROLLBACK;
#Meaning - Change is cancelled. Original data restored.

#3. SAVEPOINT
#Creates a temporary checkpoint inside a transaction.
#Syntax - SAVEPOINT savepoint_name;
#eg:
UPDATE employees SET salary = 50000 WHERE emp_id = 1;
SAVEPOINT s1;
UPDATE employees SET salary = 60000 WHERE emp_id = 2;
#First update = before savepoint, Second update = after savepoint

#4. ROLLBACK TO SAVEPOINT
#Undo changes only up to a savepoint.
#Syntax - ROLLBACK TO savepoint_name;
#eg:
UPDATE employees SET salary = 50000 WHERE emp_id = 1;
SAVEPOINT s1;
UPDATE employees SET salary = 60000 WHERE emp_id = 2;
ROLLBACK TO s1;
#emp_id = 1 change remains | emp_id = 2 change removed

#5. SET TRANSACTION
#Defines transaction properties.
#Syntax - SET TRANSACTION READ ONLY; or SET TRANSACTION READ WRITE;
#Usage - Controls how transaction behaves. Mostly used in advanced SQL.

#Easy Real-Life Example
#Imagine ATM transaction:
#Money deducted from Account A
#Money added to Account B
---
#If system crashes after step 1:
#Without TCL → money lost
#With TCL → rollback restores data

#Complete Example
CREATE TABLE bank (
    id INT,
    name VARCHAR(50),
    balance INT
);
INSERT INTO bank VALUES
(1, 'Harry', 10000),
(2, 'Ron', 5000);

#Transaction Example
START TRANSACTION;
UPDATE bank
SET balance = balance - 2000
WHERE id = 1;
UPDATE bank
SET balance = balance + 2000
WHERE id = 2;
COMMIT;

#Rollback Example
START TRANSACTION;
UPDATE bank
SET balance = balance - 2000
WHERE id = 1;
ROLLBACK;

# DCL stands for Data Control Language.
#It is used to:
#Give permissions
# Remove permissions
# from database users.

# Main DCL Commands
#1. GRANT
#Gives privileges/permissions to a user.
#Syntax - GRANT privilege_name
#ON table_name
#TO user_name;

#Example 1 — Give SELECT Permission
#GRANT SELECT
#ON employees
#TO john;
#User john can:
#view data from employees table
#cannot insert/update/delete

#Example 2 — Give Multiple Permissions
#GRANT SELECT, INSERT, UPDATE
#ON employees
#TO john;

#User can:
#read data
#add data
#modify data

#2. REVOKE
# Removes permissions from a user.
#REVOKE privilege_name
#ON table_name
#FROM user_name;

#Example
#REVOKE INSERT
#ON employees
#FROM john;
#User john can no longer insert records.

#Common Privileges in DCL
-- Privilege	      Meaning
-- SELECT	          Read data
-- INSERT	          Add data
-- UPDATE	          Modify data
-- DELETE	          Remove data
-- ALL PRIVILEGES	  All permissions

CREATE TABLE employees (
    emp_id INT,
    name VARCHAR(50),
    salary INT
);

#Grant Permission
GRANT SELECT, INSERT
ON employees
TO ram;
#Now ram can: view records insert records

#Revoke Permission
REVOKE INSERT
ON employees
FROM ram;
#Now ram can only: view records

#Difference Between TCL and DCL
-- TCL	                            DCL
-- Transaction Control Language	Data Control Language
-- Manages transactions	        Manages permissions
-- COMMIT, ROLLBACK	            GRANT, REVOKE






















































