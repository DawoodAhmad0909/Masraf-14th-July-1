# The Film Analytics Hub: Studio Performance & Market Trends 2010-2025
## Overview 

The MD14thJ1_db database models the global movie industry with a structured schema focusing on studios, directors, actors, movies, franchises, awards, and performance metrics. It includes:

 •Studios with financial and organizational details.

 •Directors and actors with biographical and career information.

 •Movies enriched with data like budget, box office, IMDb ratings, MPAA ratings, and franchise links.

 •Casts capturing actor roles, lead status, and salary.

 •Awards and winners for tracking recognition across major bodies like Oscars, BAFTA, and Golden Globes.

Analytical queries were designed to address performance trends, profitability, talent contributions, franchise impacts, and awards outcomes.

## Objectives

To provide financial and operational insights into Hollywood's evolving landscape through production budgets, box office returns, and franchise performance metrics.

## Creating Database 
``` sql
CREATE DATABASE MD14thJ1_db;
USE MD14thJ1_db;
```
## Creating Tables
### Table:studios
``` sql
CREATE TABLE studios (
        studio_id       INT PRIMARY KEY AUTO_INCREMENT,
        name            TEXT,
        founded_year    INT,
        headquarters    TEXT,
        parent_company  TEXT,
        annual_revenue  DECIMAL(10,2)
);

SELECT * FROM studios ;
```
### Table:directors
``` sql
CREATE TABLE directors (
        director_id      INT PRIMARY KEY AUTO_INCREMENT,
        first_name       TEXT,
        last_name        TEXT,
        birth_date       DATE,
        nationality      TEXT,
        debut_year       INT,
        directing_style  TEXT
);

SELECT * FROM directors ;
```
### Table:actors
``` sql
CREATE TABLE actors (
        actor_id     INT PRIMARY KEY AUTO_INCREMENT,
        first_name   TEXT,
        last_name    TEXT,
        birth_date   DATE,
        nationality  TEXT,
        gender       TEXT,
        debut_year   INT,
        is_a_list    BOOLEAN
); 

SELECT * FROM actors ;
```
### Table:movies
``` sql
CREATE TABLE movies (
        movie_id               INT PRIMARY KEY AUTO_INCREMENT,
        title                  TEXT,
        release_year           INT,
        studio_id              INT,
        director_id            INT,
        budget                 DECIMAL(10,2),
    box_office_worldwide   DECIMAL(10,2),
        runtime_minutes        DECIMAL(10,2),
        mpaa_rating            TEXT,
        imdb_rating            DECIMAL(10,2),
        oscar_nominations      INT,
        oscar_wins             INT,
        franchise              TEXT,
        is_sequel              BOOLEAN,
        is_remake              BOOLEAN,
        FOREIGN KEY (studio_id) REFERENCES studios(studio_id),
        FOREIGN KEY (director_id) REFERENCES directors(director_id)
);

SELECT * FROM movies ;
```
### Table:movie_casts
``` sql
CREATE TABLE movie_casts (
        movie_cast_id  INT PRIMARY KEY AUTO_INCREMENT,
        movie_id       INT,
        actor_id       INT,
        role_name      TEXT,
        is_lead_role   BOOLEAN,
        salary DECIMAL(10,2),
        FOREIGN KEY (movie_id) REFERENCES movies(movie_id),
        FOREIGN KEY (actor_id) REFERENCES actors(actor_id)
);

SELECT * FROM movie_casts ;
```
### Table:awards
``` sql
CREATE TABLE awards (
        award_id       INT PRIMARY KEY AUTO_INCREMENT,
        name           TEXT,
        category       TEXT,
        awarding_body  TEXT
);

SELECT * FROM awards ;
```
### Table:award_winners
``` sql
CREATE TABLE award_winners (
        award_winner_id  INT PRIMARY KEY AUTO_INCREMENT,
        award_id         INT,
        movie_id         INT,
        actor_id         INT,
        director_id      INT,
        year INT,
        FOREIGN KEY (award_id) REFERENCES awards(award_id),
        FOREIGN KEY (movie_id) REFERENCES movies(movie_id),
        FOREIGN KEY (actor_id) REFERENCES actors(actor_id),
        FOREIGN KEY (director_id) REFERENCES directors(director_id)
); 

SELECT * FROM award_winners;
```
## Key Queries  

### Studio Performance Analysis
#### 1. Which studio had the highest average box office return per movie from 2010-2023?
``` sql
SELECT 
        s.name AS Studio_name,ROUND(AVG(m.box_office_worldwide),2) AS Average_box_office_returns
FROM studios s 
JOIN movies m ON m.studio_id=s.studio_id
WHERE 
        m.release_year BETWEEN 2010 AND 2023
    AND m.box_office_worldwide IS NOT NULL
GROUP BY Studio_name
ORDER BY Average_box_office_returns DESC 
LIMIT 1;
```
#### 2. List studios by their total number of Oscar wins, ranked from highest to lowest.
``` sql
SELECT 
        s.name AS Studio_name,SUM(oscar_wins) AS Total_Oscar_wins
FROM studios s 
JOIN movies m ON m.studio_id=s.studio_id
GROUP BY Studio_name
ORDER BY Total_Oscar_wins DESC;
```
### Movie Financials
#### 4. Show the top 10 highest-grossing movies and their profit margins (box office/budget).
``` sql
SELECT 
        title,release_year,budget,box_office_worldwide,
    ROUND(box_office_worldwide/budget,2) AS Profit_margin
FROM movies
WHERE 
        budget IS NOT NULL
    AND box_office_worldwide IS NOT NULL
ORDER BY box_office_worldwide DESC 
LIMIT 10;
```
#### 5. Which movies had the best box office-to-budget ratio?
``` sql
SELECT 
        title,release_year,budget,box_office_worldwide,
    ROUND(box_office_worldwide/budget,2) AS Box_Office_to_Budget_ratio
FROM movies
WHERE 
        budget IS NOT NULL
    AND box_office_worldwide IS NOT NULL
ORDER BY Box_Office_to_Budget_ratio DESC 
LIMIT 3;
```
#### 6. Compare the average budgets of original films vs. sequels vs. remakes.
``` sql
SELECT 
        CASE 
                WHEN is_sequel=TRUE THEN 'Sequel'
        WHEN is_remake=TRUE THEN 'Remake'
        ELSE 'Original'
        END AS Movie_type,
    ROUND(AVG(budget),2) AS Average_budget
FROM movies
WHERE budget IS NOT NULL
GROUP BY Movie_type;
```
### Director Insights
#### 8. List directors by their average IMDb rating for films released after 2015.
``` sql
SELECT 
        CONCAT(d.first_name,' ',d.last_name) AS Director_name,
    d.debut_year,d.directing_style,
    ROUND(AVG(m.imdb_rating),2) AS Average_IMDP_rating
FROM directors d 
JOIN movies m ON m.director_id=d.director_id
WHERE 
        m.release_year > 2015
    AND m.imdb_rating IS NOT NULL 
GROUP BY Director_name,d.debut_year,d.directing_style;
```
#### 9. Which director has the highest average box office per film?movies
``` sql
SELECT 
        CONCAT(d.first_name,' ',d.last_name) AS Director_name,
    d.debut_year,d.directing_style,
    ROUND(AVG(m.box_office_worldwide),2) AS Average_Box_Office
FROM directors d 
JOIN movies m ON m.director_id=d.director_id
WHERE m.box_office_worldwide IS NOT NULL 
GROUP BY Director_name,d.debut_year,d.directing_style
ORDER BY Average_Box_Office DESC
LIMIT 1;
```
### Actor Analysis
#### 10. Which A-list actors appeared in the most franchise films?
``` sql
SELECT 
        CONCAT(a.first_name,' ',a.last_name) AS Actor_name,
    a.debut_year,a.gender,
    COUNT(DISTINCT m.movie_id) AS Total_Franchise_movie
FROM actors a 
JOIN movie_casts mc ON mc.actor_id=a.actor_id
JOIN movies m ON m.movie_id=mc.movie_id
WHERE 
        a.is_a_list=TRUE 
    AND m.franchise IS NOT NULL
GROUP BY Actor_name,a.debut_year,a.gender
ORDER BY Total_Franchise_movie DESC 
LIMIT 3;
```
#### 11. Show actors who have worked with multiple directors in our database.
``` sql
SELECT 
        CONCAT(a.first_name,' ',a.last_name) AS Actor_name,
    a.debut_year,a.gender,
    COUNT(DISTINCT m.director_id) AS Total_Directors
FROM actors a 
JOIN movie_casts mc ON mc.actor_id=a.actor_id
JOIN movies m ON m.movie_id=mc.movie_id
WHERE m.director_id IS NOT NULL
GROUP BY Actor_name,a.debut_year,a.gender
HAVING Total_Directors>1
ORDER BY Total_Directors DESC ;
```
### Franchise Performance
#### 13. Compare total box office earnings by franchise (Marvel, DC, Jurassic Park, etc.).
``` sql
SELECT 
        franchise,SUM(box_office_worldwide) AS Total_Box_Office_Collection 
FROM movies 
WHERE 
        franchise IS NOT NULL
    AND box_office_worldwide IS NOT NULL
GROUP BY franchise
ORDER BY Total_Box_Office_Collection DESC;
```
#### 14. Which franchise has the highest average IMDb rating?
``` sql
SELECT 
        franchise,ROUND(AVG(imdb_rating),2) AS Average_IMDP_Rating
FROM movies
WHERE 
        franchise IS NOT NULL
    AND imdb_rating IS NOT NULL
GROUP BY franchise
ORDER BY Average_IMDP_Rating DESC
LIMIT 1;
```
### Awards Analysis
#### 16. Which movies received Oscar nominations but didn't win any awards?
``` sql
SELECT 
        title,release_year,budget,box_office_worldwide,
    mpaa_rating,imdb_rating,oscar_nominations,oscar_wins
FROM movies 
WHERE 
        oscar_nominations>0 
        AND (oscar_wins=0 OR oscar_wins IS NULL);
```
#### 18. Which studio has the highest Oscar nomination-to-win ratio?
``` sql
SELECT 
        s.name AS Studio_name,
    SUM(m.oscar_nominations) AS Total_Oscar_nominations,
    SUM(oscar_wins) AS Total_Oscar_Wins,
    ROUND(SUM(m.oscar_nominations)/SUM(oscar_wins),2) AS nomination_to_win_ratio
FROM movies m
JOIN studios s ON m.studio_id = s.studio_id
WHERE 
    m.oscar_nominations > 0
    AND m.oscar_wins > 0
GROUP BY s.studio_id, s.name
ORDER BY nomination_to_win_ratio DESC
LIMIT 1;
```
### Temporal Trends
#### 19. How has average movie runtime changed from 2010 to 2023? 
``` sql
SELECT 
    release_year,
    ROUND(AVG(runtime_minutes), 2) AS avg_runtime_minutes
FROM movies
WHERE 
    release_year BETWEEN 2010 AND 2023
    AND runtime_minutes IS NOT NULL
GROUP BY release_year
ORDER BY release_year;
```
## Conclusion 

The MD14thJ1_db database provides a comprehensive foundation for analyzing the modern film industry's creative and commercial dynamics. Through a series of well-structured SQL queries, it reveals:

 •The most successful studios, franchises, and directors.

 •Financial insights such as profit margins and budget comparisons.

 •Patterns in award recognition and actor collaborations.

 •Time-based trends like runtime evolution.

This database serves as a valuable resource for decision-makers, analysts, and entertainment researchers seeking data-driven insights into cinema success factors.

