# Project - ScienceQtech Employee Performance Mapping
# Creating a database named employees
create database	employees;

show databases;
# Making employees defalult database

use employees;
# Importing tables data_science_team, emp_record_table, proj_table

select * from data_science_team;

select * from emp_record_table;

SHOW PROCESSLIST;
kill 16;

select * from proj_table;

/* Fetching EMP_ID, FIRST_NAME, LAST_NAME, GENDER, and DEPARTMENT from the employee
record table.*/
select emp_id, first_name, last_name, gender, dept from emp_record_table;

/*Writing a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPARTMENT, and EMP_RATING if
the EMP_RATING is:less than two*/

select emp_id, first_name, last_name, concat('first_name', '', 'last_name') as 
full_name, gender, dept, emp_rating from emp_record_table
where emp_rating < 2 order by full_name;

/*Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPARTMENT, and EMP_RATING if
the EMP_RATING is:greater than four*/
select emp_id, first_name, last_name, concat('first_name', '', 'last_name') as 
full_name, gender, dept, emp_rating from emp_record_table
where emp_rating > 4 order by full_name;

/*Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPARTMENT, and EMP_RATING if
the EMP_RATING is: between two and four*/

select emp_id, first_name, last_name, concat('first_name', '', 'last_name') as 
full_name, gender, dept, emp_rating from emp_record_table
where emp_rating between  2 and 4 order by full_name;


/*Writing a query to concatenate the FIRST_NAME and the LAST_NAME of employees in the Finance department
from the emp_record_table and then give the resultant column alias as full_name*/
select emp_id, first_name, last_name, concat(first_name, ' ', last_name) as full_name from emp_record_table
where dept = 'finance';


/*Write a query to list only those employees who have someone reporting to them. Also, show the number of
reporters (including the President).*/
select role, manager_id, count(role) from emp_record_table
GROUP BY manager_id
order by  manager_id;

/* Write a query to assign ranks to each employee based on their experience. Take data from the employee record
table.*/
SELECT first_name, last_name, exp as experience,
DENSE_RANK() OVER (ORDER BY exp DESC) exp_rank
FROM emp_record_table;

/*Write a query to create a view that displays employees in various countries whose salary is more than six
thousand. Take data from the employee record table.*/
CREATE VIEW 6K_salary AS
SELECT emp_id, first_name, last_name, country, salary
FROM emp_record_table
WHERE salary > 6000;
SELECT * FROM 6k_salary;

/*Write a nested query to find employees with experience of more than ten years. Take data from the employee
record table.*/
SELECT emp_id, first_name, last_name, exp
FROM emp_record_table
WHERE exp IN (
SELECT exp
FROM emp_record_table
WHERE exp > 10
);

/*Write a query to create a stored procedure to retrieve the details of the employees whose experience is more
than three years. Take data from the employee record table.*/
DELIMITER //
CREATE PROCEDURE Employee3()
BEGIN
SELECT * FROM emp_record_table
WHERE exp > 3;
END //
DELIMITER ;
CALL Employee3;

/*Write a query using stored functions in the project table to check whether the job profile assigned to each
employee in the data science team matches the organization’s set standard.*/
DELIMITER //

#Create an index to find the employee whose FIRST_NAME is ‘Eric’ in the employee table after checking the execution plan.
ALTER TABLE emp_record_table ADD INDEX fname_index (FIRST_NAME(50));
SELECT * FROM emp_record_table 
where	first_name = 'Eric';

/*Write a query to calculate the bonus for all the employees, based on their ratings and salaries.*/
select first_name, last_name, salary, ((salary * .05)*emp_rating) as bonus
from emp_record_table;

/* Write a query to calculate the average salary distribution based on the continent.*/
select continent, avg(salary)
from emp_record_table
group by continent
order by continent asc;

/* Write a query to calculate the average salary distribution based on the country.*/
select country, avg(salary)
from emp_record_table
group by country
order by country asc;









