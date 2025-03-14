SELECT department_id,COUNT(*) AS Total_employees
FROM HR.employees
GROUP BY department_id;

##2 avg salary

SELECT department_id, AVG(salary) AS avg_salary
FROM HR.employees
GROUP BY department_id;


##3 max salary
SELECT department_id, MAX(salary) AS MAX_salary, MIN(salary) AS MIN_salary
FROM HR.employees
GROUP BY department_id;

###4 salary in each department
SELECT department_id,SUM(salary) AS Total_salary
FROM HR.employees
GROUP BY department_id;
 
####5 no . of emp 
SELECT JOB_ID,COUNT(*) AS Total_employees
FROM HR.employees
GROUP BY JOB_ID;

#6 avg salary in each role

SELECT JOB_ID,AVG(salary) AS AVG_salary
FROM HR.employees
GROUP BY JOB_ID;

#7 max salary for each role
SELECT JOB_ID,MAX(salary) AS MAX_salary
FROM HR.employees
GROUP BY JOB_ID;


#8 MIN 


SELECT JOB_ID,MIN(salary) AS MIN_salary
FROM HR.employees
GROUP BY JOB_ID;


#9 Total_salary

SELECT JOB_ID,SUM(salary) AS Total_salary
FROM HR.employees
GROUP BY JOB_ID;



#10Count the number of employees hired in each year

SELECT EXTRACT(YEAR FROM hire_date) as hire_year, COUNT(*) as Total_employees
FROM HR.employees
GROUP BY EXTRACT(YEAR FROM hire_date)
ORDER BY hire_year ;


#11 Find the total salary paid in each location

SELECT d.location_id,SUM(e.salary) as Total_salary
FROM HR.employees e
JOIN departments d on e.department_id=d.department_id
GROUP BY d.location_id;


###12 

SELECT manager_id,COUNT(*) AS team_size 
FROM HR.employees
WHERE manager_id IS NOT NULL 
GROUP BY manager_id;


#13


SELECT manager_id , MAX(salary) AS MAX_salary
FROM HR.employees
WHERE manager_id IS NOT NULL 
GROUP BY manager_id;


#14 
SELECT manager_id,avg(salary) AS avg_salary
FROM HR.employees
WHERE manager_id IS NOT NULL 
GROUP BY manager_id;



#15
SELECT EXTRACT(MONTH FROM hire_date),COUNT(*) AS Total_hired
FROM HR.employees
GROUP BY EXTRACT(MONTH FROM hire_date)
ORDER BY hire_month;



#16 
SELECT DEPARTMENT_ID,SUM(salary) as total_salary
FROM HR.employees
GROUP BY department_id
ORDER BY total_salary DESC
FETCH FIRST 1 ROW ONLY;



#17 
SELECT JOB_ID,AVG(salary) as AVG_salary
FROM HR.employees
GROUP BY JOB_ID
ORDER BY avg_salary DESC



#18
