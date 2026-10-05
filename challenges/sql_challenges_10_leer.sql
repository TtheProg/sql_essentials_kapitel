/******************************************************************************
*******************************************************************************

SQL CHALLENGES 10

*******************************************************************************
******************************************************************************/


USE publications;


-- 1. What's the difference between highest and lowest price of titles
    
SELECT 
	ROUND(MAX(price) - MIN(price), 2) 
		AS difference_between_prices
FROM titles
;
    
-- 2. Find titles where the total number of books sold is an even number.

SELECT 
	t.title, 
	SUM(s.qty) as total_books,
    SUM(s.qty) % 2 AS Rest_wenn_wir_durch_2_teilen
FROM 
	Titles t
		LEFT JOIN 
	sales s USING(title_id)
GROUP BY t.title_id
HAVING total_books % 2 = 0
ORDER BY total_books DESC;

-- 3. Calculate the total revenue by multiplying the quantity sold by the price for each title.

SELECT 
	t.title,
    ROUND(t.price, 2) AS stueckpreis, 
    SUM(s.qty) AS anz_verkauft,
    ROUND(t.price * SUM(s.qty), 2) 
		AS total_revenue
FROM 
	titles AS t
		LEFT JOIN 
	sales AS s USING (title_id)
GROUP BY t.title_id, t.price
ORDER BY total_revenue DESC;

-- 4. Cheryl Carson and Charlene Locksley got married, what is their collective revenue?

SELECT 
	SUM(t.price * s.qty) AS total_revenue
    /*
    t.title,
	t.price,
    s.ord_num,
    s.qty,
    t.price * s.qty,
    a.au_fname,
    a.au_lname
    */
FROM 
	sales AS s 
		JOIN
	titles AS t USING(title_id)
		JOIN 
	titleauthor ta USING (title_id)
		JOIN
	authors a ON a.au_id = ta.au_id
WHERE 
	(a.au_fname ="Cheryl" AND a.au_lname ="Carson") 
    OR (a.au_fname ="Charlene" AND a.au_lname ="Locksley")
;
    
-- 5. Calculate the total number of books published by the publishers '0736' and '0877':

SELECT 
	pub_id,
	COUNT(*) AS total_books
FROM titles
WHERE 
	pub_id IN ('0736', '0877')
GROUP BY pub_id;

-- 6. Find all of the books that are more than 10% above the average price of a book in the dataset


