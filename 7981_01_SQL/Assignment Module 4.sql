/*Module 4*/
use assignment;

/*1st Ans*/
SELECT 
    cust_id, COUNT(*)
FROM
    account
GROUP BY cust_id;

/*2nd Ans*/
SELECT 
    cust_id, COUNT(*)
FROM
    account
GROUP BY cust_id
HAVING COUNT(*) > 2;

/*3rd Ans*/
SELECT 
    fname, birth_date
FROM
    individual
ORDER BY birth_date DESC;

/*4th Ans*/
SELECT 
    YEAR(open_date), AVG(avail_balance)
FROM
    account
GROUP BY YEAR(open_date)
HAVING AVG(avail_balance) > 2000
ORDER BY YEAR(open_date);

/*5th Ans*/
SELECT 
    product_cd, MAX(pending_balance)
FROM
    account
WHERE
    product_cd IN ('CHK' , 'SAV', 'CD')
GROUP BY product_cd;
