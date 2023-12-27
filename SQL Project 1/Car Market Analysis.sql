-- 1. Convert/modify the Price data type from text to float 
ALTER TABLE carsdataset.carsalescarsales
MODIFY COLUMN Price FLOAT;

-- 2. Check missing values in the dataset
SELECT *
FROM carsdataset.carsales
WHERE EngineSize_L IS NULL 
OR  Entertainment_Features IS NULL 
OR Interior_Features IS NULL
OR Exterior_Features IS NULL
OR Customer_Ratings IS NULL
OR UnitsSold IS NULL;

-- 3. Overview of dataset by defining the best car make by sales and by units sold
-- a) Sales 
SELECT 
	CarMake, 
    SUM(UnitsSold * Price) AS Total_Sales
FROM carsdataset.carsales
GROUP BY CarMake
ORDER BY Total_Sales DESC;

-- Units Sold
SELECT 
CarMake, 
SUM(UnitsSold) AS Units_Sold
FROM carsdataset.carsales
GROUP BY CarMake
ORDER BY Units_Sold DESC;

-- 4. Overview of dataset by defining the best car model by sales and by units sold
-- a) Total Sales 
SELECT 
	CarModel, 
    SUM(UnitsSold * Price) AS Total_Units_Sold
FROM carsdataset.carsales
GROUP BY CarModel
ORDER BY Total_Units_Sold DESC;

-- b) Total Units sold per model
SELECT 
	CarModel, 
	SUM(UnitsSold) AS Total_Units_Sold
FROM carsdataset.carsales
GROUP BY CarModel
ORDER BY Total_Units_Sold DESC;

-- 5. Sales Performance Analysis
-- a)   Total Units Sold 
SELECT 
	Year,
    CarMake,
    CarModel,
    SUM(UnitsSold) AS Total_Units_Sold
FROM carsdataset.carsales
GROUP BY 
	Year,
    CarMake,
    CarModel
ORDER BY Total_Units_Sold ASC
LIMIT 10;

-- b) Total Revenues 
SELECT 
	Year,
    CarMake,
    CarModel,
    SUM(UnitsSold * Price) AS Total_Revenue 
FROM carsdataset.carsales
GROUP BY 
	Year,
    CarMake,
    CarModel
ORDER BY Total_Revenue ASC
LIMIT 10;
    
-- 6. Customer Preferences Analysis
SELECT 
	CarMake,
	CarModel,  
	BodyType,  
	ColorOptions,
    SUM(UnitsSold) AS Total_Units_Sold
FROM carsdataset.carsales
GROUP BY 
	CarMake,
	CarModel,  
	BodyType,  
	ColorOptions
ORDER BY Total_Units_SOld DESC;

-- 7. Analysis of Impact of Fuel Efficiency 
-- Examine the correlation between fuel efficiency (mileage) and sales figures
SELECT
	CarMake,
	CarModel,  
	Mileage,
	SUM(UnitsSold) AS Total_Units 
FROM carsdataset.carsales
GROUP BY 
	CarMake,
	CarModel,  
	Mileage
ORDER BY Total_Units DESC;

-- 8. Price Sensitivity Analysis 
-- a) Impact of pricing on sales
SELECT 
	CarMake,
    CarModel,
    Price,
    SUM(UnitsSold) AS Units_Sold,
    SUM(UnitsSold * Price) AS Sales
FROM carsdataset.carsales
GROUP BY
	CarMake,
    CarModel,
    Price
ORDER BY Price DESC;

-- b) Relationship between car prices and customer ratings 
-- in order to understand whether high-priced models result into improve customer satisfaction
SELECT 
	CarMake,
    CarModel,
    Price,
    SUM(UnitsSold) AS Units_Sold,
    AVG(CONVERT(LEFT(Customer_Ratings, 4), FLOAT)) AS Average_Ratings
FROM carsdataset.carsales
GROUP BY
	CarMake,
    CarModel,
    Price
ORDER BY Average_Ratings DESC;

-- 9. Analysis of Impact of Car Features 
SELECT 
	CarMake,
    CarModel,
    Safety_Features, 
    Entertainment_Features,
    Interior_Features,
    Exterior_Features,
    AVG(CONVERT(LEFT(Customer_Ratings, 4), FLOAT)) AS Average_Ratings,
    SUM(UnitsSold) AS Total_Units_Sold,
    SUM(UnitsSold * Price) AS Sales 
FROM carsdataset.carsales
GROUP BY 
	CarMake,
    CarModel,
    Safety_Features, 
    Entertainment_Features,
    Interior_Features,
    Exterior_Features
ORDER BY Average_Ratings DESC;

-- 10 Market Trend Analysis 
SELECT 
	CarMake, 
    CarModel,
    Year, 
    BodyType, 
    FuelType,
    SUM(UnitsSold) AS Total_Units_Sold
FROM carsdataset.carsales
GROUP BY 
	CarMake, 
    CarModel,
    Year, 
    BodyType, 
    FuelType
ORDER BY Total_Units_Sold DESC;

-- 11. General Exploratory Data Analysis 
SELECT CarMake, count(CarMake) AS Count
FROM carsdataset.carsales
GROUP BY CarMake
ORDER BY Count DESC;

SELECT CarMake, CarModel, count(CarMake) AS Make_Count, Count(CarModel) As Model_Count
FROM carsdataset.carsales
GROUP BY CarMake, CarModel
ORDER BY Make_Count DESC;

SELECT 
    *
FROM
    carsdataset.carsales
    

  

 

