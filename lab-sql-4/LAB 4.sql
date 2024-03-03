use sakila;
-- ---------------------------------------------
-- LAB 4 ---------------------------------------
-- ---------------------------------------------
-- 1. Get film ratings.
select distinct rating from sakila.film;
-- ---------------------------------------------
-- 2. Get release years.
select distinct release_year from sakila.film;
-- ---------------------------------------------
-- 3. Get all films with ARMAGEDDON in the title.
select title from sakila.film
where title regexp "\\barmageddon\\b";
-- ---------------------------------------------
-- 4. Get all films with APOLLO in the title
select title from sakila.film
where title regexp ".*apollo.*";
-- ---------------------------------------------
-- 5. Get all films which title ends with APOLLO.
select title from sakila.film
where title regexp "apollo$";
-- ---------------------------------------------
-- 6. Get all films with word DATE in the title.
select title from sakila.film
where title regexp "\\bdate\\b";
-- ---------------------------------------------
-- 7. Get 10 films with the longest title.
select title from sakila.film
order by length(title) desc
limit 10;
-- ---------------------------------------------
-- 8. Get 10 the longest films.
select title, length from sakila.film
order by length desc
limit 10;
-- ---------------------------------------------
-- 9. How many films include **Behind the Scenes** content?
select title, special_features from sakila.film
where special_features regexp "\\bbehind the scenes\\b";

select count(*) from sakila.film
where special_features regexp "\\bbehind the scenes\\b";
-- 538 films include behind the scenes
-- ---------------------------------------------
-- 10. List films ordered by release year and title in alphabetical order.
select title, release_year from sakila.film
order by release_year, title;
-- ----------------------------------------------

