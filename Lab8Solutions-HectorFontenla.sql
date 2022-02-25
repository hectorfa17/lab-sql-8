#Write a query to display for each store its store ID, city, and country.

SELECT s.store_id, c.city, co.country
FROM store as s
JOIN address as a
ON s.address_id = a.address_id 
JOIN city as c
ON a.city_id = c.city_id
JOIN country as co
ON c.country_id = co.country_id;

#Write a query to display how much business, in dollars, each store brought in.

SELECT s.store_id, count(p.amount) as 'revenue_per_store'
FROM payment as p
JOIN staff as s
ON p.staff_id = s.staff_id
JOIN store as st
ON s.store_id = st.store_id
GROUP BY s.store_id;

#Which film categories are longest?

SELECT 
    c.name, 
    f.length
FROM category as c
JOIN film_category as fc
ON c.category_id = fc.category_id 
JOIN film as f
ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY length DESC;

#Display the most frequently rented movies in descending order.
select f.title, count(f.film_id)  as 'rental_count'
FROM film as f
JOIN inventory as i
ON f.film_id = i.film_id
JOIN rental as r
ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY rental_count DESC;

#List the top five genres in gross revenue in descending order.
select c.name, sum(f.rental_rate) as'revenue'
FROM category as c
JOIN film_category as fc
ON c.category_id = fc.category_id
JOIN film as f
ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY revenue DESC
LIMIT 5;

#Is "Academy Dinosaur" available for rent from Store 1?
select f.title, i.inventory_id, s.store_id, a.address
FROM film as f
JOIN inventory as i
ON f.film_id = i.film_id
JOIN store as s
ON i.store_id = s.store_id
JOIN address as a
ON s.address_id = a.address_id
WHERE f.title = 'ACADEMY DINOSAUR' AND s.store_id = 1;

#For each film, list actor that has acted in more films.
SELECT 
a.actor_id,
a.first_name,
a.last_name,
f.title,
count(f.film_id) over (partition by f.title) as "film_count"
FROM actor as a
JOIN film_actor as fa
ON a.actor_id = fa.actor_id
JOIN film as f
ON fa.film_id = f.film_id;
