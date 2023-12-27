-- 1. Active Employees by Gender
SELECT
	gender, 
    COUNT(*) AS Gender_Comp
FROM humanresource.employees
WHERE Age >= 18 AND termdate = "0000-00-00"
GROUP BY gender;

-- 3. Race/Ethicity Composition 
SELECT 
	race,
    COUNT(*) AS Race_Composition
FROM humanresource.employees
WHERE Age >= 18 AND termdate = "0000-00-00"
GROUP BY race
ORDER BY Race_Composition DESC;

-- 4. Distribution of Job Titles in the Company 
SELECT 
	department,
	jobtitle,
    COUNT(*) AS Designations
FROM humanresource.employees
WHERE Age >= 18 AND termdate = "0000-00-00"
GROUP BY department, jobtitle
ORDER BY jobtitle DESC;

-- 5. Number of job titles per department 
SELECT 
	department, 
	COUNT(*) AS job_title_count
FROM humanresource.employees
WHERE Age >= 18 AND termdate = "0000-00-00"
GROUP BY department, jobtitle
ORDER BY job_title_count DESC;

-- 6. Number of Departments in the Organisation 
SELECT 
    COUNT(DISTINCT department) AS Department_COUNT
FROM humanresource.employees
WHERE Age >= 18 AND termdate = "0000-00-00";

-- 7. Proportion of Employees at the Headquarters versus Other Locations 
SELECT 
	location, 
    COUNT(*) AS Work_Station_Count
FROM humanresource.employees
WHERE Age >= 18 AND termdate = "0000-00-00"
GROUP BY location
ORDER BY Work_Station_Count DESC;

-- 8. Count of employees from each state 
SELECT 
	location_state,
    COUNT(*) AS States 
FROM humanresource.employees
WHERE Age >= 18 AND termdate = "0000-00-00"
GROUP BY location_state
ORDER BY States DESC;

-- 9. Count of Employees per City 
SELECT 
	location_city,
    COUNT(*) AS City_Count
FROM humanresource.employees
WHERE Age >= 18 AND termdate = "0000-00-00"
GROUP BY location_city
ORDER BY City_Count DESC;

-- 10. Age Group of Employees
SELECT 
	CASE 
		WHEN Age BETWEEN 18 AND 24 THEN '18-24'
        WHEN Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN Age BETWEEN 35 AND 44 THEN '35-44'
        WHEN Age BETWEEN  45 AND 55 THEN '45-54'
        ELSE '55+'
	END AS 
		Age_Group, 
        Gender,
		COUNT(*) AS Count
FROM humanresource.employees
WHERE Age >= 18 and termdate = '0000-00-00'
GROUP BY Age_Group, gender
ORDER BY age_group, gender;

-- OR 

SELECT 
  CASE 
    WHEN age >= 18 AND age <= 24 THEN '18-24'
    WHEN age >= 25 AND age <= 34 THEN '25-34'
    WHEN age >= 35 AND age <= 44 THEN '35-44'
    WHEN age >= 45 AND age <= 54 THEN '45-54'
    ELSE '55+' 
  END AS age_group, gender,
  COUNT(*) AS count
FROM 
  humanresource.employees
WHERE 
  Age >= 18 AND termdate = '0000-00-00'
GROUP BY age_group, gender
ORDER BY age_group, gender;


-- 11.  Average length of employment before termination 
SELECT 
	ROUND(AVG(DATEDIFF(termdate, hire_date))/365,4) AS avg_length_of_employment
FROM 
	humanresource.employees
WHERE Age >= 18 AND termdate <= CURDATE() AND  termdate != '0000-00-00';

-- 12. Gender distribution accross departments 
SELECT 
	department, 
    gender, 
    COUNT(*) AS count
FROM humanresource.employees
WHERE Age >= 18 AND termdate = '0000-00-00'
GROUP BY department, gender
ORDER BY department DESC;

-- 12. Employee count changed over time based on hire and termination dates
SELECT 
    YEAR(hire_date) AS year, 
    COUNT(*) AS hired, 
    SUM(CASE WHEN termdate != '0000-00-00' AND termdate <= CURDATE() THEN 1 ELSE 0 END) AS terminations, 
    COUNT(*) - SUM(CASE WHEN termdate != '0000-00-00' AND termdate <= CURDATE() THEN 1 ELSE 0 END) AS net_change,
    ROUND(((COUNT(*) - SUM(CASE WHEN termdate != '0000-00-00' AND termdate <= CURDATE() THEN 1 ELSE 0 END)) / COUNT(*) * 100),2) AS net_change_percent
FROM 
    humanresource.employees
WHERE Age >= 18
GROUP BY 
    YEAR(hire_date)
ORDER BY 
    YEAR(hire_date) ASC;
    
-- 13. Tenure distribution for each department for terminated employees
SELECT 
	department, 
	ROUND(AVG(DATEDIFF(CURDATE(), termdate)/365),4) as avg_tenure
FROM humanresource.employees
WHERE termdate <= CURDATE() AND termdate != '0000-00-00' AND Age >= 18
GROUP BY department;


SELECT *
FROM humanresource.employees;