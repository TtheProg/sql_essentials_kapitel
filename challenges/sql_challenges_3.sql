/*
*******************************************************************************
*******************************************************************************

SQL CHALLENGES 3

*******************************************************************************
*******************************************************************************

In the exercises below you will need to use the following clauses/operators:
	- ORDER BY
	- LIMIT
    - MIN(), MAX()
    - COUNT(), AVG(), SUM()

In SQL we can have many databases, they will show up in the schemas list
We must first define which database we will be working with.
*/

USE publications;

/******************************************************************************
ORDER BY
******************************************************************************/
-- https://www.w3schools.com/sql/sql_orderby.asp

/* 1. Select the title and ytd_sales from the table titles. Order them by the
year to date sales. */

SELECT 
    title, ytd_sales
FROM
    titles
ORDER BY ytd_sales;


-- 2. Repeat the same query, but this time sort the titles in descending order
SELECT 
    title, ytd_sales
FROM
    titles
ORDER BY ytd_sales DESC;


/******************************************************************************
LIMIT

https://www.w3schools.com/mysql/mysql_limit.asp
******************************************************************************/

-- 3. Select the top 5 titles with the most ytd_sales from the table titles
SELECT 
    title, ytd_sales
FROM
    titles
ORDER BY ytd_sales DESC
LIMIT 5;


/******************************************************************************
MIN and MAX

https://www.w3schools.com/sql/sql_min_max.asp
******************************************************************************/

-- 4. What's the maximum amount of books ever sold in a single order?
SELECT 
    MAX(qty) AS max_books_sold
FROM
    sales;


-- 5. What's the price of the cheapest book?
SELECT 
    MIN(price) AS cheapest_price
FROM
    titles;
    
SELECT
	title, price
FROM
	titles
WHERE price IS NOT NULL
ORDER BY price ASC
LIMIT 1;


/******************************************************************************
COUNT, AVG, and SUM

https://www.w3schools.com/sql/sql_count_avg_sum.asp

******************************************************************************/

 -- 6. How many rows are there in the table authors?
SELECT 
    COUNT(*) AS num_authors
FROM
    authors;


 -- 7. What's the total amount of year-to-date sales?
SELECT 
    SUM(ytd_sales) AS total_sales_per_year       
FROM
    titles;


 -- 8. What's the average price of books?
SELECT 
	AVG(price) AS average_price
FROM
	titles;


/* 9. In a single query, select the count, average and sum of quantity in the
table sales */

SELECT
	COUNT(qty) AS AnzahlBestellungen, 
    AVG(qty) AS Durchschn_bestellungsgröße,
    SUM(qty) AS insgesamt_verkauft
FROM
	sales;

/*
In the exercises below you will need to use the following clauses/operators:
	- SELECT FROM
    - AS
	- DISTINCT
	- WHERE
	- AND / OR / NOT
	- ORDER BY
	- LIMIT
    - MIN(), MAX()
    - COUNT(), AVG(), SUM()

*/

-- 10. From how many different states are our authors?
SELECT 
	COUNT(DISTINCT state) AS staaten
FROM 
	authors;


-- 11. How many publishers are based in the USA?

SELECT
	COUNT(DISTINCT pub_name) AS num_punlishers
FROM
	publishers
WHERE 
    country = "USA"
    ;
	


-- 12. What's the average quantity of titles sold per sale by store 7131?
SELECT 
	AVG(qty)
FROM
	sales
WHERE
	stor_id=7131
    ;


-- 13. When was the employee with the highest level hired?
SELECT 
    fname, lname, hire_date
FROM
    employee
ORDER BY
	job_lvl DESC
LIMIT 1
;


-- 14. What's the average price of psychology books?
SELECT
	AVG(price) AS durchschnitts_preis
FROM
	titles
WHERE
	type = "psychology";


-- 15. Which category of books has had more year-to-date sales, "business" or
-- "popular_comp"? You can write two queries to answer this question.

-- business
SELECT
	SUM(ytd_sales) as business_verkaufszahlen
FROM
	titles
WHERE
	type = "business";

-- popular_comp
SELECT 
    SUM(ytd_sales) AS popular_comp_verkaufszahlen
FROM
    titles
WHERE
    type = 'popular_comp';

-- Ergebnis: business_verkaufszahlen: '30788' und popular_comp_verkaufszahlen: '12875'


-- 16. What's the title and the price of the most expensive book?
SELECT 
    title, price
FROM
    titles
ORDER BY price DESC
LIMIT 1;


-- 17. What's the price of the most expensive psychology book?
SELECT 
    title, price
FROM
    titles
WHERE 
	type = "psychology"
ORDER BY price DESC
LIMIT 1;


-- 18. How many authors live in either San Jose or Salt Lake City
SELECT 
    COUNT(*) AS num_living_in_SJ_or_SLC
FROM
    authors
WHERE
    city = 'San Jose'
        OR city = 'Salt Lake City'
;
