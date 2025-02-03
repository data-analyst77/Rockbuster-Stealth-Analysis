# CTE Common Table Expressions 

## Answering business questions using CTE

### Query to find the top 5 customers from the top 10 cities who’ve paid the highest total amounts to Rockbuster.

WITH top5cust_fromtop10cit_cte AS (
    -- Step 1: Logic for top 5 customers from top 10 cities
    SELECT 
        A.customer_id, 
        A.first_name, 
        A.last_name, 
        D.country, 
        C.city, 
        SUM(P.amount) AS amount
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
        LIMIT 10  -- Get the top 10 cities
    )
    GROUP BY A.customer_id, A.first_name, A.last_name, D.country, C.city
    ORDER BY amount DESC  -- Sort by total amount paid
    LIMIT 5  -- Limit the result to top 5 customers
),
all_customers_cte AS (
    -- Step 2: Logic for total customers by country
    SELECT 
        D.country,
        COUNT(A.customer_id) AS all_customer_count
    FROM customer A
    INNER JOIN address B ON A.address_id = B.address_id
    INNER JOIN city C ON B.city_id = C.city_id
    INNER JOIN country D ON C.country_id = D.country_id
    GROUP BY D.country
)
-- Step 2: Main query
SELECT 
    all_customers_cte.country,
    all_customers_cte.all_customer_count,
    COUNT(top5cust_fromtop10cit_cte.customer_id) AS top_customer_count
FROM all_customers_cte
LEFT JOIN top5cust_fromtop10cit_cte
ON all_customers_cte.country = top5cust_fromtop10cit_cte.country
GROUP BY all_customers_cte.country, all_customers_cte.all_customer_count
HAVING COUNT(top5cust_fromtop10cit_cte.customer_id) > 0
ORDER BY top_customer_count DESC;

