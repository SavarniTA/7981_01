/*Module 3*/
use assignment;

/*1st Ans*/
SELECT 
    COUNT(*)
FROM
    account;

/*2nd Ans*/
SELECT 
    *
FROM
    account
LIMIT 2;

/*3rd Ans*/
SELECT 
    *
FROM
    account
LIMIT 2 OFFSET 2;

/*4th Ans*/
SELECT 
    YEAR(birth_date),
    MONTH(birth_date),
    DAY(birth_date),
    WEEKDAY(birth_date)
FROM
    individual;

/*5th Ans*/
SELECT 
    SUBSTRING('Please find the substring in this string',
        17,
        9);

/*6th Ans*/
SELECT SIGN(25.76823);
SELECT ROUND(25.76823);

/*7th Ans*/
SELECT date_add(curdate(),interval 30 day);

/*8th Ans*/
SELECT 
    LEFT(fname, 3), RIGHT(lname, 3)
FROM
    individual;

/*9th Ans*/
SELECT 
    UCASE(fname)
FROM
    individual
WHERE
    LENGTH(fname) = 5;

/*10th Ans*/
SELECT 
    MAX(avail_balance), AVG(avail_balance)
FROM
    account
WHERE
    cust_id = 1;


