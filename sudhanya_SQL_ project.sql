create database amazon_sales_data;

use amazon_sales_data

  create table amazon_sales_data.amazon ( 
                         Invoice_ID VARCHAR(30) NOT NULL

 ,
                         branch VARCHAR(5) NOT NULL

 ,
                         City VARCHAR(30) NOT NULL

,
                         Customer_type VARCHAR(30) NOT NULL,
                         gender VARCHAR(10) NOT NULL ,
                         Product_line VARCHAR(100) NOT NULL,
                    unit_price DECIMAL(10, 2) NOT NULL ,
                         Quantity INT NOT NULL,
                         VAT DECIMAL(6, 4) NOT NULL ,
                         TOTAL DECIMAL(10, 2) NOT NULL ,
                         date DATE NOT NULL ,
                         time TIME NOT NULL ,
                         payment_method VARCHAR(30) NOT NULL ,
                          COGS DECIMAL(10, 2) NOT NULL ,
                          gross_margin_percentage DECIMAL(11, 9) NOT NULL ,
                          Gross_income DECIMAL(10, 2) NOT NULL ,
						  rating DECIMAL(2,1) ) ;


                          
         select * from       amazon       ;
         
          alter table amazon 
          add column timeofday VARCHAR(30) after time ;
                         
update amazon set timeofday = 
 case 
	when time (time) >= '00.00.00'  and time (time) < '12.00.00' then 'Morning'
	when time (time) > '12.00.00'  and time (time) < '04.00.00' then 'Afternoon'
	else 'evening'
 end ;
 
 alter table amazon 
 add column dayname VARCHAR(30) after Date;
          
update amazon set dayname =
case dayofweek(DATE)
    when '1' then 'MON'
    When '2' then 'Tues'
     When '3' then 'Wed'
      When '4' then 'Thurs'
       When '5' then 'fri'
        When '6' then 'sat'
         When '7' then 'sun'
end ;

alter table amazon 
add column monthname varchar( 30) after dayname;

update amazon set monthname =
case month(date) 
                when '01' then 'JAN'
                when '02' then 'FEB'
                when '03' then 'MAR'
                when '04' then 'APR'
                when '05' then 'MAY'
                when '06' then 'JUN'
                when '07' then 'JULY'
                when '08' then 'AUG'
                when '09' then 'SEP'
                when '10' then 'OCT'
                when '11' then 'NOV'
				when '12' then 'DEC'
END ;
              
	SELECT * FROM AMAZON;
-- 	1. What is the count of distinct cities in the dataset?	

 SELECT COUNT(DISTINCT CITY) FROM AMAZON;
 
-- 2.For each branch, what is the corresponding city?

SELECT DISTINCT BRANCH ,  CITY FROM AMAZON ;

-- 3. What is the count of distinct product lines in the dataset?

SELECT COUNT(DISTINCT PRODUCT_LINE) FROM AMAZON;

-- 4.  Which payment method occurs most frequently?



select  payment_method, count(payment_method)    from amazon group by payment_method order by payment_method desc limit 1;


-- Which product line has the highest sales? pending 

select  product_line, sum(total) as total_sales 
  from amazon group by product_line  order by total_sales  desc limit 1  ;
  
  or 
  
  SELECT product_line, SUM(total) AS total_sales
FROM amazon
GROUP BY product_line
ORDER BY total_sales DESC
LIMIT 1;

select  product_line , count(  distinct product_line) from amazon group by product_line  ;

select * from amazon

-- How much revenue is generated each month?

SELECT monthname, SUM(total) AS revenue
FROM amazon
GROUP BY monthname
ORDER BY revenue DESC;



-- In which month did the cost of goods sold reach its peak?

select monthname , SUM(COGS) as COGS_SOLD From amazon group by monthname  
order by  COGS_SOLD DESC 
limit 1; 
-- after group by order by space and dont give commas 


-- Which product line generated the highest revenue?

select product_line, sum(total) as total_revenue from amazon 
group by product_line order by total_revenue desc limit 1;




-- In which city was the highest revenue recorded?

select city , sum(total) as revenue from amazon group by city order by revenue desc limit 1 ;

-- Which product line incurred the highest Value Added Tax?

select * from amazon;

select product_line from amazon
 group by product_line
 order by SUM(VAT) DESC LIMIT 1 ; 



-- 11. For each product line, add a column indicating "Good" if its sales are above average, otherwise "Bad." ## pending very tough

alter table amazon 
add column 

-- Identify the branch that exceeded the average number of products sold.


select branch , avg(quantity)
from amazon group by branch 
having AVG(quantity) > (SELECT AVG(quantity)
 FROM amazon)
 ;



-- Which product line is most frequently associated with each gender?  -- pending using partition by 


select product_line, gender  from amazon
 group by   product_line
 order by  desc
 limit 1;

-- Calculate the average rating for each product line.

select product_line , AVG(rating) from amazon group by 
product_line 
order by  AVG(rating)  desc 
 ;


-- Count the sales occurrences for each time of day on every weekday.




-- Identify the customer type contributing the highest revenue.

select customer_type, sum(TOTAL) AS REVENUE from amazon
GROUP BY customer_type
ORDER BY REVENUE DESC LIMIT 1;


-- Determine the city with the highest VAT percentage.

SELECT CITY , SUM(VAT) 
FROM  AMAZON 
GROUP BY CITY 
ORDER BY SUM(VAT) DESC 
LIMIT 1 ;




-- Identify the customer type with the highest VAT payments.

select * from amazon

select customer_type, sum(VAT) from amazon
GROUP BY customer_type
ORDER BY SUM(VAT) DESC LIMIT 1;

-- What is the count of distinct customer types in the dataset?

SELECT COUNT(DISTINCT CUSTOMER_TYPE) FROM AMAZON;


-- What is the count of distinct payment methods in the dataset?

SELECT COUNT(DISTINCT PAYMENT_METHOD)
 AS Distinct_payment_methods
 FROM AMAZON;


-- Which customer type occurs most frequently?

select customer_type, count(customer_type) as occurance_frequency 
from amazon group by customer_type
order by occurance_frequency desc
 limit 1;


-- Identify the customer type with the highest purchase frequency.
select customer_type, count(customer_type) as purchase_frequency 
from amazon group by customer_type
order by purchase_frequency desc
 limit 1;



-- Determine the predominant gender among customers.

select * from amazon

-- select customer_type, gender , count(*) as predominant_gender 
from amazon group by customer_type, gender
order by predominant_gender 
desc  limit 1;

select  gender , count(*) as predominant_gender 
from amazon group by  gender
order by predominant_gender 
desc limit 1 ;

-- or  
SELECT 
    gender,
    COUNT(*) AS gender_count
FROM 
    amazon
GROUP BY 
    gender
ORDER BY 
    gender_count DESC
LIMIT 1;


-- Examine the distribution of genders within each branch.

select branch, gender , count(*) as gender_count
 from amazon
 group by branch, gender
 order by branch , gender_count
 asc;
 






-- Identify the time of day when customers provide the most ratings.

select timeofday, count(*) as  count_rating

from amazon
group by  timeofday
order by count_rating desc limit 1 ;





-- Determine the time of day with the highest customer ratings for each branch.


    select  branch, timeofday,  
    count(*) as  count_rating
from amazon
group by  branch , timeofday
order by count_rating desc  ; ## incorrect 

SELECT branch,timeofday, rating_count
FROM (
	SELECT branch, timeofday, COUNT(*) AS rating_count,
	ROW_NUMBER() OVER (PARTITION BY branch ORDER BY COUNT(*) DESC) AS rn
    FROM amazon
    GROUP BY branch, timeofday
) AS ratings_by_time
WHERE rn = 1
ORDER BY branch;
 


-- Identify the day of the week with the highest average ratings.       


SELECT dayname, AVG(rating) AS avg_rating
FROM amazon
GROUP BY dayname
ORDER BY avg_rating DESC
LIMIT 1;


-- Determine the day of the week with the highest average ratings for each branch.      

SELECT branch, dayname, avg_rating
FROM (
    SELECT branch, dayname, AVG(rating) AS avg_rating,
	ROW_NUMBER() OVER (PARTITION BY branch ORDER BY AVG(rating) DESC) AS rn
    FROM amazon
    GROUP BY branch, dayname
) AS ranked_days
WHERE rn = 1;






   	