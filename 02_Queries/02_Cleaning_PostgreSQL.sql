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

--Clean for duplicate data (if there were duplicates).
--Delete redundant rows. 
DELETE FROM film
WHERE film_id NOT IN (
    SELECT MIN(film_id)
    FROM film
    GROUP BY title, release_year, language_id, rental_duration
);

--Add a unique constraint to prevent future duplicates. 
ALTER TABLE film 
ADD CONSTRAINT unique_film UNIQUE (title, release_year, language_id, rental_duration);

--Add constraint to prevent NULL entries. 
ALTER TABLE film 
ALTER COLUMN title SET NOT NULL;

--Check for non-uniform titles (case-insensitive). 
SELECT LOWER(title) AS normalized_title, 
       COUNT(*) AS non_uniform_count
FROM film
GROUP BY LOWER(title)
HAVING COUNT(*) > 1;
-- No non-uniform entries for title in film table. 

--Cleaning. Standardize names or titles with consistent casing.
UPDATE film
SET title = INITCAP(title); -- Capitalizes the first letter of each word.

--Cleaning. Replace missing values with ‘unkown’.
UPDATE film
SET title = 'Unknown'
WHERE title IS NULL;

--Summary Film for columns where it makes sense.
SELECT 
MIN (release_year) AS earliest_release,
MAX (release_year) AS latest_release, 
AVG (rental_duration) AS avg_rent_duration,
AVG (rental_rate) AS avg_rent_rate,
AVG (replacement_cost) AS avg_replacement_cost,
MODE() WITHIN GROUP (ORDER BY rating) AS modal_rating
FROM film;



