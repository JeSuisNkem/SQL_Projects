#How many unique artists?
SELECT COUNT(distinct Artist)
FROM songs;

#What is the Most Popular Song name
SELECT Title, COUNT(Title) as title_count
FROM songs
GROUP BY Title
ORDER BY count_title DESC;

#First to last year
SELECT
MIN(Year) as starting_year,
MAX(Year) as last_year,
MAX(Year)- MIN(Year) as diff_years
FROM songs;

#How many unique years?
SELECT COUNT(DISTINCT Year)
FROM songs;

#Which artist has the highest number of songs and highest sales?
SELECT Artist,
COUNT(Title) as title_count,
ROUND(SUM(sales), 2) as total_sales
FROM songs
GROUP BY Artist
ORDER BY total_sales DESC;

SELECT Artist, count(Title), sum(sales) as total_sales
FROM songs
GROUP BY Artist
ORDER BY total_sales DESC;

SELECT Year,
COUNT(Title) as Total_title
FROM Songs
GROUP BY Year
ORDER BY Total_title DESC
LIMIT 10;   

#1. Which artist had the highest total sales in total and in a given year?
 #1997 has the most number of sales and titles released, so who had the highest total sales in that year. 
SELECT Artist,
ROUND(SUM(Sales)) as total_sales_count
FROM songs
Where year = 1997
GROUP BY Artist
ORDER BY total_sales_count DESC
LIMIT 10;

#2. Is there a correlation between the number of releases in a year and the total sales in that year?
SELECT Year,
COUNT(Title) as total_songs_per_year,
ROUND(SUM(Sales)) as total_sales_per_year
FROM songs
GROUP BY Year
ORDER BY total_sales_per_year DESC;

#3. How do radio plays vary across different years for years in the 21st century?
SELECT Year, Count(Radioplays)as Total_RadioPlays,Year
FROM songs
Where year >2000
GROUP BY Year
ORDER BY Year DESC; 

SELECT Year,
Artist,
ROUND(SUM(RadioPlays)) as Radioplays
FROM songs
WHERE Year >2000 AND Artist = 'Rihanna'
GROUP BY Year, Artist
ORDER BY Radioplays DESC;

#4. Can you identify any trends in sales over the years for a specific artist (Madonna?)?
SELECT Year, ROUND(SUM(Sales)) as Yearly_Sales
FROM songs
WHERE Artist = 'Madonna'
GROUP BY Year
ORDER BY Year;

#5. Is there a relationship between an artist's average ratings and streaming numbers on a yearly basis?
#First we find the artist with the most amount of yea
SELECT Artist, COUNT(DISTINCT Year) AS no_of_years
FROM Songs
GROUP BY Artist
ORDER BY no_of_years DESC;

SELECT Year, ROUND (AVG(Rating), 2) AS rating_per_year,  ROUND (AVG(Streams), 2) AS streams_per_year
FROM songs
WHERE Artist = 'Michael Jackson'
	AND rating != 0
	AND streams !=0
GROUP BY Year
ORDER BY rating_per_year;

#6. Which artist has the highest average rating for their titles?
SELECT 
Artist,
ROUND (AVG(Rating), 2) AS avg_rating_per_artist,
COUNT(title) as total_title
FROM songs
WHERE rating != 0
GROUP BY Artist
ORDER BY avg_rating_per_artist DESC
LIMIT 10;

SELECT 
Artist, 
ROUND (AVG(Rating), 2) AS avg_rating_per_artist,
COUNT(title) as total_title
FROM songs
WHERE rating != 0
GROUP BY Artist
HAVING COUNT(title) > 1
ORDER BY avg_rating_per_artist DESC
LIMIT 10;

#7. Are there any titles that have a high number of downloads but low streaming numbers?
SELECT Title, ROUND(Downloads,2) AS Downloads, ROUND(Streams,2) As Streams
FROM songs
WHERE Downloads != 0 
AND streams != 0
ORDER BY Downloads DESC
LIMIT 20;

#8. How does the rating of a title impact its sales figures?
SELECT title, ROUND(rating,2) as Rating, ROUND(sales,2) as Sales
FROM songs
WHERE Streams != 0 
ORDER BY Sales DESC;

#9. Which artist has the most consistent performance in terms of sales and streams over the years?
SELECT Artist, Year, ROUND(SUM(sales),2) AS total_sales_per_artist, ROUND(SUM(streams),2) AS total_streams_per_artist
FROM songs
WHERE streams != 0
Group by Artist, Year
ORDER BY total_sales_per_artist;

#10. Is there a difference in popularity between newer and older titles based on streams and downloads?
SELECT Year, ROUND(SUM(downloads),2) AS Downloads, ROUND(SUM(streams),2) AS Streams
FROM songs
WHERE streams != 0
	AND downloads !=0
GROUP BY Year
ORDER BY Year; 

SELECT Artist,
	lag(Artist) 
OVER(PARTITION BY Artist)
FROM SONGS;

#3-year moving avg for an artist's sales. 
Select Year, sales, Artist,
AVG (sales) OVER (ORDER BY Year ASC) AS MA_SALES
FROM Madonna_sales
WHERE Artist = 'Madonna'
GROUP BY Year;

WITH Artist_sales AS 
(SELECT 
    Artist, 
    Year, 
    round (sum(sales),2) as sales
FROM Songs
GROUP BY Year, Artist)

#3-year moving avg for an artist's sales. 
Select 
Artist, Year, sales,
AVG (sales) OVER (ORDER BY Year ASC
ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS MA_SALES
FROM Artist_sales
WHERE Artist = 'Madonna'
Group BY Artist, Year;

CREATE VIEW Salesonsales AS
SELECT Artist, Year, ROUND(SUM(sales),2) AS total_sales_per_artist, ROUND(SUM(streams),2) AS total_streams_per_artist
FROM songs
WHERE streams != '0'
Group by Artist, Year
ORDER BY total_sales_per_artist;

