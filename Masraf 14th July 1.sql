CREATE DATABASE MD14thJ1_db;
USE MD14thJ1_db;

CREATE TABLE studios (
	studio_id       INT PRIMARY KEY AUTO_INCREMENT,
	name            TEXT,
	founded_year    INT,
	headquarters    TEXT,
	parent_company  TEXT,
	annual_revenue  DECIMAL(10,2)
);

SELECT * FROM studios ;

INSERT INTO  studios (name, founded_year, headquarters, parent_company, annual_revenue) VALUES
	('Warner Bros.', 1923, 'Burbank, CA', 'Warner Bros. Discovery', 14.3),
	('Disney', 1923, 'Burbank, CA', 'The Walt Disney Company', 82.7),
	('Universal', 1912, 'Universal City, CA', 'NBCUniversal', 40.9),
	('Paramount', 1912, 'Hollywood, CA', 'Paramount Global', 30.2),
	('Sony Pictures', 1987, 'Culver City, CA', 'Sony Group', 9.2),
	('Marvel Studios', 1993, 'Burbank, CA', 'Disney', 4.0),
	('Lionsgate', 1997, 'Santa Monica, CA', NULL, 3.5);

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

INSERT INTO directors (first_name, last_name, birth_date, nationality, debut_year, directing_style) VALUES
	('Christopher', 'Nolan', '1970-07-30', 'British-American', 1998, 'Epic sci-fi'),
	('James', 'Cameron', '1954-08-16', 'Canadian', 1981, 'Action spectacle'),
	('Greta', 'Gerwig', '1983-08-04', 'American', 2007, 'Coming-of-age'),
	('Denis', 'Villeneuve', '1967-10-03', 'Canadian', 1998, 'Sci-fi drama'),
	('Ryan', 'Coogler', '1986-05-23', 'American', 2011, 'Socially conscious'),
	('Chloé', 'Zhao', '1982-03-31', 'Chinese', 2008, 'Naturalistic'),
	('Taika', 'Waititi', '1975-08-16', 'New Zealander', 1999, 'Comedy-drama');

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

INSERT INTO actors (first_name, last_name, birth_date, nationality, gender, debut_year, is_a_list) VALUES
	('Leonardo', 'DiCaprio', '1974-11-11', 'American', 'Male', 1989, TRUE),
	('Margot', 'Robbie', '1990-07-02', 'Australian', 'Female', 2008, TRUE),
	('Dwayne', 'Johnson', '1972-05-02', 'American', 'Male', 1999, TRUE),
	('Tom', 'Holland', '1996-06-01', 'British', 'Male', 2012, TRUE),
	('Zendaya', '', '1996-09-01', 'American', 'Female', 2010, TRUE),
	('Timothée', 'Chalamet', '1995-12-27', 'American', 'Male', 2009, TRUE),
	('Florence', 'Pugh', '1996-01-03', 'British', 'Female', 2014, TRUE);

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

INSERT INTO movies (title, release_year, studio_id, director_id, budget, box_office_worldwide, runtime_minutes, mpaa_rating, imdb_rating, oscar_nominations, oscar_wins, franchise, is_sequel, is_remake) VALUES
	('Inception', 2010, 1, 1, 160, 836.8, 148, 'PG-13', 8.8, 8, 4, NULL, FALSE, FALSE),
	('The Avengers', 2012, 6, NULL, 220, 1519.6, 143, 'PG-13', 8.0, 1, 0, 'Marvel', FALSE, FALSE),
	('Frozen', 2013, 2, NULL, 150, 1280.0, 102, 'PG', 7.4, 2, 2, NULL, FALSE, FALSE),
	('Jurassic World', 2015, 3, NULL, 150, 1671.7, 124, 'PG-13', 7.0, 0, 0, 'Jurassic Park', TRUE, FALSE),
	('Black Panther', 2018, 6, 5, 200, 1347.0, 134, 'PG-13', 7.3, 7, 3, 'Marvel', FALSE, FALSE),
	('Tenet', 2020, 1, 1, 200, 363.7, 150, 'PG-13', 7.5, 2, 1, NULL, FALSE, FALSE),
	('Dune', 2021, 3, 4, 165, 402.0, 155, 'PG-13', 8.0, 10, 6, 'Dune', FALSE, TRUE),
	('Top Gun: Maverick', 2022, 4, NULL, 170, 1493.0, 130, 'PG-13', 8.3, 6, 1, 'Top Gun', TRUE, FALSE),
	('Barbie', 2023, 1, 3, 145, 1445.6, 114, 'PG-13', 7.3, 8, 1, NULL, FALSE, FALSE),
	('Oppenheimer', 2023, 3, 1, 100, 952.0, 180, 'R', 8.6, 13, 7, NULL, FALSE, FALSE),
	('Joker: Folie à Deux', 2024, 1, NULL, 200, NULL, NULL, 'R', NULL, NULL, NULL, 'DC', TRUE, FALSE),
	('Avatar 3', 2025, 2, 2, 350, NULL, NULL, 'PG-13', NULL, NULL, NULL, 'Avatar', TRUE, FALSE),
	('Fantastic Four', 2025, 6, NULL, 250, NULL, NULL, 'PG-13', NULL, NULL, NULL, 'Marvel', FALSE, TRUE);

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

INSERT INTO movie_casts (movie_id, actor_id, role_name, is_lead_role, salary) VALUES
	(1, 1, 'Dom Cobb', TRUE, 20.0), 
	(2, 4, 'Peter Parker/Spider-Man', FALSE, 0.5),  
	(5, 5, 'Shuri', FALSE, 2.0), 
	(7, 1, 'Paul Atreides', TRUE, 25.0), 
	(9, 2, 'Barbie', TRUE, 12.5),
	(10, 1, 'J. Robert Oppenheimer', TRUE, 20.0); 

CREATE TABLE awards (
	award_id       INT PRIMARY KEY AUTO_INCREMENT,
	name           TEXT,
	category       TEXT,
	awarding_body  TEXT
);

SELECT * FROM awards ;

INSERT INTO awards (name, category, awarding_body) VALUES
	('Oscar', 'Best Picture', 'Academy Awards'),
	('Oscar', 'Best Director', 'Academy Awards'),
	('Oscar', 'Best Actor', 'Academy Awards'),
	('Oscar', 'Best Actress', 'Academy Awards'),
	('Golden Globe', 'Best Motion Picture - Drama', 'HFPA'),
	('BAFTA', 'Best Film', 'BAFTA');

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

INSERT INTO award_winners (award_id, movie_id, actor_id, director_id, year) VALUES
	(1, 10, NULL, NULL, 2024),  
	(2, NULL, NULL, 1, 2024),   
	(3, NULL, 1, NULL, 2024),    
	(4, NULL, 2, NULL, 2024),   
	(1, 5, NULL, NULL, 2019),  
	(2, NULL, NULL, 5, 2019);    
    
-- Studio Performance Analysis
-- 1. Which studio had the highest average box office return per movie from 2010-2023?
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

-- 2. List studios by their total number of Oscar wins, ranked from highest to lowest.
SELECT 
	s.name AS Studio_name,SUM(oscar_wins) AS Total_Oscar_wins
FROM studios s 
JOIN movies m ON m.studio_id=s.studio_id
GROUP BY Studio_name
ORDER BY Total_Oscar_wins DESC;

-- Movie Financials
-- 4. Show the top 10 highest-grossing movies and their profit margins (box office/budget).
SELECT 
	title,release_year,budget,box_office_worldwide,
    ROUND(box_office_worldwide/budget,2) AS Profit_margin
FROM movies
WHERE 
	budget IS NOT NULL
    AND box_office_worldwide IS NOT NULL
ORDER BY box_office_worldwide DESC 
LIMIT 10;

-- 5. Which movies had the best box office-to-budget ratio?
SELECT 
	title,release_year,budget,box_office_worldwide,
    ROUND(box_office_worldwide/budget,2) AS Box_Office_to_Budget_ratio
FROM movies
WHERE 
	budget IS NOT NULL
    AND box_office_worldwide IS NOT NULL
ORDER BY Box_Office_to_Budget_ratio DESC 
LIMIT 3;

-- 6. Compare the average budgets of original films vs. sequels vs. remakes.
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

-- Director Insights
-- 8. List directors by their average IMDb rating for films released after 2015.
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

-- 9. Which director has the highest average box office per film?movies
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

-- Actor Analysis
-- 10. Which A-list actors appeared in the most franchise films?
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

-- 11. Show actors who have worked with multiple directors in our database.
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

-- Franchise Performance
-- 13. Compare total box office earnings by franchise (Marvel, DC, Jurassic Park, etc.).
SELECT 
	franchise,SUM(box_office_worldwide) AS Total_Box_Office_Collection 
FROM movies 
WHERE 
	franchise IS NOT NULL
    AND box_office_worldwide IS NOT NULL
GROUP BY franchise
ORDER BY Total_Box_Office_Collection DESC;

-- 14. Which franchise has the highest average IMDb rating?
SELECT 
	franchise,ROUND(AVG(imdb_rating),2) AS Average_IMDP_Rating
FROM movies
WHERE 
	franchise IS NOT NULL
    AND imdb_rating IS NOT NULL
GROUP BY franchise
ORDER BY Average_IMDP_Rating DESC
LIMIT 1;

-- Awards Analysis
-- 16. Which movies received Oscar nominations but didn't win any awards?
SELECT 
	title,release_year,budget,box_office_worldwide,
    mpaa_rating,imdb_rating,oscar_nominations,oscar_wins
FROM movies 
WHERE 
	oscar_nominations>0 
	AND (oscar_wins=0 OR oscar_wins IS NULL);

-- 18. Which studio has the highest Oscar nomination-to-win ratio?
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

-- Temporal Trends
-- 19. How has average movie runtime changed from 2010 to 2023? 
SELECT 
    release_year,
    ROUND(AVG(runtime_minutes), 2) AS avg_runtime_minutes
FROM movies
WHERE 
    release_year BETWEEN 2010 AND 2023
    AND runtime_minutes IS NOT NULL
GROUP BY release_year
ORDER BY release_year;