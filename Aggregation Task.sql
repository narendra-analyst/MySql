show databases;
create database Aggregation;
use Aggregation;
create table sales (
    sale_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    product_id INT,
    region VARCHAR(50),
    sale_date DATE,
    quantity INT,
    revenue INT
);
insert into sales (customer_id, product_id, region, sale_date, quantity, revenue) VALUES
-- Customer 1 (many purchases, high revenue)
(1,101,'East','2024-01-01',20,15000),
(1,102,'East','2024-01-02',18,12000),
(1,103,'East','2024-01-03',25,22000),
(1,104,'East','2024-01-04',30,25000),
(1,105,'East','2024-01-05',5,2000),
(1,106,'East','2024-01-06',2,800),
-- Customer 2
(2,101,'West','2024-02-01',10,5000),
(2,102,'West','2024-02-02',12,6000),
(2,103,'West','2024-02-03',1,500),
-- Customer 3
(3,201,'North','2024-03-01',20,20000),
(3,202,'North','2024-03-02',15,18000),
-- Customer 4
(4,301,'South','2024-04-01',2,800),
(4,302,'South','2024-04-02',3,1200),
(4,303,'South','2024-04-03',1,600),
-- Customer 5
(5,401,'East','2024-05-01',50,60000),
(5,402,'East','2024-05-02',40,55000),
-- Customer 6
(6,501,'West','2024-06-01',5,3000),
(6,502,'West','2024-06-02',6,3500);

#1.Customers who made more than 3 purchases
select customer_id from sales
group by customer_id
having count(*) > 3;

#2.Products with avg quantity > 15
select product_id from sales
group by product_id
having avg(quantity) > 15;

#3.Regions where max revenue > 10000
select region from sales
group by region
having max(revenue) > 10000;

#4.Products where min quantity < 3
select product_id from sales
group by product_id
having min(quantity) > 3;

#5.Customers with total revenue between 10000 and 50000
select customer_id from sales
group by customer_id
having sum(revenue) between 10000 and 50000;

#6.Regions with more than 2 distinct products
select region from sales
group by region
having count(distinct product_id) > 2;

#7.Customers with highest purchase > 20000
select customer_id from sales
group by customer_id
having max(revenue) > 20000;

#8.Products sold more than 2 times
select product_id from sales
group by product_id
having count(*) > 2;

#9.Customers with at least 3 distinct products
select customer_id from sales
group by customer_id
having count(distinct product_id) >= 3;

#10.Products where total revenue > total quantity * 100
select product_id from sales
group by product_id
having sum(revenue) > sum(quantity) * 100;

#11.Regions where max ≥ 2 × avg revenue
select region from sales
group by region
having max(revenue) >= 2 * avg(revenue);

#12.Customers where min, max, avg revenue > 1000
select customer_id from sales
group by customer_id
having min(revenue) > 1000 AND max(revenue) > 1000 AND avg(revenue) > 1000;

#13.Customers with >2 purchases in 2024 & revenue > 20000
select customer_id from sales
where year(sale_date) = 2024
group by customer_id
having count(*)  > 2 AND sum(revenue) > 2000;

#14.Products (quantity >10) avg revenue >5000
select product_id from sales
where quantity > 10
group by product_id
having avg(revenue) > 5000;

#15.Customers only in 'East' and >2 purchases
select customer_id from sales
where region = 'East'
group by customer_id
having count(*) > 2;

#16.Products where revenue >1000 and sold at least 2 times
select product_id from sales
where revenue > 1000
group by product_id
having count(quantity) >= 2;




