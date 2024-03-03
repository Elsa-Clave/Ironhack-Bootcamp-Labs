-- ----------------------------------------
-- LAB 3 ----------------------------------
use sakila;
-- ----------------------------------------
-- 1. How many distinct (different) actors' last names are there?
select distinct last_name from sakila.actor;
select count(distinct last_name) from sakila.actor;
-- there are 121 different last names
-- ----------------------------------------
-- 2. In how many different languages where the films originally produced? (Use the column `language_id` from the `film` table)
select distinct language_id from sakila.film;
-- only one language
-- ----------------------------------------
-- 3. How many movies were released with `"PG-13"` rating?
select count(rating) from sakila.film
where rating = "PG-13";
-- 223 movies with rating PG-13
-- ----------------------------------------
-- 4. Get 10 the longest movies from 2006.
select title, release_year, length from sakila.film
order by length desc
limit 10;
-- ----------------------------------------
-- 5. How many days has been the company operating (check `DATEDIFF()` function)?
select date(rental_date) as date_only
from sakila.rental
order by rental_date desc;
-- last day registered 2006-02-14

select date(rental_date) as date_only
from sakila.rental
order by rental_date asc;
-- first day registered 2005-05-24

select datediff('2006-02-14', '2005-05-24');
-- 266 days operating
-- ----------------------------------------
-- 6. Show rental info with additional columns month and weekday. Get 20.
select rental_id, rental_date, customer_id, month(convert(rental_date,date)) as rental_month from sakila.rental;
select month(convert(rental_date,date)) as rental_month from sakila.rental;
-- checking how to retreive only the month

select rental_id, rental_date, customer_id, 
       case 
           when rental_month = 1 then "January"
           when rental_month = 2 then "February"
           when rental_month = 3 then "March"
           when rental_month = 4 then "April"
           when rental_month = 5 then "May"
           when rental_month = 6 then "June" 
           when rental_month = 7 then "July"
           when rental_month = 8 then "August"
           when rental_month = 9 then "September"
           when rental_month = 10 then "October"
           when rental_month = 11 then "November"
           when rental_month = 12 then "December"
       end as month_rental
 from (select rental_id, rental_date, customer_id, 
 month(convert(rental_date, date)) as rental_month from sakila.rental) as subquery_alias
 limit 20;
-- trying to use CASE (too long)

select rental_id, rental_date, customer_id, 
       monthname(rental_date) as month_name,
       dayname(rental_date) as rental_weekday
from sakila.rental
limit 20;
-- there is a simpler way with monthname() and dayname()
-- ----------------------------------------
-- 7. Add an additional column `day_type` with values 'weekend' and 'workday' depending on the rental day of the week.
select rental_id, rental_date, customer_id, 
       monthname(rental_date) as month_name,
       dayname(rental_date) as rental_weekday,
case 
	when dayofweek(rental_date) in (1,7) then "weekend"
	else "workday"
end as day_type
from sakila.rental
limit 20;
-- ----------------------------------------
-- 8. How many rentals were in the last month of activity?
select rental_date from sakila.rental
order by  rental_date desc; 
-- last month of activity was february (02) of 2006: 
select count(*) from sakila.rental
where month(rental_date) = 2 and year(rental_date) = 2006;
-- 182 rentals
-- -------------------------------------------------------




