# Joining Tables of Data 

-- 1. Write a query to find the top 10 countries for Rockbuster in terms of customer numbers. 
-- Tip: You’ll have to use GROUP BY and ORDER BY, both of which follow the join.  

/*
Assumptions:
-- 1. Table A = customer
-- 2. Table B = address
-- 3. Table C = city
-- 4. Table D = country
*/
  
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

-- 2. Write a query (with a subquerie) to find the top 5 customers from the top 10 cities who’ve paid the highest total amounts to Rockbuster. 
/*
Key steps:
Step 1: Find the top 10 cities by total amount paid.
Step 2: For each city, find the top 5 customers who paid the most.
Step 3: Use JOIN to get the required customer details (Customer ID, name, etc.).
*/
SELECT 
    A.customer_id, 
    A.first_name, 
    A.last_name, 
    D.country, 
    C.city, 
    SUM(P.amount) AS total_amount_paid
FROM customer A

INNER JOIN payment P ON A.customer_id = P.customer_id  -- Join customer and payment tables
INNER JOIN address B ON A.address_id = B.address_id  -- Join customer and address tables
INNER JOIN city C ON B.city_id = C.city_id  -- Join address and city tables
INNER JOIN country D ON C.country_id = D.country_id  -- Join city and country tables

WHERE C.city IN (
    SELECT C.city  -- Subquery to get the top 10 cities
    FROM city C
    INNER JOIN address B ON C.city_id = B.city_id
    INNER JOIN customer A ON B.address_id = A.address_id
    INNER JOIN payment P ON A.customer_id = P.customer_id
    GROUP BY C.city
    ORDER BY SUM(P.amount) DESC  -- Order cities by total payment
    LIMIT 10  -- Get top 10 cities
)
GROUP BY A.customer_id, A.first_name, A.last_name, D.country, C.city
ORDER BY total_amount_paid DESC  -- Sort by total amount paid
LIMIT 5;  -- Limit the result to top 5 customers


