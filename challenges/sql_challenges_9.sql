/******************************************************************************
*******************************************************************************

SQL CHALLENGES 9

*******************************************************************************
******************************************************************************/


USE publications;


-- 1. Add a column showing how many characters are in each author's last name

SELECT
	a.au_fname,
    a.au_lname,
    LENGTH (a.au_lname) AS lname_length
FROM
	authors a;


-- 2. What is the first name of each author in uppercase?

SELECT
	UPPER(a.au_fname)
FROM
	authors a;

-- 3. Combine first and last names of authors into a single column.

SELECT
	CONCAT(au_fname, " ", au_lname) AS full_name
FROM authors;

-- 4. Show the current date in a column called 'today'.

SELECT
	CURRENT_DATE() as today_is;
	
-- 5. Calculate the difference in days between a book's publication date and today's date.

SELECT
	DATEDIFF(CURRENT_DATE(), t.pubdate)
FROM
	titles t;

-- 6. How many years has it been since each title was published?
    
SELECT
	t.title, TIMESTAMPDIFF(YEAR, t.pubdate, CURRENT_DATE()) AS years_since_pub
FROM
	titles t;
    
-- 7. Find the publication year and month of each title in 'YYYY-MM' format.   

SELECT
	t.title, DATE_FORMAT( t.pubdate , "%Y-%m") AS date_publish
FROM
	titles t;


-- 8. Concatenate the publisher's name and city into a single column. Separate them with a comma.

SELECT
	CONCAT ( p.pub_name, ", ", p.city) AS all_publishers
FROM
	publishers p;


-- 9. What is the longest title of a book?

SELECT
	MAX(LENGTH(title)) AS longest_title
FROM
	titles;

-- 10. Display the publication date of each title in 'Day-Month-Year' format. For example, '12-June-1991'.
    
SELECT
	t.title, DATE_FORMAT (t.pubdate, "%d-%M-%Y") AS published_on
FROM
	titles t;
    
    
-- 11. List authors whose last name starts with 'C' and show the first 5 characters of their address.
    
SELECT
	a.au_fname, a.au_lname, SUBSTRING(a.address, 1, 5)
FROM
	authors a
WHERE
	-- SUBSTRING(a.au_lname, 1, 1) = "B"
	-- 	OR
    a.au_lname LIKE"C%"
    ;

-- 12. Return the difference in days between the current date and the publication date of titles where the difference is greater than 1000 days.

SELECT
	TIMESTAMPDIFF(DAY, CURRENT_DATE(), t.pubdate) AS days_ago
FROM
	titles t
WHERE
	DATEDIFF(CURRENT_DATE(), t.pubdate) > 1000;

-- 13. Find the titles where the length of the title name is greater than the average length of all titles.

SELECT
	t.title,
    LENGTH(t.title) AS length
FROM
	titles t
WHERE
	LENGTH(t.title) > (
		SELECT
			AVG(LENGTH(t2.title))
		FROM
			titles t2
    
    );
    
SELECT
			AVG(LENGTH(t2.title))
		FROM
			titles t2;

-- 14. Get the authors whose first name length is equal to their last name length.
    
SELECT
	a.au_fname,
    a.au_lname,
    LENGTH(a.au_fname),
    LENGTH(a.au_lname)
FROM
	authors a
WHERE
	LENGTH(a.au_fname) = LENGTH(a.au_lname)
;


-- 15. Find the longest city name among the authors' addresses.

SELECT DISTINCT
	a.city, LENGTH(a.city)
FROM
	authors a
ORDER BY
	LENGTH(a.city) DESC
LIMIT 1
;


-- 16. Display titles and their publication dates formatted as 'Day of the Week, Month Day, Year'. For example, 'Wednesday, June 12, 1991'.
    
SELECT
	t.title,
    t.pubdate,
    DATE_FORMAT(t.pubdate,"%W, %M %d, %Y") AS formatted_date
FROM
	titles t
;

-- 17. Calculate the difference in days between the first and last publication date for each author.

SELECT
	a.au_fname, a.au_lname, 
    MAX(t.pubdate) AS min_date,
    MIN(t.pubdate) AS max_date, 
    DATEDIFF(MAX(t.pubdate), MIN(t.pubdate)) AS diff
FROM
	titles t
		JOIN
	titleauthor ta USING (title_id)
		JOIN
	authors a ON ta.au_id = a.au_id
GROUP BY
	a.au_id
;