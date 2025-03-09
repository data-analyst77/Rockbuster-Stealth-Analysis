# Joining Tables of Data 

-- 1.	Write a query to find the top 10 countries for Rockbuster in terms of customer numbers. (Tip: you’ll have to use GROUP BY and ORDER BY, both of which follow the join.)  

--Top 10 countries by customer number
SELECT 
D.country, 
COUNT (A.customer_id) AS customer_count
FROM customer A
INNER JOIN address B ON A.address_id = B.address_id
INNER JOIN city C ON B.city_id = C.city_id
INNER JOIN country D ON C.country_ID = D.country_ID 
GROUP BY D.country
ORDER BY customer_count DESC 
LIMIT 10;


## Assumptions
1.	Table A=customer
2.	Table B=address
3.	Table C=city
4.	Table D=country

## 2. Write a query to identify the top 10 cities that fall within the top 10 countries you identified in step 1. 

SELECT 
D.country, 
C.city, 
COUNT (A.customer_id) AS customer_count
FROM customer A
INNER JOIN address B ON A.address_id = B.address_id
INNER JOIN city C ON B.city_id = C.city_id
INNER JOIN country D ON C.country_ID = D.country_ID
GROUP BY D.country, C.city

HAVING D.country IN ( 
SELECT D.country 
FROM customer A 
INNER JOIN address B ON A.address_id =B.address_id 
INNER JOIN city C ON B.city_id = C.city_id 
INNER JOIN country D ON C.country_id = D.country_id
GROUP BY D.country 
ORDER BY COUNT(A.customer_id) DESC LIMIT 10 )

ORDER BY customer_count DESC 
LIMIT 10;

