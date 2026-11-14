DROP  TABLE IF EXISTS books;
CREATE TABLE books(
	Book_ID	INT	PRIMARY KEY,
	Title   VARCHAR(50),	
	Author	VARCHAR(50),	
	Genre	VARCHAR(50),	
	Published_Year	INT,
	Price	NUMERIC(10,2),	
	Stock INT	
);
SELECT*FROM books;
DROP TABLE IF EXISTS customers;
 CREATE TABLE customers(
	Customer_ID	INT PRIMARY KEY,
 	Name	VARCHAR(50),	
	Email	VARCHAR(50),	
	Phone	VARCHAR(15),	
	City	VARCHAR(50),	
	Country	VARCHAR(100)	
 );
 SELECT*FROM customers;
 DROP TABLE IF EXISTS orders;
  CREATE TABLE orders(
	Order_ID	INT	PRIMARY KEY,		
 	Customer_ID	INT	REFERENCES	customers(Customer_ID),
	Book_ID	INT	REFERENCES	books(Book_ID),
	Order_Date	DATE,			
	Quantity	INT,			
	Total_Amount	NUMERIC	(10,2)		
  );
    SELECT*FROM orders;
    SELECT*FROM customers;
    SELECT*FROM books;

-- 1) Retrieve all books in the "Fiction" genre:
	SELECT*FROM books
	WHERE genre='Fiction';
-- 2) Find books published after the year 1950:
	SELECT*FROM books
	WHERE published_year>1950;
-- 3) List all customers from the Canada:
	 SELECT*FROM customers
	WHERE country='Canada';
-- 4) Show orders placed in November 2023:
	SELECT*FROM orders
	WHERE order_date BETWEEN '2023-11-01' AND '2023-11-30';
-- 5) Retrieve the total stock of books available:
	SELECT SUM(stock)
	FROM books;
-- 6) Find the details of the most expensive book:
	SELECT*FROM books ORDER BY price DESC LIMIT 1;
-- 7) Show all customers who ordered more than 1 quantity of a book:
	SELECT*FROM orders
	WHERE quantity>1;
-- 8) Retrieve all orders where the total amount exceeds $20:
	SELECT*FROM orders
	WHERE total_amount>20;
-- 9) List all genres available in the Books table:
	SELECT DISTINCT genre FROM Books;

	
-- 10) Find the book with the lowest stock:
	SELECT* FROM books ORDER BY stock ASC LIMIT 1;
	
-- 11) Calculate the total revenue generated from all orders:
	SELECT SUM(total_amount) FROM orders;

-- Advance Questions : 
-- 1) Retrieve the total number of books sold for each genre:
	SELECT * FROM orders;
	
	SELECT b.genre, SUM(o.quantity) AS total_book_sold
	FROM orders o
	JOIN books b ON o.book_id=b.book_id
	GROUP BY b.genre;
-- 2) Find the average price of books in the "Fantasy" genre:
	SELECT * FROM books;
	SELECT AVG(price) AS avg_price
	FROM books
	WHERE genre='Fantasy';

-- 3) List customers who have placed at least 2 orders:
	SELECT*FROM customers;
	SELECT * FROM orders;
	SELECT o.customer_id,c.name, COUNT(o.order_id)AS count_order
	FROM orders o
	JOIN customers c ON o.customer_id=c.customer_id
	GROUP BY o.customer_id,c.name
	HAVING COUNT(order_id)>=2;
-- 4) Find the most frequently ordered book:
	SELECT*FROM books;
	SELECT*FROM orders;
	SELECT o.book_id,b.title,COUNT(o.order_id) AS count_order
	FROM orders o
	JOIN books b on o.book_id=b.book_id
	GROUP BY o.book_id,b.title
	ORDER BY count_order DESC LIMIT 1;

-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :
	SELECT *FROM books
	WHERE genre='Fantasy'
	ORDER BY price DESC LIMIT 3;

-- 6) Retrieve the total quantity of books sold by each author:
	SELECT * FROM orders;
	SELECT *FROM books;
	SELECT o.book_id,b.author, SUM(o.quantity) AS total_sold_author
	FROM orders o
	JOIN books b ON o.book_id=b.book_id
	GROUP BY o.book_id,b.author;
-- 7) List the cities where customers who spent over $30 are located:
	SELECT * FROM orders;
	SELECT * FROM customers;
	SELECT DISTINCT c.city,o.total_amount
	FROM orders o
	JOIN customers c ON o.customer_id=c.customer_id
	WHERE o.total_amount>=30;
-- 8) Find the customer who spent the most on orders:
	SELECT c.customer_id,c.name,SUM(o.total_amount) AS spent_amount
	FROM orders o
	JOIN customers c ON o.customer_id=c.customer_id
	GROUP BY c.customer_id,c.name
	ORDER BY spent_amount DESC LIMIT 1;
--9) Calculate the stock remaining after fulfilling all orders:
	SELECT * FROM orders;
	SELECT * FROM books;

	SELECT b.book_id,b.title,b.stock, COALESCE(SUM(o.quantity),0) AS Order_quantity,  
	b.stock- COALESCE(SUM(o.quantity),0) AS Remaining_Quantity
	FROM books b
    LEFT JOIN orders o ON b.book_id=o.book_id
    GROUP BY b.book_id ORDER BY b.book_id DESC LIMIT 3;
  