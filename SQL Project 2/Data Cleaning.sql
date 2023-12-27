-- 1.  Creating a Database 
CREATE DATABASE HumanResource;

-- 2. Load Dataset for Analysis 
-- File must be CSV 
-- 3. Data Cleaning 
-- a) Rename the table from Human Resources to Employees if you don't like working white spaces.
ALTER TABLE humanresource.`human resources`
RENAME TO Employees;
-- b) Rename the first fields ï»¿id to EmployeeID
ALTER TABLE employees
CHANGE COLUMN ï»¿id EmployeeID VARCHAR(15) NULL;

-- c) Check the data type of your fields (columns)
DESCRIBE humanresource.employees;

-- d) Convert Date Fields/Columns format from MM-DD-YYYY or MM/DD/YYYY to YYYY-MM-DD 
-- i) Modify format of date of birth (birthdate) 
UPDATE humanresource.employees
SET birthdate =
	CASE 
		WHEN birthdate LIKE '%/%' THEN DATE_FORMAT(STR_TO_DATE(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
        WHEN birthdate LIKE '%-%' THEN DATE_FORMAT(STR_TO_DATE(birthdate, '%m-%d-%Y'), '%Y-%m-%d')  
        ELSE NULL 
	END;
    
-- ii) Modify format of hiring date (birthdate) 
UPDATE humanresource.employees
SET hire_date = 
	CASE 
		WHEN hire_date LIKE '%/%' THEN DATE_FORMAT(STR_TO_DATE(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
        WHEN hire_date LIKE '%-%' THEN DATE_FORMAT(STR_TO_DATE(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
        ELSE NULL 
	END;
     
-- iii) Modify format of termination date (termdate) 
UPDATE humanresource.employees
SET termdate = date(STR_TO_DATE(termdate, '%Y-%m-%d %H:%i:%S UTC'))
WHERE termdate IS NOT NULL AND termdate != '';

UPDATE humanresource.employees
SET termdate = NULL
WHERE termdate = '';

UPDATE humanresource.employees
SET termdate = '0000-00-00'
WHERE termdate IS NULL;

SELECT termdate
FROM humanresource.employees;
-- e) Change the data type of date fields/columns from text to date data type 
-- i) Change data type of birthdate column
ALTER TABLE humanresource.employees
MODIFY COLUMN birthdate DATE;

-- ii) Change data type of hire_date column
ALTER TABLE humanresource.employees
MODIFY COLUMN  hire_date DATE;

-- iii) Change data type of termdate column
ALTER TABLE humanresource.employees
MODIFY COLUMN termdate DATE;
    
-- f) Add a new column called age 
ALTER TABLE humanresource.employees 
ADD Age INT;

-- g) Add data to the column using timestampdiff 
UPDATE humanresource.employees
SET Age = TIMESTAMPDIFF(YEAR, birthdate, CURDATE());

-- h) Display the lowest and highest ages 
SELECT 
	MIN(Age) AS 'Youngest Employee',
    MAX(Age) AS 'Oldest Employee'
FROM humanresource.employees;

-- h) Given that 18 years is considered the right age for employment I will only use employees who are above 18 years
-- Records for age below 18 years
SELECT 
	COUNT(*) AS Count 
FROM humanresource.employees
WHERE Age < 18;

-- Records of age above 18 years
SELECT 
	COUNT(*) AS Count 
FROM humanresource.employees
WHERE Age >= 18;

SELECT *
FROM humanresource.employees
WHERE Age >= 18 AND termdate = "0000-00-00";

SELECT *
FROM humanresource.employees;



