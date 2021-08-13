CREATE DATABASE LIBRARY; #Creating the database

################## Creating and populating the tables 
DROP TABLE Math;
DROP TABLE Literature;
DROP TABLE Historical;

CREATE TABLE Math (
    ID INT NOT NULL PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    Author VARCHAR(255),
    Descrip VARCHAR(255),
    Published INT(255)
);

INSERT INTO Math (ID, Title, Author, Descrip, Published)
VALUES 
       ('1', 'Linear Algebra', 'G.S','LA',1998),
       ('2', 'Calculus', 'G.S','C',1999),
       ('3', 'Geometry', 'G.S','G',1967),
       ('4', 'Number Theory', 'G.S','N.T',1996),
       ('5', 'Probability and Statistics', 'G.S','P.S',2005);
       
CREATE TABLE Literature (
    ID INT NOT NULL PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    Author VARCHAR(255),
    Descrip VARCHAR(255),
    Published INT(255)
);

INSERT INTO Literature (ID, Title, Author, Descrip, Published)
VALUES 
       ('1', 'Pride and Prejudice', 'Jane Austen','PP',1813),
       ('2', 'To kill a Mockinbird', 'Harper Lee','KM',1960),
       ('3', 'One Hundred Years of Solitude', 'GG','OHS',1967),
       ('4', 'Persuation', 'Jane Austen','P',1818),
       ('5', 'The Lion, the Witch and the Wardrobe', 'C.S.L','L.W.W',1950);

CREATE TABLE Historical (
    ID INT NOT NULL PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    Author VARCHAR(255),
    Descrip VARCHAR(255),
    Published INT(255)
);

INSERT INTO Historical (ID, Title, Author, Descrip, Published)
VALUES 
       ('1', 'Guns Germs and Steel', 'J.D','GGS',2006),
       ('2', 'Classical Hstory', 'GG','CH',1960),
       ('3', 'Ancient Rome', 'GG','AR',1967),
       ('4', 'Byzantine Empire', 'GG','BE',1960),
       ('5', 'Nordic Mythology', 'C.S.L','NM',1955);

################ Creating and populating a table of identical values between the two previous tables

CREATE TABLE Identical_values (
    TitleLit varchar(255) NOT NULL,
    PubLit varchar(255),
    TitleH varchar(255) NOT NULL,
    PubH varchar(255)
);   

    
INSERT INTO Identical_values 
 (SELECT Literature.Title,
    Literature.Published,
    Historical.Title,
    Historical.Published FROM
    Literature
        INNER JOIN
    Historical ON Literature.Author = Historical.Author
ORDER BY Literature.Published ASC);

############# Visualization of each table

USE LIBRARY; SELECT * FROM Math;
USE LIBRARY; SELECT * FROM Literature;
USE LIBRARY; SELECT * FROM Historical;
USE LIBRARY; SELECT * FROM Identical_values;

########################################### Iterating through each row of Literature and showing old books
DROP PROCEDURE Curs;
delimiter //  
CREATE PROCEDURE Curs()  
BEGIN  
DECLARE d INT DEFAULT 0;    
DECLARE counter INT default 0;
DECLARE Get_cur CURSOR FOR SELECT * FROM Literature.Published;  
DECLARE CONTINUE HANDLER FOR SQLSTATE '02000'  
SET d = 1;  
DECLARE CONTINUE HANDLER FOR SQLSTATE '23000'  
SET d = 1;  
  
OPEN Get_cur;  
lbl: LOOP  
IF d = 1 THEN  
LEAVE lbl;  
END IF;  
IF NOT d = 1 THEN  
   IF Get_cur<1960 THEN
      SET counter=counter +1;
   END IF;
   
END IF;  
END LOOP;  
SELECT @counter; 
CLOSE Get_cur;  
END;  
// 
