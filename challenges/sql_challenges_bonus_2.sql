/******************************************************************************
*******************************************************************************

SQL CHALLENGES bonus 2

*******************************************************************************
*******************************************************************************/

USE publications;

-- 1. Using LEFT JOIN: in which cities has "Is Anger the Enemy?" been sold?
SELECT 
	t.title, 
    st.city,
    SUM(sa.qty)
FROM
	stores AS st
		LEFT JOIN
	sales AS sa USING(stor_id)
		LEFT JOIN
	titles as t USING(title_id)
WHERE 
	t.title = "Is Anger the Enemy?"
GROUP BY
	st.city
HAVING
	SUM(sa.qty) > 0
;


/* 2. Select all the book titles that have a link to the employee Howard Snyder 
    (he works for the publisher that has published those books). */

SELECT 
    t.title, p.pub_name, e.fname, e.lname
FROM
    titles AS t
        LEFT JOIN
    publishers AS p USING (pub_id)
        LEFT JOIN
    employee AS e USING (pub_id)
WHERE
    e.fname = 'Howard'
        AND e.lname = 'Snyder';

/* 3. Using the JOIN of your choice: Select the book title with highest number of 
   sales (qty) */
SELECT
	t.title, SUM(s.qty) AS total_sales
FROM
	titles AS t
		INNER JOIN
	sales AS s USING (title_id)
GROUP BY
	t.title
ORDER BY total_sales DESC
LIMIT 3;


/* 4. Select all book titles and the full name of their author(s).
      
      - If a book has multiple authors, all authors must be displayed (in 
      multiple rows).
      
      - Books with no authors and authors with no books should not be displayed.
*/

SELECT 
	t.title,
    a.au_fname,
    a.au_lname
FROM
	titles AS t
		INNER JOIN
	titleauthor AS au_ti USING (title_id)
		INNER JOIN
	authors AS a USING (au_id)
;
    



/* 5. Select the full name of authors of Psychology books

   Bonus hint: if you want to prevent duplicates but allow authors with shared
   last names to be displayed, you can concatenate the first and last names
   with CONCAT(), and use the DISTINCT clause on the concatenated names. */

SELECT DISTINCT
	 a.au_fname,
     a.au_lname,
    CONCAT(a.au_fname, a.au_lname),
    t.type
FROM
	titles AS t
		INNER JOIN
	titleauthor AS au_ti USING (title_id)
		INNER JOIN
	authors AS a USING (au_id)
WHERE
	t.type = "psychology"
;
	


/* 6. Explore the table roysched and try to grasp the meaning of each column. 
   The notes below will help:
   
   - "Royalty" means the percentage of the sale price paid to the author(s).
   
   - Sometimes, the royalty may be smaller for the first few sales (which have
     to cover the publishing costs to the publisher) but higher for the sales 
     above a certain threshold.
     
   - In the "roysched" table each title_id can appear multiple times, with
     different royalty values for each range of sales.
     
   - Select all rows for particular title_id, for example "BU1111", and explore
	 the data. */
SELECT * FROM roysched
WHERE title_id = "BU1111";


/* 7. Select all the book titles and the maximum royalty they can reach.
    Display only titles that are present in the roysched table. */
    
SELECT
	t.title,
    t.type,
    MAX(r.royalty) AS max_royalty,
    MIN(r.royalty)
FROM
	titles AS t
		RIGHT JOIN
	roysched AS r USING (title_id)
GROUP BY
	t.title_id
ORDER BY
	max_royalty
    ;
