# Joining Tables of Data 

-- 1. Write a query to find the top 10 countries for Rockbuster in terms of customer numbers. 
-- Tip: You’ll have to use GROUP BY and ORDER BY, both of which follow the join.  

## Assumptions:
-- 1. Table A = customer
-- 2. Table B = address
-- 3. Table C = city
-- 4. Table D = country

-- Top 10 countries by customer number
SELECT D.country, COUNT(A.customer_id) AS customer_count
FROM customer A

-- Joining customer to address (Assuming each customer has one address)
INNER JOIN address B ON A.address_id = B.address_id 

-- Joining address to city (Each address belongs to a city)
INNER JOIN city C ON B.city_id = C.city_id 

-- Joining city to country (Each city belongs to a country)
INNER JOIN country D ON C.country_ID = D.country_ID 

-- Grouping by country to count customers per country
GROUP BY D.country

-- Ordering in descending order to show countries with the most customers first
ORDER BY customer_count DESC

-- Limiting to the top 10 countries
LIMIT 10;


