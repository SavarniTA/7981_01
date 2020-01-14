/* Module 1*/
/*1st Ans*/
create database training;

use training;

/*2nd Ans*/
CREATE TABLE demography (
    CustID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(50),
    Age INT,
    Gender VARCHAR(1)
);

/*3rd Ans*/
insert into demography values
(CustID=1,Name='John',Age=25,Gender='M');

/*4th Ans*/
insert into demography 
(Name,Age,Gender) 
values 
('Pawan',26,'M'),
('Hema',28,'F');

/*5th Ans*/
insert into demography 
(Name,Gender) 
values 
('Rekha','F');

/*6th Ans*/
SELECT 
    *
FROM
    demography;

/*7th Ans*/
UPDATE demography 
SET 
    Age = NULL
WHERE
    Name = 'John';

/*8th Ans*/
SELECT 
    *
FROM
    demography
WHERE
    Age = NULL;

/*9th Ans*/
truncate demography;

/*10th Ans*/
drop table demography;
