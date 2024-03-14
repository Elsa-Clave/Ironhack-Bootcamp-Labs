-- LAB7 -----------------------------------
use sakila;
-- ----------------------------------------
-- 1. How many copies of the film _Hunchback Impossible_ exist in the inventory system?
select i.inventory_id, f.film_id, f.title from sakila.inventory i
left join sakila.film f on i.film_id = f.film_id
where f.title = "Hunchback Impossible";

select count(*) as n_copies from sakila.inventory i
left join sakila.film f on i.film_id = f.film_id
where f.title = "Hunchback Impossible";
-- ----------------------------------------
-- 2. List all films whose length is longer than the average of all the films.
select title, length from sakila.film
where length > (select avg(length) from sakila.film);

-- ----------------------------------------
-- 3. Use subqueries to display all actors who appear in the film _Alone Trip_.
select actor_id, first_name, last_name from sakila.actor
where actor_id in (
select actor_id from sakila.film_actor
where film_id = (
select film_id from sakila.film
where title = "Alone Trip")
);

-- ----------------------------------------
/* 4. Sales have been lagging among young families, and you wish to target all family movies for a promotion. 
Identify all movies categorized as family films.*/

select title from sakila.film
where film_id in (
select film_id from sakila.film_category
where category_id = (
select category_id from sakila.category
where name = "Family")
);

-- ----------------------------------------
/* 5. Get name and email from customers from Canada using subqueries. Do the same with joins.
 Note that to create a join, you will have to identify the correct tables with their primary keys and foreign keys, 
 that will help you get the relevant information.*/
 
select first_name, last_name, email from sakila.customer
where address_id in (
select address_id from sakila.address
where city_id in (
select city_id from sakila.city
where country_id in (
select country_id from sakila.country
where country = "Canada")));

select c.first_name, c.last_name, c.email from sakila.customer c
join sakila.address a on c.address_id = a.address_id
join sakila.city ci on a.city_id = ci.city_id
join sakila.country co on ci.country_id = co.country_id
where co.country = 'Canada';
 -- ----------------------------------------
/* 6. Which are films starred by the most prolific actor? 
Most prolific actor is defined as the actor that has acted in the most number of films. 
First you will have to find the most prolific actor and then use that actor_id to find the different films that he/she starred.*/

select actor_id, count(*) as films_count from sakila.film_actor
group by actor_id
order by films_count desc
limit 1;

select f.title from sakila.film f
join sakila.film_actor fa on f.film_id = fa.film_id
where fa.actor_id = (
select actor_id from sakila.film_actor
group by actor_id
order by count(*) desc
limit 1);

-- ----------------------------------------
/* 7. Films rented by most profitable customer. 
You can use the customer table and payment table to find the most profitable customer 
ie the customer that has made the largest sum of payments */

select title from sakila.film 
where film_id in (
select film_id from sakila.inventory 
where inventory_id in (
select inventory_id from sakila.rental 
where customer_id in (
select customer_id from sakila.payment 
group by customer_id 
having customer_id = (select customer_id from sakila.payment
group by customer_id
order by sum(amount) desc
limit 1))));


-- ----------------------------------------
/* 8. Get the `client_id` and the `total_amount_spent` 
of those clients who spent more than the average of the `total_amount` spent by each client. */
select customer_id, sum(amount) as total_amt_spent from sakila.payment 
group by customer_id 
having total_amt_spent > (
select avg(sum_amount) from (
select customer_id, sum(amount) as sum_amount from sakila.payment 
group by customer_id)sub);


-- ----------------------------------------




