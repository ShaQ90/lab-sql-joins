USE sakila;

-- Write SQL queries to perform the following tasks using the Sakila database:

-- List the number of films per category.

SELECT fc.category_id as Category_id, count(f.film_id) as Number_films from sakila.film_category as fc
JOIN sakila.film as f
WHERE fc.film_id = f.film_id
GROUP BY fc.category_id;

-- Retrieve the store ID, city, and country for each store.

SELECT s.store_id, ci.city, co.country from sakila.store as s
JOIN sakila.address as a
ON s.address_id =  a.address_id
JOIN sakila.city as ci
ON a.city_id = ci.city_id
JOIN country as co
on ci.country_id = co.country_id;

-- Calculate the total revenue generated by each store in dollars.

SELECT s.store_id as Store, SUM(p.amount) as total_revenue FROM sakila.store as s
JOIN sakila.staff as st
ON s.store_id = st.store_id
JOIN sakila.payment as p
ON st.staff_id = p.staff_id
GROUP BY s.store_id;


-- Determine the average running time of films for each category.

SELECT c.category_id as Category, AVG(f.length) as "Average(Length)" FROM sakila.category as c
JOIN sakila.film_category as fc
ON c.category_id = fc.category_id
JOIN sakila.film as f
ON fc.film_id = f.film_id
GROUP BY c.category_id
ORDER BY "Average(Length)";

-- Bonus:

-- Identify the film categories with the longest average running time.

SELECT c.name as Category, AVG(f.length) as "Average(Length)" FROM sakila.category as c
JOIN sakila.film_category as fc
ON c.category_id = fc.category_id
JOIN sakila.film as f
ON fc.film_id = f.film_id
GROUP BY c.category_id
ORDER BY c.category_id DESC;

-- Display the top 10 most frequently rented movies in descending order.

SELECT f.title as Movie FROM sakila.film as f
JOIN sakila.inventory as i
ON f.film_id = i.film_id
JOIN sakila.rental as r
on i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY f.title  DESC 
LIMIT 10;


-- Determine if "Academy Dinosaur" can be rented from Store 1.

SELECT f.title as Movie, CASE 
WHEN LENGTH(f.title = "Academy Dinosaur" and i.store_id = 1) > 0 THEN "YES"
ELSE "NO" 
END AS 'Can be rented?' FROM sakila.film as f
JOIN sakila.inventory as i
ON f.film_id = i.film_id
WHERE f.title = "Academy Dinosaur" and i.store_id = 1
GROUP BY f.title;



-- Provide a list of all distinct film titles, along with their availability status in the inventory. Include a column indicating whether each title is 'Available' or 'NOT available.' Note that there are 42 titles that are not in the inventory, and this information can be obtained using a CASE statement combined with IFNULL."
SELECT DISTINCT f.title as Movie, CASE 
WHEN IFNULL(i.inventory_id,0) = 0 THEN "NOT available"
ELSE "Available" 
END AS 'Status' 
FROM sakila.film as f
LEFT JOIN sakila.inventory as i
ON f.film_id = i.film_id;


