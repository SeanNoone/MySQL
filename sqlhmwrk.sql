-- 1
USE sakila;
SELECT * FROM actor;

SELECT concat(UPPER(first_name), ' ', UPPER(last_name)) AS 'Actor Name' FROM actor;

-- 2
SELECT actor_id, first_name, last_name FROM actor
WHERE 
first_name = 'Joe';

SELECT last_name, first_name FROM actor
WHERE
last_name LIKE '%gen%';

SELECT last_name, first_name FROM actor 
WHERE
last_name LIKE '%li%'
ORDER BY last_name, first_name; 

SELECT country_id, country FROM country
WHERE
country in ('Afgahanistan', 'Bangladesh', 'China'); 

-- 3

ALTER TABLE actor
ADD middle_name VARCHAR(30);
SELECT actor_id, first_name, middle_name, last_name, last_update FROM actor;

ALTER TABLE actor
MODIFY middle_name blob;

ALTER TABLE actor
DROP COLUMN middle_name;

-- 4 

SELECT last_name, COUNT(*) from actor
GROUP BY last_name;

SELECT last_name, COUNT(*) from actor
GROUP BY last_name
HAVING Count(last_name) > 2;

UPDATE actor
SET first_name = 'HARPO'
WHERE last_name = 'Williams' and first_name = 'GROUCHO';

SELECT * FROM actor 
WHERE
last_name = 'WIlliams';

UPDATE actor
SET first_name = 'GROUCHO'
WHERE actor_id = 172 AND first_name = 'HARPO';

UPDATE actor 
SET first_name = 'MUCHO GROUCHO'
WHERE actor_id = 172;

-- 5
SHOW CREATE TABLE address;

-- 6
SELECT * FROM staff;
SELECT * FROM address;

SELECT staff.first_name, staff.last_name, address.address
FROM staff
JOIN address ON
staff.address_id = address.address_id;

SELECT staff.staff_id, first_name, staff.last_name,  SUM(payment.amount) AS amount_rung_up
FROM staff
INNER JOIN payment ON
staff.staff_id = payment.staff_id
GROUP BY staff_id;

SELECT * FROM film;
SELECT * FROM film_actor;

SELECT film_actor.film_id, film.title, COUNT(film_actor.actor_id) AS number_of_actors
FROM film
JOIN film_actor ON
film.film_id = film_actor.film_id
GROUP BY film_id;

SELECT * FROM inventory;
SELECT * FROM film;

SELECT COUNT(*)
FROM inventory
WHERE film_id in
					(SELECT film_id
                    from film
					WHERE title = 'Hunchback Impossible');
                    
SELECT * FROM payment;
SELECT * FROM customer;

SELECT customer.customer_id, customer.first_name, customer.last_name, SUM(payment.amount) AS payment_amount
FROM customer 
JOIN payment ON
customer.customer_id = payment.customer_id
GROUP BY customer_id
ORDER BY last_name ASC;

-- 7
SELECT * FROM film;
SELECT * FROM language;

SELECT film_id, title, language_id FROM film
WHERE
(title LIKE 'Q%'
OR
title LIKE 'K%')
AND
language_id IN (
				SELECT language_id
			FROM language
            WHERE name = 'English');
            
-- 7b
SELECT * FROM film_actor;
SELECT * FROM film;
SELECT * FROM actor;

SELECT actor_id, first_name, last_name
FROM actor
WHERE  actor_id IN (
				SELECT actor_id
			FROM film_actor
            WHERE film_id IN (
					SELECT film_id
				FROM film 
                WHERE title = 'Alone Trip')  );
                
-- 7c
SELECT * FROM customer;
SELECT * FROM city;
SELECT * FROM country;
SELECT * FROM address;

SELECT customer.first_name, customer.last_name, customer.email
FROM customer
JOIN address ON
		customer.address_id = address.address_id
				JOIN city ON
					address.city_id = city.city_id
						JOIN country ON 
							city.country_id = country.country_id
									WHERE country.county = 'Canada';

-- 7d
SELECT * FROM film_category;
SELECT * FROM film;
SELECT * FROM category;

SELECT film_id, title
FROM film
WHERE film_id IN (
	SELECT film_id
    FROM film_category
    WHERE category_id  IN(
			SELECT category_id
            FROM cateogry
            WHERE name = 'Family' )  ) ;
            
-- 7e

SELECT * FROM inventory;
SELECT * FROM film;
SELECT * FROM rental;

SELECT inventory.film_id, COUNT(rental.inventroy_id) AS rental_count
FROM inventory
JOIN rental ON
inventory.inventory_id = rental.inventory_id
GROUP BY film_id
ORDER BY rental_count DESC; 

-- 7f
SELECT * FROM payment;
SELECT * FROM customer;

SELECT customer.store_id, SUM(payment.amount) AS total_payment
FROM customer
JOIN payment ON
customer.customer_id = payment.customer_id
GROUP BY store_id;

-- 7g
SELECT * FROM country;
SELECT * FROM city;
SELECT * FROM store;
SELECT * FROM address;

SELECT store.store_id, city.city, country.country
FROM store
		JOIN address ON 
			address.city_id = city.city_id
				JOIN country ON
					city.country_id = country.country_id;
                    
-- 7h
SELECT * FROM renatl;
SELECT * FROM payment;
SELECT * FROM inventory;
SELECT * FROM film_category;
SELECT * FROM category;

SELECT category.name AS film_category, SUM(paymnet.amount) as Gross_sum
FROM category
JOIN film_category ON
		category.category_id = film_category.category_id
			JOIN inventory ON 
				film_category.film_id = inventory.film_id
					JOIN rental ON 
						inventory.inventory_id = rental.inventory_id
							JOIN payment ON
								rental.rental_id = payment.rental_id
                                
GROUP BY name
ORDER BY gross_sum DESC
LIMIT 5;

-- 8a 

CREATE VIEW category_gross_sum
AS
SELECT category.name AS film_category, SUM(payment.amount) as Gross_sum
FROM category
JOIN film_category ON 
	category.category_id = film_category.category_id 
		JOIN inventory ON 
			category.category_id = film_category.category_id
				JOIN rental ON 
					inventory.inventory_id = rental.inventory_id
						JOIN payment ON 
							rental.rental_id = payment.rental_id
                            
GROUP BY name
ORDER BY gross_sum DESC
LIMIT 5;

SELECT * FROM category_gross_sum;

DROP VIEW category_gross_sum;


			
            
            
            
            
            
            
            
            
            






















































                    
				

