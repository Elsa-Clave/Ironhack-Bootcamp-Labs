-- LAB 6-------------------------------------------------------
-- ------------------------------------------------------------
use sakila;

-- 1. Rank films by length (filter out the rows with nulls or zeros in length column). Select only columns title, length and rank in your output.
select title, length,
rank() over (order by length) as "rank"
from sakila.film
where length <> " " or 0;

-- Con rank() el ranking tiene "brechas" (según el nº de filas) en las particiones, con dense_rank() assigna el ranking a cada fila sin "brecha"
select title, length,
dense_rank() over (order by length) as "rank"
from sakila.film
where length <> " " or 0;

-- -------------------------------------------------------------
/* 2. Rank films by length within the `rating` category (filter out the rows with nulls or zeros in length column). 
In your output, only select the columns title, length, rating and rank. */
select title, length, rating,
dense_rank() over (partition by rating order by length) as "rank"
from sakila.film
where length is not null and length > 0;

-- ------------------------------------------------------------        
/* 3. How many films are there for each of the categories in the category table? 
**Hint**: Use appropriate join between the tables "category" and "film_category". */
select c.category_id, c.name as "category_name", count(fc.film_id) as "film_count"
from sakila.film_category fc
left join sakila.category c on fc.category_id = c.category_id
group by c.category_id, c.name;


-- ------------------------------------------------------------
/* 4. Which actor has appeared in the most films? 
**Hint**: You can create a join between the tables "actor" and "film actor" and count the number of times an actor appears. */

select a.actor_id, a.first_name, a.last_name, count(*) as "appearences"
from sakila.film_actor as fa
left join sakila.actor a on fa.actor_id = a.actor_id
group by a.actor_id, a.first_name, a.last_name
order by appearences desc;

-- ------------------------------------------------------------
/* 5. Which is the most active customer (the customer that has rented the most number of films)? 
**Hint**: Use appropriate join between the tables "customer" and "rental" and count the `rental_id` for each customer. */
select c.customer_id, c.first_name, c.last_name, count(*) as "rentals"
from sakila.rental r
left join sakila.customer c on r.customer_id = c.customer_id
group by c.customer_id, c.first_name, c.last_name
order by rentals desc;


-- -----------------------------------------------------------
-- 6. List the number of films per category.
select c.name as "category_name", count(fc.film_id) as "film_count"
from sakila.film_category fc
left join sakila.category c on fc.category_id = c.category_id
group by c.category_id, c.name;

-- ------------------------------------------------------------
-- 7. Display the first and the last names, as well as the address, of each staff member.
select s.first_name, s.last_name, a.address, a.district
from sakila.staff s
join sakila.address a on s.address_id = a.address_id;


-- -------------------------------------------------------------
-- 8. Display the total amount rung up by each staff member in August 2005.
select p.staff_id, s.first_name, s.last_name, sum(p.amount) as "total_amount"
from sakila.payment p
left join sakila.staff s on p.staff_id = s.staff_id
where month(p.payment_date) = 8 and year(p.payment_date) = 2005
group by p.staff_id, s.first_name, s.last_name;



-- ---------------------------------------------------------------
-- 9. List all films and the number of actors who are listed for each film.
select f.film_id, f.title, count(fa.actor_id) as "actor_count"
from sakila.film f
left join sakila.film_actor fa on f.film_id = fa.film_id
group by f.film_id, f.title;


-- ----------------------------------------------------------------
/* 10. Using the payment and the customer tables as well as the JOIN command, list the total amount paid by each customer. 
List the customers alphabetically by their last names. */
select cu.customer_id, cu.first_name, cu.last_name, sum(p.amount) as "amount_payed"
from sakila.customer cu
left join sakila.payment p on cu.customer_id = p.customer_id
group by cu.customer_id, cu.first_name, cu.last_name
order by cu.last_name;

-- ---------------------------------------------------------------
-- 11. Write a query to display for each store its store ID, city, and country.
select s.store_id, ct.city, co.country
from sakila.store s
join sakila.address a on s.address_id = a.address_id
join sakila.city ct on a.city_id = ct.city_id
join sakila.country co on ct.country_id = co.country_id;

-- -----------------------------------------------------------------
-- 12. Write a query to display how much business, in dollars, each store brought in.
select s.store_id, sum(p.amount) as "amnt_in_dollars"
from sakila.payment p
left join sakila.staff s on p.staff_id = s.staff_id
group by s.store_id;
-- -----------------------------------------------------------------
-- 13. What is the average running time of films by category?
select c.name as "category_name", avg(f.length) as "avg_length"
from sakila.film f
join sakila.film_category fc on f.film_id = fc.film_id
join sakila.category c on fc.category_id = c.category_id
group by category_name;
-- ------------------------------------------------------------------
-- 14. Which film categories are longest?
select c.name as "category_name", avg(f.length) as "avg_length"
from sakila.film f
join sakila.film_category fc on f.film_id = fc.film_id
join sakila.category c on fc.category_id = c.category_id
group by category_name
order by avg_length desc
limit 10;
-- ------------------------------------------------------------------
-- 15. Display the most frequently rented movies in descending order.
select f.title, count(r.rental_id) as "rental_count"
from sakila.film f 
join sakila.inventory i on f.film_id = i.film_id
join sakila.rental r on i.inventory_id = r.inventory_id
group by f.title
order by rental_count desc;

-- ------------------------------------------------------------------
-- 16. List the top five genres in gross revenue in descending order.
select c.name, sum(p.amount) as "total_revenue"
from sakila.category c
join sakila.film_category fc on c.category_id = fc.category_id
join sakila.inventory i on fc.film_id = i.film_id
join sakila.rental r on i.inventory_id = r.inventory_id
join sakila.payment p on r.customer_id = p.customer_id
group by c.name
order by total_revenue desc
limit 5;
-- -------------------------------------------------------------------
-- 17. Is "Academy Dinosaur" available for rent from Store 1?
select f.title, s.store_id
from sakila.film f 
join sakila.inventory i on f.film_id = i.film_id
join sakila.store s on i.store_id = s.store_id
where f.title = "Academy Dinosaur" and s.store_id = 1;


-- -------------------------------------------------------------------
