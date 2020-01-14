/*Module 2*/

use assignment;

/*1st Ans */
SELECT 
    account_id, cust_id, avail_balance
FROM
    account
WHERE
    status = 'ACTIVE'
        AND avail_balance > 2500;

/*2nd Ans */
SELECT 
    *
FROM
    account
WHERE
    year(open_date) = '2002';

/*3rd Ans*/
SELECT 
    account_id, avail_balance, pending_balance
FROM
    account
WHERE
    avail_balance <> pending_balance;

/*4th Ans*/
SELECT 
    account_id, product_cd
FROM
    account
WHERE
    account_id IN (1 , 10, 23, 27);

/*5th Ans*/
SELECT 
    account_id, avail_balance
FROM
    account
WHERE
    avail_balance BETWEEN 100 AND 200;