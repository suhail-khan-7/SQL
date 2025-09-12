SELECT *
  FROM [Online_Books_Sales_Database].[dbo].[Books]

  SELECT *
  FROM [Online_Books_Sales_Database].[dbo].Customers

  SELECT *
  FROM [Online_Books_Sales_Database].[dbo].Orders

-- BASIC QUERIES
-- 1. Retrive all books in th "fiction" genre.

SELECT *
  FROM [Online_Books_Sales_Database].[dbo].[Books]
  where Genre='fiction'

-- 2. Find Books Published after the year 1950.

SELECT *
  FROM [Online_Books_Sales_Database].[dbo].[Books]
  where Published_Year>1950

-- 3. List all  customers from the canada.

select *
from Customers
where Country like '%canada%'

-- 4. Show orders placed in november 2023.

select *
from Orders
where Order_Date between '2023-11-01' and '2023-11-30'
order by Order_Date 

-- 5. Retrive the total stock of books available.

select sum(stock) as total_quentity
from Books

-- 6. Find the details of the most expensive books.

select top(1)*
from Books
order by Price desc

-- 7. Show all customers who order more then 1 quentity of a book.

select c.*,o.Quantity
from Customers as c
left join Orders as o
on c.Customer_ID=o.Customer_ID
where o.Quantity>1
order by Quantity 

-- 8. Retrieve all orders where the total amount exceeds $20.

select *
from Orders
where Total_Amount>20
order by Total_Amount

-- 9. List all genres availeble in the books table.

select distinct Genre
from Books

-- 10. Find the books with the lowest stock.

select *
from Books
where Stock=0
order by Price desc

-- 11. Calculate the total revenue generated from all orders.

select sum(total_amount) as total_revenue
from Orders

-- ADVANCE QUERIES

-- 1. Retrive the total number of books sold for each genre.

select b.Genre,sum(o.Quantity) as total_qty
from books as b
left join Orders as o
on b.Book_ID=o.Book_ID
group by b.Genre

--2. Find the Average price of books in the 'fantasy' genre.

select Genre,AVG(price) as avg_price
from Books
group by Genre
having Genre='fantasy'

--3. List customer who have placed at least 2 orders.

select c.Name,o.Customer_ID,count(o.order_id) as order_count
from Customers as c
join Orders as o
on c.Customer_ID=o.Customer_ID
group by o.Customer_ID,c.Name
having count(o.order_id)>1

-- 4. Find the most frequently ordered book.

select b.Title,o.Book_ID,count(o.order_id) as order_count
from Books as b
join Orders as o
on b.Book_ID=o.Book_ID
group by b.Title,o.Book_ID
having count(order_id)=4
order by order_count desc

-- 5. Show the top 3 most expensive book of fantasy genre.

select top(3)*
from Books
where Genre='fantasy'
order by price desc

-- 6. Retrieve the total quantity of book sold by each author.

select b.Author,o.Book_ID,sum(o.quantity) as total_qty
from Books as b
join Orders as o
on b.Book_ID=o.Book_ID
group by b.Author,o.Book_ID

-- 7. List the cities where customers who spent over $30 are located.

select c.City,o.total_amount
from Customers as c
join Orders as o
on c.Customer_ID=o.Customer_ID
where o.Total_Amount>30
order by o.Total_Amount

-- 8. Find the customers who spent the most on orders.

select  top(1)Customer_ID,sum(total_amount) as total_amt_spent
from Orders
group by Customer_ID
order by total_amt_spent desc

-- 9. Calculate stock remaining after the fulfilling the all orders.

select b.Book_ID,b.Title,sum(b.Stock) as total_stock,coalesce(sum(o.quantity),0) as order_qty,
sum(b.Stock)- coalesce(sum(o.quantity),0) as remaining_qty
from Books as b
left join Orders as o
on b.Book_ID=o.Book_ID
group by b.Book_ID,b.Title
