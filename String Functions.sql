use employees_details;
create database sqlfunctions;
use sqlfunctions;

#What is sql function?
#SQL funtions are built-in tools in SQL that helps you perform operations on data.

#What is String?
#String functions are used to work with text (characters) in a database.
#eg: name = 'narendra' , city =  'pondy'

#String Functions:
select upper ('narendra');
#converts upper text to capital letters

select lower ('NARENDRA');
#converts text to small letters

select length ('narendra');
#counts the number of characters

select concat ('narendra','','analyst');
#join two or more strings - eg: frist name and last name in one column

select substr('narendra', 1, 4);
#extracts the part of the string, like where to start and where to end

select trim(' hello ');
#removes the extra spaces

select replace ('hello world', 'world', 'sql');
#replace text with another text

select instr('narendra','e');
#find the position of the character

#Where we use string functions?
#In real-time data analyst work cleaning messy data, formatting names, searching text, combining columns(first_name and last_name).
 