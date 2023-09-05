-- If the database ORMModel1 exists, drop it
IF DB_ID('ORMModel1') IS NOT NULL 
    DROP DATABASE ORMModel1;
GO

-- Create a new database ORMModel1
CREATE DATABASE ORMModel1;
GO

-- Use the newly created database
USE ORMModel1;
GO

-- Create the Movie table
CREATE TABLE Movie (
    movieId int IDENTITY(1, 1) NOT NULL,
    amount decimal(19, 4) NOT NULL,
    movieName nvarchar(100) NOT NULL,
    categoryName nvarchar(max),
    directorName nvarchar(100),
    productionName nvarchar(100),
    CONSTRAINT Movie_PK PRIMARY KEY (movieId),
    CONSTRAINT Movie_UC UNIQUE (movieName)
);
GO

-- Create the Production table
CREATE TABLE Production (
    productionName nvarchar(100) NOT NULL,
    countryName nvarchar(100),
    CONSTRAINT Production_PK PRIMARY KEY (productionName)
);
GO

-- Create the Director table
CREATE TABLE Director (
    directorName nvarchar(100) NOT NULL,
    countryName nvarchar(100),
    CONSTRAINT Director_PK PRIMARY KEY (directorName)
);
GO

-- Create the LeadActor table
CREATE TABLE LeadActor (
    leadActorName nvarchar(100) NOT NULL,
    countryName nvarchar(100),
    CONSTRAINT LeadActor_PK PRIMARY KEY (leadActorName)
);
GO

-- Create the LeadActorActedInMovie table
CREATE TABLE LeadActorActedInMovie (
    leadActorName nvarchar(100) NOT NULL,
    movieId int NOT NULL,
    CONSTRAINT LeadActorActedInMovie_PK PRIMARY KEY (movieId, leadActorName)
);
GO

-- Create the MaleActor table
CREATE TABLE MaleActor (
    maleActorName nvarchar(100) NOT NULL,
    CONSTRAINT MaleActor_PK PRIMARY KEY (maleActorName)
);
GO

-- Create the FemaleActor table
CREATE TABLE FemaleActor (
    femaleActorName nvarchar(100) NOT NULL,
    CONSTRAINT FemaleActor_PK PRIMARY KEY (femaleActorName)
);
GO

-- Create the MovieWasReleasedInYearWithBudgetAmount table
CREATE TABLE MovieWasReleasedInYearWithBudgetAmount (
    movieId int NOT NULL,
    "year" date NOT NULL,
    amount decimal(19, 4) NOT NULL,
    CONSTRAINT MovieWasReleasedInYearWithBudgetAmount_PK PRIMARY KEY (movieId, "year"),
    CONSTRAINT MovieWasReleasedInYearWithBudgetAmount_UC UNIQUE ("year", amount)
);
GO

-- Add foreign keys to the Movie table
ALTER TABLE Movie ADD CONSTRAINT Movie_FK1 FOREIGN KEY (productionName) REFERENCES Production (productionName) ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE Movie ADD CONSTRAINT Movie_FK2 FOREIGN KEY (directorName) REFERENCES Director (directorName) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Add foreign keys to the LeadActorActedInMovie table
ALTER TABLE LeadActorActedInMovie ADD CONSTRAINT LeadActorActedInMovie_FK1 FOREIGN KEY (leadActorName) REFERENCES LeadActor (leadActorName) ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE LeadActorActedInMovie ADD CONSTRAINT LeadActorActedInMovie_FK2 FOREIGN KEY (movieId) REFERENCES Movie (movieId) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Add a foreign key to the MaleActor table
ALTER TABLE MaleActor ADD CONSTRAINT MaleActor_FK FOREIGN KEY (maleActorName) REFERENCES LeadActor (leadActorName) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Add a foreign key to the FemaleActor table
ALTER TABLE FemaleActor ADD CONSTRAINT FemaleActor_FK FOREIGN KEY (femaleActorName) REFERENCES LeadActor (leadActorName) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Add a foreign key to the MovieWasReleasedInYearWithBudgetAmount table
ALTER TABLE MovieWasReleasedInYearWithBudgetAmount ADD CONSTRAINT MovieWasReleasedInYearWithBudgetAmount_FK FOREIGN KEY (movieId) REFERENCES Movie (movieId) ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Data Insertion

-- Allow identity inserts for Movie and MovieWasReleasedInYearWithBudgetAmount tables
SET IDENTITY_INSERT Movie ON;
SET IDENTITY_INSERT MovieWasReleasedInYearWithBudgetAmount ON;

-- Insert data into the Director table
INSERT INTO Director (directorName, countryName)
VALUES
    ('Frank Darabont', 'United States'),
    ('Francis Ford Coppola', 'United States'),
    ('Christopher Nolan', 'United Kingdom'),
    ('Bong Joon Ho', 'South Korea'),
    ('Ramesh Sippy', 'India');

-- Insert data into the Production table
INSERT INTO Production (productionName, countryName)
VALUES
    ('Hollywood Rental Company', 'United States'),
    ('Paramount', 'United States'),
    ('Warner Bros', 'United States'),
    ('Barunson E&A', 'South Korea'),
    ('Sippy Films Pvt Ltd', 'India');

-- Insert data into the Movie table
INSERT INTO Movie (movieId, amount, movieName, categoryName, directorName, productionName)
VALUES
    (001, 28340000, 'The Shawshank Redemption', 'Drama', 'Frank Darabont', 'Hollywood Rental Company'),
    (002, 134970000, 'The Godfather', 'Crime', 'Francis Ford Coppola', 'Paramount'),
    (003, 534860000, 'The Dark Knight', 'Action', 'Christopher Nolan', 'Warner Bros'),
    (004, 292580000, 'Inception', 'Sci-Fi', 'Christopher Nolan', 'Warner Bros'),
    (005, 53370000, 'Parasite', 'Comedy', 'Bong Joon Ho', 'Barunson E&A'),
    (006, 39150000, 'Sholay', 'Drama', 'Ramesh Sippy', 'Sippy Films Pvt Ltd');

-- Insert data into the LeadActor table
INSERT INTO LeadActor (leadActorName, countryName)
VALUES
    ('Tim Robbins', 'United States'),
    ('Marlon Brando', 'United States'),
    ('Christian Bale', 'United Kingdom'),
    ('Leonardo DiCaprio', 'United States'),
    ('Kang-ho Song', 'South Korea'),
    ('Amitabh Bachchan', 'India');

-- Insert data into the MaleActor table
INSERT INTO MaleActor (maleActorName)
VALUES
    ('Tim Robbins'),
    ('Marlon Brando'),
    ('Christian Bale'),
    ('Leonardo DiCaprio'),
    ('Kang-ho Song'),
    ('Amitabh Bachchan');

-- Insert data into the LeadActorActedInMovie table
INSERT INTO LeadActorActedInMovie (leadActorName, movieId)
VALUES
    ('Tim Robbins', 001),
    ('Marlon Brando', 002),
    ('Christian Bale', 003),
    ('Leonardo DiCaprio', 004),
    ('Kang-ho Song', 005),
    ('Amitabh Bachchan', 006);

-- Insert data into the MovieWasReleasedInYearWithBudgetAmount table
INSERT INTO MovieWasReleasedInYearWithBudgetAmount (movieId, "year", amount)
VALUES
    (001, '1994', 25000000),
    (002, '1972', 6000000),
    (003, '2008', 185000000),
    (004, '2010', 160000000),
    (005, '2019', 11400000),
    (006, '1975', 75000);

-- Disable identity inserts for Movie and MovieWasReleasedInYearWithBudgetAmount tables
SET IDENTITY_INSERT Movie OFF;
SET IDENTITY_INSERT MovieWasReleasedInYearWithBudgetAmount OFF;

-- Insert data into the MovieHasRating table (assuming it exists)
INSERT INTO MovieHasRating (movieId, ratingNr)
VALUES
    (001, 1),
    (002, 2),
    (003, 5),
    (004, 4),
    (005, 1),
    (006, 5);

---Trigger to Calculate Total Budget by Production
CREATE TRIGGER UpdateProductionTotalBudget
ON Movie
AFTER INSERT, UPDATE
AS
BEGIN
    UPDATE Production
    SET TotalBudget = (
        SELECT SUM(amount)
        FROM Movie
        WHERE Movie.productionName = Production.productionName
    )
    FROM Production
    WHERE Production.productionName IN (
        SELECT productionName
        FROM inserted
    );
END;

---Stored Procedure to Retrieve Movies by Director:
CREATE PROCEDURE GetMoviesByDirector
    @DirectorName nvarchar(100)
AS
BEGIN
    SELECT movieName
    FROM Movie
    WHERE directorName = @DirectorName;
END;

---Trigger to Enforce Maximum Movie Budget
CREATE TRIGGER EnforceMaximumMovieBudget
ON Movie
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @MaxBudget decimal(19, 4) = 500000000; -- Set the maximum budget

    IF EXISTS (SELECT 1 FROM inserted WHERE amount > @MaxBudget)
    BEGIN
        RAISEERROR('Budget exceeds the maximum allowed amount.', 16, 1);
        ROLLBACK TRANSACTION;
    END;
END;


---Stored Procedure to Add a New Lead Actor
CREATE PROCEDURE AddNewLeadActor
    @LeadActorName nvarchar(100),
    @CountryName nvarchar(100)
AS
BEGIN
    INSERT INTO LeadActor (leadActorName, countryName)
    VALUES (@LeadActorName, @CountryName);
END;


---Trigger to Audit Movie Inserts:

CREATE TABLE MovieAudit (
    AuditId int IDENTITY(1, 1) PRIMARY KEY,
    Action nvarchar(20),
    MovieName nvarchar(100),
    InsertedDate datetime
);

CREATE TRIGGER AuditMovieInsert
ON Movie
AFTER INSERT
AS
BEGIN
    INSERT INTO MovieAudit (Action, MovieName, InsertedDate)
    SELECT 'INSERT', movieName, GETDATE()
    FROM inserted;
END;

