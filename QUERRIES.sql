SELECT * FROM customer LIMIT 5;

-- TOTAL REVENUE GENERATED B Y MALE vs FEMALE ?
SELECT gender, SUM(purchase_amount) as revenue FROM customer GROUP BY gender; 

-- Which Customer used Discount but still spent more than an average purchase amount ?
SELECT 
    customer_id, purchase_amount
FROM
    customer
WHERE
    discount_applied = 'Yes'
    and purchase_amount >= (select AVG(purchase_amount) FROM customer);

-- Which are the top 5 products with the highest average review rating?
SELECT 
    item_purchased, ROUND(AVG(review_rating), 2) AS 'avg_review_rating'
FROM
    customer
GROUP BY item_purchased
ORDER BY avg_review_rating DESC LIMIT 5;

-- Compare the average Purchase Amounts between standard and express shipping 
SELECT 
    shipping_type,
    ROUND(AVG(purchase_amount), 2) AS purchase_amount_avg
FROM
    customer
WHERE
    shipping_type IN ('Standard' , 'Express')
GROUP BY shipping_type;

-- DO Subscribed customers spend more? compare average spend and total revenue between subscribers and non-subscribers.
SELECT 
    subscription_status,
    COUNT(customer_id),
    ROUND(AVG(purchase_amount),2) as avg_spend,
	ROUND(SUM(purchase_amount),2) as total_revenue
FROM
    customer
GROUP BY subscription_status
ORDER BY total_revenue, avg_spend DESC;

-- Which 5 products have the highest precentage of purchases with dicount applied?
 SELECT 
    item_purchased,
 ROUND(100 * SUM(CASE WHEN discount_applied ='Yes' THEN 1 ELSE 0 END)/COUNT(*), 2) as discount_rate
FROM
    customer
GROUP BY item_purchased
ORDER BY discount_rate DESC 
LIMIT 5;

-- Segment Customers into New, Loyal and returning based on their total number of perivous purchases and show the count of each segment
 