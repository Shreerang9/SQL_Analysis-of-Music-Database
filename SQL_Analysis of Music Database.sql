/*

Explorating Music Database
Skills used - Joins, Concatenate, Aggregation functions, etc.

*/

-- Q1 - Who is the senior most employee based on job title ?
SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name, levels
FROM
    employee
ORDER BY 2 DESC
LIMIT 1;

-- Q2 - Which countries have the most invoices ?
SELECT 
    billing_country, COUNT(*) AS number_of_invoices
FROM
    invoice
GROUP BY 1
ORDER BY 2 DESC;

-- Q3 - What are top 3 values of total invoices ?
SELECT 
    total
FROM
    invoice
ORDER BY total DESC
LIMIT 3;

-- Q4 - Which city has the best customers ?
-- Return both city name and sum of all invoice total.
SELECT 
    billing_city, SUM(total) AS total_invoices
FROM
    invoice
GROUP BY 1
ORDER BY 2 DESC;

-- Q5 - Who is the best customer ? 
-- Write a query that returns the person who has spent the most money.
WITH sum_invoices AS (SELECT 
    i.customer_id, SUM(i.total) AS total_invoice
FROM
    invoice i
GROUP BY i.customer_id
ORDER BY total_invoice DESC
LIMIT 1)

SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS full_name,
    si.total_invoice
FROM
    customer c
        JOIN
    sum_invoices si USING (customer_id);

-- Q6 - Write a query to return the email, first name, last name and 
-- genre of all Rock Music listeners. 
-- Return your list ordered alphabetically by email starting with A.
SELECT DISTINCT
    c.email, c.first_name, c.last_name, g.name
FROM
    customer c
        JOIN
    invoice i USING (customer_id)
        JOIN
    invoice_line il USING (invoice_id)
        JOIN
    track t USING (track_id)
        JOIN
    genre g USING (genre_id)
WHERE
    g.name = 'Rock'
ORDER BY c.email;

-- Q7 Let's invite the artists who have written the most rock music 
-- in our dataset. Write a query that returns the Artist name and 
-- total track count of the top 10 rock bands.
SELECT 
    a.artist_id, a.name, COUNT(a.artist_id) AS number_of_songs
FROM
    track t
        JOIN
    album2 a2 USING (album_id)
        JOIN
    artist a USING (artist_id)
        JOIN
    genre g USING (genre_id)
WHERE
    g.name = 'Rock'
GROUP BY 1
ORDER BY -1 DESC
LIMIT 10;

-- Q8 - Return all the track names that have a song length longer than 
-- the average song length. Return the Name and Milliseconds for each 
-- track. Order by the song length with the longest songs listed first

SELECT 
    name, milliseconds
FROM
    track
WHERE
    milliseconds > (SELECT 
            AVG(milliseconds)
        FROM
            track)
ORDER BY milliseconds DESC;


