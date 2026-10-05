/******************************************************************************
*******************************************************************************

SQL CHALLENGES 10

*******************************************************************************
******************************************************************************/


USE publications;


-- 1. What's the difference between highest and lowest price of titles

SELECT
	MAX(price), MIN(price),
	MAX(price) - MIN(price)
FROM
	titles
;
    
-- 2. Find titles where the total number of books sold is an even number.

SELECT
	title, ytd_sales
FROM
	titles
WHERE
	ytd_sales % 2 = 0;

-- 3. Calculate the total revenue by multiplying the quantity sold by the price for each title.

SELECT	
	t.title, 
    t.price, 
    t.ytd_sales, 
    ROUND(t.price * t.ytd_sales, 2) AS total_revenue,
    (
		SELECT SUM(s.qty) * t.price
        FROM
			sales s
        WHERE
			s.title_id = t.title_id
    ) as total_revenue
FROM
	titles t
;

--

SELECT
	t.title, SUM(s.qty), t.ytd_sales, SUM(s.qty * t.price), t.ytd_sales * t.price
FROM
	titles t
		JOIN
	sales s USING(title_id)
GROUP BY
	t.title_id
    ;

-- 4. Cheryl Carson and Charlene Locksley got married, what is their collective revenue?


SELECT 
    (SELECT  
		ROUND(SUM(t1.price * t1.ytd_sales), 2)
	FROM
		authors a1
		JOIN titleauthor ta1 USING (au_id)
		JOIN titles t1 USING (title_id)
		
	WHERE
		a1.au_fname = "Cheryl"
	)
    + 
    (SELECT  
		ROUND(SUM(t1.price * t1.ytd_sales), 2)
	FROM
		authors a1
		JOIN titleauthor ta1 USING (au_id)
		JOIN titles t1 USING (title_id)
	WHERE
		a1.au_fname = "Charlene"
	) AS both_together,
    (SELECT  
		ROUND(SUM(t1.price * t1.ytd_sales), 2)
	FROM
		authors a1
		JOIN titleauthor ta1 USING (au_id)
		JOIN titles t1 USING (title_id)
		
	WHERE
		a1.au_fname = "Cheryl"
	) AS Cheryl
    ,
    (SELECT  
		ROUND(SUM(t1.price * t1.ytd_sales), 2)
	FROM
		authors a1
		JOIN titleauthor ta1 USING (au_id)
		JOIN titles t1 USING (title_id)
	WHERE
		a1.au_fname = "Charlene"
	) AS Charlene;

    
-- 5. Calculate the total number of books published by the publishers '0736' and '0877':

SELECT
	(SELECT
		SUM(ytd_sales)
	FROM
		titles
	WHERE
		pub_id = 0736
    ) AS books_by_PUB0736
    ,
	(SELECT
		SUM(ytd_sales)
	FROM
		titles
	WHERE
		pub_id = 0877
    ) AS books_by_PUB0877
    , -- books_by_PUB0736 +  books_by_PUB0877
	(SELECT
		SUM(ytd_sales)
	FROM
		titles
	WHERE
		pub_id = 0736
    ) 
    +
	(SELECT
		SUM(ytd_sales)
	FROM
		titles
	WHERE
		pub_id = 0877
    ) AS sum_of_0736_and_0877;

-- kleiner vergleich LIKE und =
SELECT * FROM publishers
WHERE pub_id  =   0736;         -- Publisher "New Moon Books" gefunden
SELECT * FROM publishers
WHERE pub_id  =   "0736";       -- Publisher "New Moon Books" gefunden

SELECT * FROM publishers
WHERE pub_id LIKE "0736";       -- Publisher "New Moon Books" gefunden

SELECT * FROM publishers
WHERE pub_id  =   "0736      "; -- Publisher "New Moon Books" gefunden 

SELECT * FROM publishers
WHERE pub_id LIKE "0736      "; -- X findet den Publisher "New Moon Books" nicht, wegen Leerzeichen am ende


-- 6. Find all of the books that are more than 10% above the average price of a book in the dataset

SELECT
	AVG(price)
FROM
	titles AS avg_price
    ;


SELECT 
    title, price
FROM
    titles
WHERE
    price > 1.1 * (
		SELECT 
            AVG(price)
        FROM
            titles AS avg_price
            )
;






