-- =====================================
-- Task 1 Create Database
-- =====================================
CREATE DATABASE IF NOT EXISTS financial_db;
USE financial_db;
CREATE TABLE financialdata (
	Segment VARCHAR (50),
    Country VARCHAR (50),
    Product VARCHAR (50),
    Discount_Band VARCHAR (50),
    Units_Sold DECIMAL (10,2),
    Manufacturing_Price DECIMAL (10,2),
    Sale_Price DECIMAL (10,2),
    Gross_Sales DECIMAL (10,2),
    Discounts DECIMAL (10,2),
    Sales DECIMAL (10,2),
    COGS DECIMAL (10,2),
    Profit DECIMAL (10,2),
    Dates Date,
    Month_Name VARCHAR (10)
);
-- =====================================
-- Task 2 Check Database Rows
-- =====================================
USE financial_db;
select count(*) as Total_Rows_Check from financialdata;
-- =====================================
-- Task 3 Count country and segement and product and discount band 
-- =====================================
USE financial_db;
SELECT 
COUNT(distinct Country) as country_count,
COUNT(distinct Product) as product_count,
COUNT(distinct Segment) as segment_count,
COUNT(distinct DisCount_band) as discount_Band_count From financialdata;
-- =====================================
-- Task 4 KPI
-- =====================================
USE financial_db;
SELECT 
round(SUM(Sales),2) as Total_Sales, 
round(sum(Profit),2) as Total_Profit, 
round(sum(units_sold),2) as Tatal_unites_sold, 
round(avg(Sales),2) as average_sales, 
round(avg(profit),2) as average_profit from financialdata;
-- =====================================
-- Task 5 Which country generating the most revenue?
-- =====================================
USE financial_db;
SELECT Country, round(sum(Sales),2) as Total_Sales FROM financialdata
group by Country
order by Total_sales DESC; 
-- =====================================
-- Task 6 Which products are driving our revenue?
-- =====================================
USE financial_db;
SELECT Product, round(sum(Sales),2) as Total_Sales, round(sum(profit),2) as Total_Profit FROM financialdata
group by Product
order by Total_sales DESC; 
-- =====================================
-- Task 7 Which customer segment contribute to sales?
-- =====================================
USE financial_db;
SELECT Segment, round(sum(Sales),2) as Total_Sales, round(sum(profit),2) as Total_Profit FROM financialdata
group by Segment
order by Total_sales DESC;
-- =====================================
-- Task 8 Which Discount band is responsible for lower profit?
-- =====================================
USE financial_db;
SELECT Discount_band, round(sum(Sales),2) as Total_Sales, round(sum(profit),2) as Total_Profit FROM financialdata
group by Discount_band
order by Total_profit ASC;
-- =====================================
-- Task 9 Why Enterprise is negtive profit? Root Cause analysis
-- =====================================
-- Step 1 Check Discount Band
USE financial_db;
SELECT Segment, Discount_Band, round(sum(profit),2) as Total_Profit FROM financialdata
where Segment ='Enterprise'
Group by discount_band
order by Total_profit ASC;
-- Step 2 Check Product
USE financial_db;
SELECT Segment, Product, Discount_Band, round(sum(profit),2) as Total_Profit FROM financialdata
where Segment ='Enterprise' AND Discount_Band = ' High ' 
Group by Product, Discount_Band
order by Total_profit ASC;
-- Step 3 Check country
USE financial_db;
SELECT   Discount_Band, country, round(sum(profit),2) as Total_Profit FROM financialdata
where Segment ='Enterprise' AND Discount_Band = ' High ' 
Group by Discount_Band, country 
order by Total_profit ASC;
-- Step 4 Check Units sold 
USE financial_db;
SELECT Product, sum(units_sold) as total_units_sold,  round(sum(profit),2) as Total_Profit FROM financialdata
where Segment ='Enterprise' AND Discount_Band = ' High ' 
Group by discount_band, Product
order by Total_profit ASC;
-- Step 5 Check Profit Per unit
USE financial_db;
SELECT Product, sum(units_sold) as total_units_sold,  round(sum(profit),2) as Total_Profit, round(sum(profit)/sum(units_sold),2) as profit_per_unit FROM financialdata
where Segment ='Enterprise' AND Discount_Band = ' High '
Group by discount_band, Product
order by Total_profit ASC;