-- BASIC DATA RETRIVEL
-- 1. Retrive all records from customer table,displaying all availeble columns.

select *
  FROM [Ecom_store_sales_database].[dbo].[customers]

-- 2. Fetch only the customer_id,first_name and email from the customer table.

select customer_id,first_name,email
  FROM [Ecom_store_sales_database].[dbo].[customers]

-- 3. List all product that belong to the clothing category.

select *
  FROM [Ecom_store_sales_database].[dbo].[products]
where category='clothing'

-- 4. Retrieve all orders where the total purchace amount is greater then $500.

select *
  FROM [Ecom_store_sales_database].[dbo].[orders]
where total_amount>500

-- 5. Find all customer who joined the platform after jan 1,2023.

select *
  FROM [Ecom_store_sales_database].[dbo].[customers]
where join_date>'2023-01-01'

-- 6. Display the top 5 most expensive product available in the database.

select top (5) *
  FROM [Ecom_store_sales_database].[dbo].[products]
order by price desc

-- 7. List the latest 10 order placed, sorted the order date in descending order. 

select top (10) *
  FROM [Ecom_store_sales_database].[dbo].[orders]
order by order_date desc

-- 8. Retriveve all order that have a status of 'completetd'.

select *
  FROM [Ecom_store_sales_database].[dbo].[orders]
where order_status='completed'

-- 9. Find all order that were placed between 1 feb 2023 and 28 feb 2023.

select *
  FROM [Ecom_store_sales_database].[dbo].[orders]
where order_date between '2023-02-01' and '2023-02-28'
order by order_date

-- 10. List all products that have a price between $50 and $100.

select *
  FROM [Ecom_store_sales_database].[dbo].[products]
where price between 50 and 100
order by price desc

--AGGREGATE FUNCATION
-- 1. Count the total number of customers in the database.

select count(customer_id) as total_num_of_customer
  FROM [Ecom_store_sales_database].[dbo].[customers]

-- 2. Find the average order amount from the order table.

select avg(total_amount) as average_order_amount
  FROM [Ecom_store_sales_database].[dbo].[orders]

-- 3. Retrieve the hightest and lowest price products from the product list.

select product_name,price
  FROM [Ecom_store_sales_database].[dbo].[products]
  where price=(select max(price) from products)
  or price=(select min(price) from products)
  
-- 4. Count the number of products in each category.

select category,count(product_id) as number_of_product_in_each_category
  FROM [Ecom_store_sales_database].[dbo].[products]
  group by category
  order by number_of_product_in_each_category desc

-- 5. Calculate the total revenue generated from all orders.

select sum(total_amount) as Total_revenue_of_all_orders
  FROM [Ecom_store_sales_database].[dbo].[orders]
  

-- 6. Find the total number of orders placed by each customer, sorted by highest to lowest.
select customer_id,count(order_id) as total_count_of_oredr_by_each_customer
  FROM [Ecom_store_sales_database].[dbo].[orders]
group by customer_id
order by total_count_of_oredr_by_each_customer desc

-- 7. Calculate the revenue of generated for each month in 2023.

select month(order_date) as order_month,year(order_date) as order_year,sum(total_amount) as total_revenue_generated_in_each_month
  FROM [Ecom_store_sales_database].[dbo].[orders]
  where year(order_date)=2023
  group by year(order_date),month(order_date)
  order by order_month 

-- 8. List all customer who have placed order more then 5.

select customer_id,count(order_id) as total_number_of_order
  FROM [Ecom_store_sales_database].[dbo].[orders]
  group by customer_id
  having count(order_id)>5

-- 9. Identify the most freq used payment method based on the number of transactions.

select  payment_method,count(order_id) as most_of_time_used_payment_method
  FROM [Ecom_store_sales_database].[dbo].[payments]
  group by payment_method
  order by most_of_time_used_payment_method desc

-- 10. Find the average product price for each category.

select category,avg(price) as average_price_of_each_category
  FROM [Ecom_store_sales_database].[dbo].[products]
group by category

--JOINS
-- 1. Retrieve all order details along with the customer's first name and last name.

select a.*,b.first_name,b.last_name
  FROM [Ecom_store_sales_database].[dbo].[orders] as a
  left join customers as b
  on b.customer_id=a.order_id

-- 2. Fetch order item with product names, quantities and subtotal values.

select p.product_name,o.quantity,o.subtotal
  FROM [Ecom_store_sales_database].[dbo].[products] as p
  left join order_items as o
  on p.product_id=o.product_id

-- 3. List all payment transaction along with the corresponding order details.

select o.*,p.payment_id,p.payment_method,p.payment_status
  FROM [Ecom_store_sales_database].[dbo].[orders] as o
  left join payments as p
  on o.order_id=p.payment_id

-- 4. Identify customers who have never placed the order.

select c.*,o.*
  FROM [Ecom_store_sales_database].[dbo].[customers] as c
 left join orders as o
  on c.customer_id=o.customer_id
  where o.customer_id is null
 
-- 5. Find all product that have never been purchased.(i.e do not apear in any order)
  
  select i.*,p.product_id,p.product_name
  FROM [Ecom_store_sales_database].[dbo].[order_items] as i
  left join products as p
  on i.product_id=p.product_id
  where p.product_id is null
--It's mean all product have at least one time purchased.

-- 6. Retrieve customers and their total spending by summing up all their orders.
 
 select c.customer_id, c.first_name,c.last_name,sum(o.total_amount) as total_spending_amount
  FROM [Ecom_store_sales_database].[dbo].[orders] as o
  inner join customers as c
  on o.customer_id=c.customer_id
  group by c.first_name,c.last_name,c.customer_id
  order by total_spending_amount desc
  
-- 7. Get the total number of products order by each customer.
 
 select c.customer_id, c.first_name,c.last_name,count(o.order_id) as total_count_of_product_order
  FROM [Ecom_store_sales_database].[dbo].[order_items] as o
  inner join customers as c
  on o.order_id=c.customer_id
  group by c.first_name,c.last_name,c.customer_id
  order by total_count_of_product_order desc
 
-- 8. Display all order along with the names of the product included in each order.

select oi.*,p.product_name
  FROM [Ecom_store_sales_database].[dbo].[order_items] as oi
  left join products as p
  on p.product_id=oi.product_id
 

-- 9. Find orders that do not have any associated payments recorded.

select p.*
  FROM [Ecom_store_sales_database].[dbo].[payments] as p
  where payment_method is null
--It's mean all order have received payment.


-- 10. retrieve customer along with the last date they placed an order.

select c.customer_id, c.first_name,c.last_name,max(o.order_date) as last_date_of_placed_an_order
  FROM [Ecom_store_sales_database].[dbo].[customers] as c
  inner join orders as o
  on c.customer_id=o.customer_id
  group by c.first_name,c.last_name, c.customer_id

--SUBQUERIES AND ADVANCE FILTERS.
-- 1. Find the most expensive product in the store using a subquery.

select *
from products
where price=(select max(price)
from products)

-- 2. Retrieve the list of customers who have placed at least one product.

select *
from customers
where customer_id in (select distinct customer_id from orders)

-- 3. Display orders where the total amount is greater than the average amount.

select *
from orders
where total_amount>(select avg(total_amount) from orders)

-- 4. Identify the customer who has placed the highest number of orders.*

select customer_id, count(*) as order_count
from orders
group by customer_id
having count(*)=(select max(order_count) from (select customer_id, count(order_id) as order_count
from orders
group by customer_id
)as subquery)

select *
from customers
where customer_id=(select top(1) customer_id from orders
group by customer_id
order by count(order_id) desc)

-- 5. Fetch the second most expensive product using alternate ranking method.

with rank_product as(
select *,ROW_NUMBER() over
(order by price desc) as rank
from products
)
select *
from rank_product
where rank =2

-- 6. List all customers who have naver made a payment for any order.

select o.customer_id,p.payment_method,p.payment_status
from orders as o
left join payments as p
on o.order_id=p.order_id
where p.payment_id is null
-- Which mean all customer have made apayment for each order

-- 7. Retrieve all product with stock level below the average stock quantity.

select *
from products
where stock_quantity<(select avg(stock_quantity) from products)
order by stock_quantity desc

-- 8. Find customers who have spent more than $2000 in total orders.

select customer_id, sum(total_amount) as tol_amt_spent_by_each_customer
from orders
group by customer_id
having sum(total_amount)>2000

select *
from customers
where customer_id in (select customer_id from orders
group by customer_id
having sum(total_amount)>2000)

