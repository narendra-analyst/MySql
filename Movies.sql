show databases;
create database movie_list;
create table movie (s_no int, title varchar(20), director varchar(20), hero varchar(20), total int);
use  movie_list;
show tables;
insert into movie values(1,"Master","Lokesh Kanagaraj","Thalapathy Vijay", 64),(2,"Beast","Nelson Dilipkumar","Thalapathy Vijay", 65),
(3,"Varisu","Vamsi Padipalli","Thalapathy Vijay", 66),(4,"Leo","Lokesh Kanagaraj","Thalapathy Vijay", 67),
(5,"GOAT","Venkat Prabhu","Thalapathy Vijay", 68),(6,"Jana Nayagan","H.Vinoth","Thalapathy Vijay", 69);
select * from movie;

