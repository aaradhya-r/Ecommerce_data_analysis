SELECT * from ecommerce;
--A. Data understanding
--Total ROWS
SELECT Count(*) from ecommerce;

--B. Data cleaning 
--Convert price and discount to numeric  
UPDATE ecommerce
SET price = CAST(price AS REAL), discount = CAST(discount AS REAL);

--Recalculate final price 
UPDATE ecommerce
SET final_price = price - (price * discount/100);
SELECT price, discount, final_price from ecommerce; --checking final price

--C. Business Metrics
-- Total revenue
SELECT sum(final_price) AS Total_revenue from ecommerce;

--Total_orders
SELECT count(*) AS Total_orders from ecommerce;

-- Average order value 
SELECT AVG(final_price) AS Average_order_value from ecommerce;

--D. Category analysis
-- Revenue by Category 
SELECT category, sum(final_price) AS Revenue  from ecommerce
GROUP BY category 
ORDER BY Revenue DESC; 

-- Order by category 
SELECT category , count(*) AS Total_orders from ecommerce
GROUP BY category ;

--E. Product Analysis 
-- Revenue by Product 
SELECT Product_ID, Sum(final_price) AS Revenue from ecommerce
GROUP BY Product_ID
ORDER BY Revenue DESC
limit 5; 

--F. Customer analysis
--Total spending per user 
SELECT User_ID, sum(final_price) AS total_spent from ecommerce
GROUP BY User_ID
ORDER BY total_spent DESC;

--Customer Segmentation
SELECT User_ID, sum(final_price) AS total_spent ,
CASE
WHEN sum(final_price) > 100 THEN "HIGH VALUE" ELSE "LOW VALUE" 
END AS customer_type 
from ecommerce
GROUP BY User_ID
ORDER BY total_spent DESC;

--G. Payment analysis
-- payment method usage 
SELECT Payment_Method, count(*) AS usage_count from ecommerce
GROUP BY Payment_Method;

-- Revenue by payment method 
SELECT Payment_Method, sum(final_price)  AS Revenue from ecommerce
GROUP BY Payment_Method
ORDER BY Revenue DESC;

--H. Time analysis 
-- Daily Sales
SELECT Purchase_Date, sum(final_price) AS Revenue from ecommerce
GROUP BY Purchase_Date
ORDER BY Purchase_Date ;

--Monthly sales 
SELECT  CASE substr(purchase_date,  4,  2)  
WHEN "01" THEN "January" 
WHEN "02" THEN "February"
WHEN "03" THEN "March"
WHEN "04" THEN "April"
WHEN "05" THEN "May"
WHEN "06" THEN "June"
WHEN "07" THEN "July"
WHEN "08" THEN "August"
WHEN "09" THEN "September"
WHEN "10" THEN "October"
WHEN "11" THEN "November"
WHEN "12" THEN "December"
END AS month, sum(final_price) AS Revenue  from ecommerce
GROUP BY substr(purchase_date,  4,  2)
ORDER BY substr(purchase_date,  4,  2);;


