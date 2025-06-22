CREATE TABLE shopping_data( 
 customer_id VARCHAR(38) PRIMARY KEY,
 age INT,
 gender VARCHAR(7),
 city VARCHAR(26),
 category VARCHAR(12),
 product_name VARCHAR(11),
 purchase_date DATE,
 purchase_amount INT,
 paymnent_method VARCHAR(18),
 discount_applied VARCHAR(4),
 customer_rating INT,
 repeat_customer VARCHAR(4));


#Data cleaning
ALTER Table shopping_data
DROP COLUMN customer_ID;

ALTER Table shopping_data
RENAME COLUMN paymnent_method to payment_method;

SELECT *
FROM shopping_data;

#Number of CXs based on ages
SELECT age, count(age) as age_group
FROM shopping_data
GROUP BY age
ORDER BY age_group DESC;

#Gender distribution
SELECT gender, count(gender) as gender_dist, round(count(*) * 100.0 / sum(count(*)) over()) as perc_of_shoppers_by_gender
FROM shopping_data
GROUP BY gender
ORDER BY perc_of_shoppers_by_gender;

#Purhase amount per gender
SELECT gender, sum(purchase_amount) as total_spent
FROM shopping_data
GROUP BY gender
ORDER BY total_spent DESC;

#Top 10 Cities that spend the most amount of money
SELECT city, sum(purchase_amount) as total_spent
FROM shopping_data
GROUP BY city
ORDER BY total_spent DESC
LIMIT 10;

SELECT city, count(purchase_amount) as total_spent
FROM shopping_data
GROUP BY city
ORDER BY total_spent DESC
LIMIT 10;

#Which product categories are the most popular overall?
SELECT DISTINCT category, sum(purchase_amount) as total_amount
FROM shopping_data
GROUP BY category
ORDER BY total_amount DESC;

#What are the top-selling products by purchase amount and volume?
SELECT DISTINCT product_name, sum(purchase_amount) as purchase_amount, count(product_name) as purchase_volume
FROM shopping_data
GROUP BY product_name
ORDER BY purchase_amount DESC;

#Are certain categories preferred by certain age groups or genders?
SELECT
    CASE 
        WHEN age BETWEEN 18 AND 25 THEN '18-25'
        WHEN age BETWEEN 26 AND 35 THEN '26-35'
        WHEN age BETWEEN 36 AND 50 THEN '36-50'
        WHEN age > 50 THEN '50+'
        ELSE 'Unknown'
    END AS age_group,
    category,
    COUNT(*) AS purchase_count
FROM shopping_data
GROUP BY age_group, category
ORDER BY age_group, purchase_count DESC;

#How does discount application vary across categories 
SELECT distinct product_name, count(discount_applied) as discounted
FROM shopping_data
WHERE discount_applied = "YES"
GROUP BY product_name
ORDER BY discounted DESC;

SELECT distinct category, count(discount_applied) as discounted
FROM shopping_data
WHERE discount_applied = "YES"
GROUP BY category
ORDER BY discounted DESC;

#How do customer ratings vary by product or category?
SELECT ROUND (AVG(customer_rating), 0) , category
FROM shopping_data
GROUP BY category;

#What is the average purchase amount for repeat and non-repeat customers?
SELECT ROUND (AVG(purchase_amount), 2), repeat_customer
FROM shopping_data
GROUP BY repeat_customer;

#What is the average purchase amount per payment method?
SELECT ROUND (AVG(purchase_amount), 2) as AVG_Amount, payment_method
FROM shopping_data
GROUP BY payment_method;

#What payment method has the highest count and Volume?
SELECT payment_method, SUM(purchase_amount) as Volume, COUNT(purchase_amount) as Count
FROM shopping_data
GROUP BY payment_method
ORDER BY Volume DESC;
