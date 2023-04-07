select*
from life_exp


--Kenya's life expectancy from 2015-2020
SELECT [Country Name],[2015],[2016],[2017],[2018],[2019],[2020] 
FROM life_exp 
WHERE [Country Name] = 'Kenya' ;


--Life expectancy for East-african countries from 2015-2020
SELECT [Country Name],[2015],[2016],[2017],[2018],[2019],[2020]
FROM life_exp
WHERE [Country Name] IN ('Kenya','Ethiopia','Rwanda','Uganda','Tanzana','Burundi','Somalia','Eritrea','South Sudan','Djibouti','Comoros','Madagascar','Seychelles','Malawi','Mozambique','Mauritius','Zambia','Zimbabwe','Sudan')


--East-African country with the highest life expectancy in 2020
SELECT [Country Name] as East_africa,[2020] as year_2020
FROM life_exp
WHERE [Country Name] IN ('Kenya','Ethiopia','Rwanda','Uganda','Tanzana','Burundi','Somalia','Eritrea','South Sudan','Djibouti','Comoros','Madagascar','Seychelles','Malawi','Mozambique','Mauritius','Zambia','Zimbabwe','Sudan')
ORDER BY [year_2020] DESC
OFFSET 0 ROWS
FETCH NEXT 1 ROWS ONLY


--East-African country with the lowest life expectancy in 2020
SELECT  [Country Name] as East_africa,[2020] as year_2020
FROM life_exp
WHERE [Country Name] IN ('Kenya','Ethiopia','Rwanda','Uganda','Tanzana','Burundi','Somalia','Eritrea','South Sudan','Djibouti','Comoros','Madagascar','Seychelles','Malawi','Mozambique','Mauritius','Zambia','Zimbabwe','Sudan')
ORDER BY [year_2020]  
OFFSET 0 ROWS
FETCH NEXT 1 ROWS ONLY


--Countries with life expectancy above 80 years in 2020
SELECT [Country Name], [2020] FROM life_exp 
WHERE [2020]>80 
ORDER BY [2020] DESC;


--Number of countries with a life expectancy above 80 years
SELECT COUNT(*) as no_of_countries
FROM (
SELECT [Country Name], [2020] FROM life_exp 
WHERE [2020]>80 
) sub 


--Countries with a life expectancy below 55 years in 2020
SELECT [Country Name], [2020] FROM life_exp 
WHERE [2020]<55 
ORDER BY [2020];


--Number of countries with a life expectancy below 55 years
SELECT COUNT(*) as no_of_countries
FROM (
SELECT [Country Name], [2020] FROM life_exp 
WHERE [2020]<55 
) sub 


--Top 5 countries with the highest life expectancy in the world
SELECT [Country Name],[2020] 
FROM life_exp 
GROUP BY [Country Name],[2020] 
ORDER BY [2020] DESC
OFFSET 0 ROWS
FETCH NEXT 5 ROWS ONLY


--Top 5 countries with the lowest life expectancy in the world
SELECT [Country Name],[2020] 
FROM life_exp 
WHERE [2020] IS NOT NULL
GROUP BY [Country Name],[2020] 
ORDER BY [2020] 
OFFSET 0 ROWS
FETCH NEXT 5 ROWS ONLY

--Average life expectancy from 2015 to 2020
SELECT [Country Name],AVG(([2015]+[2016]+[2017]+[2018]+[2019]+[2020])/6) AS average
FROM life_exp 
GROUP BY [Country Name]
ORDER BY [average] desc