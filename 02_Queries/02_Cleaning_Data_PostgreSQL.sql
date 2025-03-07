--Check for full duplicates based on 4 columns in film

SELECT title, 
       release_year, 
       language_id, 
       rental_duration, 
       COUNT(*) AS duplicate_count
FROM film
GROUP BY title, release_year, language_id, rental_duration
HAVING COUNT(*) > 1;
--No duplicates in film table found.  

