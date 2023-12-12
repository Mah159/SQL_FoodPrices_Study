-- Assignment 1 - Maheen Salman, Cohort 4 Orange
SELECT * FROM ms_assignment1.wfp_food_prices_pakistan;

-- Q1) Select dates and commodities for cities Quetta, Karachi, and Peshawar where price was less than or equal 50 PKR
-- The SELECT command is used to call the relevant columns. AS is used to update the names of the column
-- From allows us to refer to the table we need the information from 
-- Where is to refer to the column of cities
-- Order by allows us to sort the data according to relevant columns, it is in ascending order by default
-- First the FROM command runs then WHERE, then SELECT and lastly ORDER BY.
SELECT date, cmname AS commodity, mktname AS city, price, currency 
FROM wfp_food_prices_pakistan
WHERE mktname IN ('Quetta', 'Karachi', 'Peshawar') AND price <= 50
ORDER BY date, mktname, cmname;

-- Q2) Query to check number of observations against each market/city in PK
-- Here COUNT command is used to check the number of observations of each city
-- Group by is used to group the rows together to perform a specific function which is COUNT in this case
-- Order by is set to DESC which is descending order
-- First the FROM command runs then GROUP BY, then SELECT and lastly ORDER BY.
SELECT mktname AS city, COUNT(*) AS num_of_observations
FROM wfp_food_prices_pakistan
GROUP BY mktname
ORDER BY num_of_observations DESC;


-- Q3) Show number of distinct cities
-- First the FROM command runs to check the table needed then SELECT will run the COUNT(DISTINCT) command.
-- DISTINCT is used to identify the unique values of cities. The new column is named as num_of_distinct_cities
SELECT COUNT(DISTINCT mktname) AS num_of_distinct_cities
FROM wfp_food_prices_pakistan;

-- (To calculate distinct provinces) 
-- SELECT COUNT(DISTINCT admname) AS distinct_provinces_count
-- FROM wfp_food_prices_pakistan;

-- Q4) List down/show the names of cities in the table
-- First the FROM command runs to check the table needed then SELECT will run the DISTINCT command,
-- renaming the mktname as city
SELECT DISTINCT mktname AS city
FROM wfp_food_prices_pakistan;

-- Q5) List down/show the names of commodities in the table
-- First the FROM command runs to check the table needed then SELECT will run the DISTINCT command, 
-- renaming the cmname column as commodities
SELECT DISTINCT cmname AS commodities
FROM wfp_food_prices_pakistan;

-- Q6) List Average Prices for Wheat flour - Retail in EACH city separately over the entire period.
-- First the FROM command runs to check the table needed then WHERE will check the relevant entry we need to retrieve.
-- GROUP BY will run next and then SELECT where the mkname column is renamed as city and AVG function is used to calculate average of the price 
SELECT mktname AS city, AVG(price) AS avg_price
FROM wfp_food_prices_pakistan
WHERE cmname = 'Wheat Flour - Retail'
GROUP BY mktname
ORDER BY city;

-- Q7) Calculate summary stats (avg price, max price) for each city separately for all cities except Karachi and sort alphabetically the
-- city names, commodity names where commodity is Wheat (does not matter which one) with separate rows for each commodity

-- First FROM command runs, then WHERE command. In the WHERE line <> refers to not equal to. AND is used to check for all entries that begin with Wheat hence % is used at the end.alter
-- Afterwards GROUP BY command runs grouping data according to commodities and cities.
-- Then the SELECT line calculates average and maximum price using the AVG and MAX function
SELECT mktname AS city, cmname AS commodity, AVG(price) AS avg_price, MAX(price) AS max_price
FROM wfp_food_prices_pakistan
WHERE mktname <> 'Karachi' AND cmname LIKE 'Wheat%'
GROUP BY mktname, cmname
ORDER BY city, commodity;


-- Q8) Calculate Avg_prices for each city for Wheat Retail and show only those avg_prices which are less than 30
-- First the FROM command runs then WHERE refers to the commodity name Wheat - Retail. 
-- Then GROUP BY is executed then SELECT for average price. In the end HAVING command is used to define the condition on which it is grouped which is less than 30. 
SELECT mktname AS city, AVG (price) AS avg_price, cmname
FROM wfp_food_prices_pakistan
WHERE cmname = 'Wheat - Retail'
GROUP BY mktname
HAVING AVG (price) < 30;

-- Q9) Prepare a table where you categorize prices based on a logic (price < 30 is LOW, price > 250 is HIGH, in between are FAIR)
-- First FROM is run, then SELECT then CASE. In CASE the logical conditions are defined. END AS refers to the name of the new column made
SELECT date, cmname, category, mktname AS city, price,
    CASE
        WHEN price < 30 THEN 'LOW'
        WHEN price > 250 THEN 'HIGH'
        ELSE 'FAIR'
    END AS price_category
FROM wfp_food_prices_pakistan;

-- Q10) Create a query showing date, cmname, category, city, price, city_category where Logic for city category is: Karachi and Lahore
-- are 'Big City', Multan and Peshawar are 'Medium-sized city', Quetta is 'Small City'.
-- First FROM is run, then SELECT then CASE. In CASE the logical conditions are defined. END AS refers to the name of the new column made
SELECT date, cmname, category, mktname AS city, price,
    CASE
        WHEN mktname IN ('Karachi', 'Lahore') THEN 'Big City'
        WHEN mktname IN ('Multan', 'Peshawar') THEN 'Medium-sized City'
        WHEN mktname = 'Quetta' THEN 'Small City'
        ELSE 'Unknown' -- Handle any other cases if needed
    END AS city_category
FROM wfp_food_prices_pakistan;


-- Q11) Create a query to show date, cmname, city, price. Create new column price_fairness through CASE showing price is fair if less than 100, unfair if more than or equal to 100, if > 300 then 'Speculative'
-- First FROM is run, then SELECT then CASE. In CASE the logical conditions are defined. END AS refers to the name of the new column made
SELECT date, cmname, mktname as city, price,
    CASE
        WHEN price < 100 THEN 'Fair'
        WHEN price >= 100 AND price <= 300 THEN 'Unfair'
        WHEN price > 300 THEN 'Speculative'
        ELSE 'Unknown' -- Handle any other cases if needed
    END AS price_fairness
FROM wfp_food_prices_pakistan;


-- Q12) Join the food prices and commodities table with a left join.
-- left join is used to retrieve the values of the left table which is price table in our case. All columns are included.
SELECT f.*, c.*
FROM wfp_food_prices_pakistan f
LEFT JOIN commodity c ON f.cmname = c.cmname;

-- Q13) Join the food prices and commodities table with an inner join
-- f and c are alias for food prices (wfp) table and the commodity table. Based on the common column cmname we join both tables. 
-- Inner join is used to retrieve rows that have matching values in both tables.
SELECT f.*, c.*
FROM wfp_food_prices_pakistan f
INNER JOIN commodity c ON f.cmname = c.cmname;
