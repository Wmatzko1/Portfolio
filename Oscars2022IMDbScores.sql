DROP TABLE IMDb_Scores1;

CREATE TABLE IMDb_Scores1 (
    Release_Date DATE,
    Movie_Title VARCHAR(20),
    IMDB_SCORE DECIMAL(4, 1), 
    Total_Lifetime_Gross money 
);

INSERT INTO IMDb_Scores1 (Release_Date, Movie_Title, IMDB_SCORE, Total_Lifetime_Gross)
	VALUES ('10-22-2021', 'Dune', 8.0, 401847900);
INSERT INTO IMDb_Scores1 (Release_Date, Movie_Title, IMDB_SCORE, Total_Lifetime_Gross)
 VALUES ('08-31-2021', 'CODA', 8.0, 1608201);
INSERT INTO IMDb_Scores1 (Release_Date, Movie_Title, IMDB_SCORE, Total_Lifetime_Gross)
 VALUES ('12-10-2021', 'West Side Story', 7.2, 76016171);
INSERT INTO IMDb_Scores1 (Release_Date, Movie_Title, IMDB_SCORE, Total_Lifetime_Gross)
 VALUES ('11-17-2021', 'The Power of the Dog', 6.8, 271009);
INSERT INTO IMDb_Scores1 (Release_Date, Movie_Title, IMDB_SCORE, Total_Lifetime_Gross)
 VALUES ('11-12-2021', 'Belfast', 7.3, 48824582);
INSERT INTO IMDb_Scores1 (Release_Date, Movie_Title, IMDB_SCORE, Total_Lifetime_Gross)
 VALUES ('11-18-2021', 'King Richard', 7.5, 39359895);
INSERT INTO IMDb_Scores1(Release_Date, Movie_Title, IMDB_SCORE, Total_Lifetime_Gross)
 VALUES ('08-18-2021', 'Drive My Car', 7.6, 308325);

INSERT INTO IMDb_Scores1 (Release_Date, Movie_Title, IMDB_SCORE, Total_Lifetime_Gross)
 VALUES ('11-26-2021', 'Licorice Pizza', 7.2, 33253572);
INSERT INTO IMDb_Scores1 (Release_Date, Movie_Title, IMDB_SCORE, Total_Lifetime_Gross)
 VALUES ('12-08-2021', 'Dont Look Up', 7.2, 791863);
INSERT INTO IMDb_Scores1 (Release_Date, Movie_Title, IMDB_SCORE, Total_Lifetime_Gross)
 VALUES ('12-17-2021', 'Nightmare Alley', 7, 39629195);

SELECT * FROM IMDb_Scores1;

