/*Module 5*/
SELECT 
    fname, title, name
FROM
    employee
        JOIN
    department ON employee.dept_id = department.dept_id;

/*2nd Ans*/
SELECT 
    product_type.name, product.name
FROM
    product_type
        LEFT JOIN
    product ON product_type.product_type_cd = product.product_type_cd;

/*3rd Ans*/
SELECT 
    CONCAT(a.fname, ' ', a.lname) AS ename,
    CONCAT(b.fname, ' ', b.lname) AS sname
FROM
    employee a
        JOIN
    employee b ON a.superior_emp_id = b.emp_id;

/*4th Ans*/
SELECT 
    fname, lname
FROM
    employee
WHERE
    superior_emp_id = (SELECT 
            emp_id
        FROM
            employee
        WHERE
            fname = 'Susan' AND lname = 'Hawthorne');

/*5th Ans*/
SELECT 
    fname, lname
FROM
    employee
WHERE
    emp_id IN (SELECT 
            superior_emp_id
        FROM
            employee
        WHERE
            dept_id = 1);
