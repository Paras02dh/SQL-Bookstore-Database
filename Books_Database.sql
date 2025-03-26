create database books;
use books;

create table book(
book_id int primary key,
title varchar(50),
author_id int,
publisher_id int,
genre_id int,
year_published int,
price float
);

insert into book(book_id,title,author_id,
publisher_id,genre_id,year_published,price)values
(1,"The Great Gatsby",1,1,1,1925,10.99),
(2,"Moby Dick",2,2,2,1851,15.49),
(3,"1984",3,3,3,1949,12.99),
(4,"To Kill a Mockingbird",4,1,4,1960,9.99),
(5,"Pride and Prejudice",5,2,5,1813,8.99),
(6,"The Catcher in the Rye",6,4,3,1951,13.49),
(7,"War and Peace",7,3,2,1869,20.00),
(8,"Crime and Punishment",8,5,4,1866,18.00);

create table authors(
author_id int primary key,
name varchar(50),
birth_year int,
country varchar(25)
);

insert into authors(author_id,name,birth_year,country)values
(1,"F. Scott Fitzgerald",1996,"USA"),
(2,"Herman Melville",1819,"USA"),
(3,"George Orwell",1903,"UK"),
(4,"Harper Lee",1926,"USA"),
(5,"Jane Austen",1775,"UK"),
(6,"J.D. Salinger",1919,"CANADA"),
(7,"Leo Tolstoy",1828,"Russia"),
(8,"Fyodor Dostoevsky",1821,"Russia");

create table genres(
genre_id int primary key,
genre_name varchar(20)
);

insert into genres(genre_id,genre_name)values
(1,"Fiction"),
(2,"Adventure"),
(3,"Dystopian"),
(4,"Drama"),
(5,"Romance");

create table publishers(
publisher_id int primary key,
publisher_name varchar(30),
country varchar(20)
);

insert into publishers(publisher_id	,publisher_name,country)values
(1,"Scribner","USA"),
(2,"Harper & Brothers","CANADA"),
(3,"Penguin Books","UK"),
(4,"Little, Brown & Co.","USA"),
(5,"Oxford University Press","RUSSIA");

-- 1.select all col from book table
SELECT*FROM book;

-- 2.select all col from genres table
SELECT*FROM genres;

-- 3.select all col from authors table
SELECT*FROM authors;

-- 4.select all col from publishers table
SELECT*FROM publishers;

-- 5.select only title and price columns from book table
SELECT title,price
FROM book;

-- select all authors from author table where country is usa
SELECT NAME as author_name
FROM authors
WHERE country="usa";

-- 6.Select all publishers from the Publishers table where the country is "UK."
SELECT publisher_name
FROM publishers
WHERE country="uk";

-- 7.select all books that were published after the year 1950.
SELECT title as books_published,year_published
FROM book
WHERE year_published>1950;

-- 8.Select books with a price greater than 15.
SELECT*FROM book
WHERE price>15;

-- 9.Select books where the year_published is between 1900 and 2000.
select*from book
where year_published between 1900 and 2000;

-- 10.Select all books ordered by the year_published in ascending order.  
select*from book
order by year_published asc;

-- 11.Select authors who were born after 1900.
SELECT NAME ,birth_year
FROM authors
WHERE birth_year>1900;

-- 12.Select books where the price is not null.
SELECT*FROM book
WHERE price is not NULL;

-- 13.Select all books, ordered by price in descending order. 
SELECT*FROM book
ORDER BY price DESC;

-- 14.Select all authors, ordered by birth_year in ascending order.
SELECT*FROM authors
ORDER BY birth_year ASC; 

-- 15.Count the total number of books in the Books table. 
SELECT COUNT(*)  AS total_books
FROM BOOK;

-- 16.Find the average price of all books in the Books table
SELECT AVG(price) AS avgerage_price
from book;

-- 17.Get the maximum and minimum price of books
SELECT MAX(price) AS max_price,MIN(price) AS mini_price
FROM book;

-- 18.Find the total number of books published before 1900.
SELECT COUNT(*) AS total_books_published
FROM book
WHERE year_published<1900;

-- 19.Get books by a specific author("Jane Austen")
SELECT*FROM book
WHERE author_id=(SELECT author_id
FROM authors
WHERE name="Jane Austen");

-- 20.Get books published by a specific publisher("Harper & Brothers")
SELECT*FROM book
WHERE publisher_id=(SELECT publisher_id
FROM publishers
WHERE publisher_name="Harper & Brothers");

-- 21.Get books of a specific genre("Adventure")
SELECT*FROM book
WHERE genre_id=(SELECT genre_id
FROM genres
WHERE genre_name="adventure");

-- 22.Get books sorted by title alphabetically
SELECT*FROM book
ORDER BY title;

-- 23.Get the number of books published each year
SELECT year_published,COUNT(*) AS book_count
FROM book
GROUP BY year_published
ORDER BY year_published DESC;

-- 24.Get books with titles starting with "T"
SELECT*FROM book
WHERE title LIKE 'T%';

-- 25.Get the first 5 books from the database
SELECT*FROM book 
LIMIT 5;

-- 26.Get books with prices between $10 and $15
SELECT*FROM book
WHERE price BETWEEN 10 AND 15;

-- 27.Get the average year_published for books in the "Drama" genre
SELECT AVG(year_published) AS avg_year_published
FROM book
WHERE genre_id = (
    SELECT genre_id
    FROM genres
    WHERE genre_name = 'Drama');

SET SQL_SAFE_UPDATES=0;

-- 28.Update the price of a specific book
UPDATE book
SET price=10
WHERE book_id=4;

UPDATE book
SET price=price+5;

-- 29.Update the publisher of a book
UPDATE book
SET publisher_id=(SELECT publisher_id
FROM publishers 
WHERE publisher_name="penguin books")
WHERE book_id=3;

-- 30.Get books that have a price higher than the average price
SELECT*FROM book
WHERE price>(SELECT AVG(price)
FROM book);

-- 31.Get books by authors from a specific country("USA")
SELECT title
FROM book
WHERE author_id IN(SELECT author_id
FROM authors
WHERE country="usa");

-- 32.Get books published after the latest book published
SELECT*FROM book
WHERE year_published>(SELECT MAX(year_published)
FROM book);

-- 33.Find the author who wrote the cheapest book.
SELECT name
FROM authors
WHERE author_id=(SELECT author_id
FROM book
WHERE price=(SELECT MIN(price)
FROM book)
);

-- 34.Find the publisher with the most books published
SELECT publisher_name
FROM publishers
WHERE publisher_id=(SELECT publisher_id
FROM book
GROUP BY publisher_id
ORDER BY count(*) DESC
LIMIT 1);

-- 35.Find the authors who have written more than one book.
SELECT name
FROM authors
WHERE author_id IN(SELECT author_id
FROM book
GROUP BY author_id
HAVING count(book_id)>1
);

-- 36.Get the count of books for each genre.
SELECT genre_id,COUNT(*) AS num_of_books
FROM book 
GROUP BY genre_id;

-- 37.Select all distinct genres from the Books table
SELECT DISTINCT genre_id AS distinct_genres
FROM book;

-- 38.Select the first 5 books ordered by price
SELECT*FROM book
ORDER BY price
LIMIT 5;

-- 39.Find books written by authors born after 1900
SELECT*from book
WHERE author_id IN(SELECT author_id
FROM authors
WHERE birth_year>1900);

-- 40.Find the publishers that have more than 2 books published.
SELECT publisher_name
FROM publishers                                           
WHERE publisher_id IN(
SELECT publisher_id
FROM book
GROUP BY publisher_id
HAVING count(*)>2
);

-- 41.Find the book with the highest price in the Books table 
SELECT*FROM book
WHERE price=(
SELECT max(price)
from book);

-- 42.List all books along with their author's name 
SELECT book.title, authors.name AS author_name
FROM book
INNER JOIN authors
ON book.author_id = authors.author_id;

-- 43.List all books with their publisher’s name 
SELECT book.title, publishers.publisher_name
FROM book
INNER JOIN publishers
ON book.publisher_id=publishers.publisher_id;

-- 44.List all books along with their genre name 
SELECT book.title, genres.genre_name
FROM book
INNER JOIN genres
ON book.publisher_id=genres.genre_id;

-- 45.Find authors who have written books for the publisher "Penguin Books"
SELECT DISTINCT authors.name AS author_name
FROM book
JOIN authors ON book.author_id = authors.author_id
JOIN publishers ON book.publisher_id = publishers.publisher_id
WHERE publishers.publisher_name = 'Penguin Books';

-- 46.Get the details of books and authors for books published by "Harper & Brothers" 
SELECT book.title, authors.name AS author_name, book.year_published, book.price
FROM book
JOIN authors ON book.author_id = authors.author_id
JOIN publishers ON book.publisher_id = publishers.publisher_id
WHERE publishers.publisher_name = 'Harper & Brothers';

-- 47.Find books written by authors born after 1900 and publisher name
SELECT book.title,authors.birth_year,publishers.publisher_name
FROM book
INNER JOIN authors
ON book.author_id=authors.author_id
INNER JOIN Publishers 
ON Book.publisher_id = Publishers.publisher_id
WHERE authors.birth_year>1900;

-- 48.Find the average price of books for each publisher
SELECT publishers.publisher_name,MAX(price) AS max_price
FROM book
INNER JOIN publishers
ON book.publisher_id=publishers.publisher_id
GROUP BY publishers.publisher_name ;

-- 49.Find authors who have written books in both "Fiction" and "Adventure" genres
SELECT authors.name
FROM authors
INNER JOIN book
ON authors.author_id=book.author_id
INNER JOIN genres
ON book.genre_id=genres.genre_id
WHERE genres.genre_name IN ("fiction","adventure")
GROUP BY authors.name
HAVING COUNT(DISTINCT genres.genre_name)=2;

-- 50.Find the publisher with the most books published
SELECT publishers.publisher_name, COUNT(book.book_id) AS book_count
FROM book
JOIN publishers ON book.publisher_id = publishers.publisher_id
GROUP BY publishers.publisher_name
ORDER BY book_count DESC
LIMIT 1;

-- 51.Find the Number of Books Written by Each Author and the Total Price of All Their Books
SELECT authors.name AS author_name,count(book.book_id) AS book_count,SUM(book.price) AS total_price
FROM authors
JOIN book 
ON authors.author_id=book.author_id
GROUP BY author_name;

-- 52.Find Authors Who Have Written Books in the "Adventure" Genre Before 1900
SELECT authors.name AS author_name,book.title AS book_name,book.year_published
FROM authors
JOIN book
ON authors.author_id=book.author_id
JOIN genres
ON book.genre_id=genres.genre_id
WHERE genre_name="adventure" AND year_published<1900;

-- 53.Find Books That Were Published by Publishers Located in a Specific Country("USA")
SELECT book.title AS book_name,publishers.publisher_name 
FROM book
JOIN publishers
ON book.publisher_id=publishers.publisher_id
WHERE publishers.country="usa";

-- 54.Find the Author Who Has Written the Most Expensive Book
SELECT authors.name AS author_name,book.title AS book_name,book.price
FROM authors
JOIN book
ON authors.author_id=book.author_id
WHERE price=(SELECT max(price) FROM book);









