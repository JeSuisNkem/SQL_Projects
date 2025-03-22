CREATE TABLE Cholera_data_1949_2016( 
 ID INT PRIMARY KEY,
 Country VARCHAR(52),
 Infection_Year INT,
 Number_of_reported_cases INT,
 Number_of_reported_deaths INT,
 Fatality_rate FLOAT,
 WHO_Region VARCHAR(21));

#What country has the highest number of reported cases of cholera? Plot with a map graph
SELECT Country, SUM(Number_of_reported_cases) AS total_cases, SUM(Number_of_reported_deaths) AS total_deaths
FROM cholera_data_1949_2016
GROUP BY Country
ORDER BY total_cases DESC
LIMIT 10;

#What region has the highest number of reported cases of cholera? Plot with a map graph
SELECT DISTINCT Who_region, SUM(Number_of_reported_cases) AS Cases
FROM cholera_data_1949_2016
GROUP BY WHO_Region
ORDER BY Cases DESC;

#What Country has the highest recvory numbers of the country with the worst cases?
SELECT Country, SUM(Number_of_reported_cases) AS sases, SUM(Number_of_reported_deaths) AS total_deaths, 
(SUM(Number_of_reported_cases) - SUM(Number_of_reported_deaths)) AS Recoveries,
ROUND((((SUM(Number_of_reported_cases) - SUM(Number_of_reported_deaths))/(SUM(Number_of_reported_cases)))*100)) as Recovery_Rate
FROM cholera_data_1949_2016
GROUP BY Country 
ORDER BY Recoveries DESC;

SELECT *,
(Number_of_reported_cases - Number_of_reported_deaths) AS Recoveries,
(Number_of_reported_cases - Number_of_reported_deaths)/(Number_of_reported_cases)*100 as Recovery_Rate
FROM cholera_data_1949_2016;

#What country had the worst Fatality Rates
SELECT Country, SUM(Number_of_reported_cases) AS total_cases, SUM(Number_of_reported_deaths) AS total_deaths, 
(SUM(Number_of_reported_cases) - SUM(Number_of_reported_deaths)) AS Recoveries,
ROUND(SUM(Number_of_reported_deaths)/(SUM(Number_of_reported_cases))*100)  as Fatality_Rate 
FROM cholera_data_1949_2016
GROUP BY Country
ORDER BY Fatality_Rate DESC
LIMIT 10;

SELECT Country, SUM(Number_of_reported_cases) AS total_cases, SUM(Number_of_reported_deaths) AS total_deaths, 
(SUM(Number_of_reported_cases) - SUM(Number_of_reported_deaths)) AS Recoveries,
SUM(Fatality_rate) as Fatality_Rate
FROM cholera_data_1949_2016
GROUP BY Country
ORDER BY Fatality_Rate DESC
LIMIT 10;

#What is the progression of Cholera over the years? 
SELECT Year, SUM(Number_of_reported_cases) AS total_cases
FROM cholera_data_1949_2016
GROUP BY Year
ORDER BY Year;

#Which year had the highest no of cholera cases
SELECT Year, SUM(Number_of_reported_cases) AS total_cases, sum(Number_of_reported_deaths)
FROM cholera_data_1949_2016
GROUP BY Year
ORDER BY total_cases DESC;

# Which country had the highest number of reported cases of cholera in that year?
SELECT Country, SUM(Number_of_reported_cases) AS Total_cases, SUM(Number_of_reported_deaths) AS Total_deaths,
(((SUM(Number_of_reported_cases) - SUM(Number_of_reported_deaths))/(SUM(Number_of_reported_cases)))*100) as Recovery_Rate
FROM cholera_data_1949_2016
WHERE Year = 1991
GROUP BY Country
ORDER BY Total_cases DESC
LIMIT 5;
	
#In which year did Nigeria have the worst case of Cholera?
SELECT Year, SUM(Number_of_reported_cases) as Total_Cases
FROM cholera_data_1949_2016
WHERE Country = "Nigeria"
GROUP BY Year
ORDER BY Total_Cases DESC;
