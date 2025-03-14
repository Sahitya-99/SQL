# Oracle SQL Analytical and Window Function Queries for Employee Table

```sql
-- 1. Find the total number of employees in each department.
-- Counts employees for each department using GROUP BY.
SELECT department_id, COUNT(*) AS total_employees
FROM employees
GROUP BY department_id;

-- 2. Calculate the average salary in each department.
-- Computes the average salary for each department.
SELECT department_id, AVG(salary) AS avg_salary
FROM employees
GROUP BY department_id;

-- 3. Find the department with the highest total salary.
-- Summarizes total salaries per department and selects the highest one.
SELECT department_id, SUM(salary) AS total_salary
FROM employees
GROUP BY department_id
ORDER BY total_salary DESC
FETCH FIRST 1 ROW ONLY;

-- 4. Determine the highest and lowest salaries for each job role.
-- Finds the highest and lowest salary within each job role.
SELECT job_id, MAX(salary) AS max_salary, MIN(salary) AS min_salary
FROM employees
GROUP BY job_id;

-- 5. Find the number of employees hired in each year.
-- Extracts year from hire_date and counts employees hired per year.
SELECT EXTRACT(YEAR FROM hire_date) AS hire_year, COUNT(*) AS total_employees
FROM employees
GROUP BY EXTRACT(YEAR FROM hire_date)
ORDER BY hire_year;

-- 6. Assign a rank to employees based on their salary within each department.
-- Uses RANK() to assign ranks based on salary in each department.
SELECT department_id, employee_id, salary, 
       RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS salary_rank
FROM employees;

-- 7. Find the top 3 highest-paid employees in each department.
-- Uses RANK() to rank employees based on salary and filters top 3.
SELECT department_id, employee_id, salary
FROM (
    SELECT department_id, employee_id, salary, 
           RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS salary_rank
    FROM employees
) WHERE salary_rank <= 3;

-- 8. Identify the second highest salary in each department using DENSE_RANK().
-- Uses DENSE_RANK() to identify employees with the second-highest salary per department.
SELECT department_id, employee_id, salary
FROM (
    SELECT department_id, employee_id, salary, 
           DENSE_RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS salary_rank
    FROM employees
) WHERE salary_rank = 2;

-- 9. Compute the cumulative total salary of employees ordered by hire date.
-- Uses SUM() OVER() to create a running total of salaries.
SELECT employee_id, hire_date, salary, 
       SUM(salary) OVER (ORDER BY hire_date) AS cumulative_salary
FROM employees;

-- 10. Assign a row number to each employee in each department.
-- Uses ROW_NUMBER() to assign a unique row number per department.
SELECT department_id, employee_id, 
       ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY employee_id) AS row_num
FROM employees;

-- 11. Find the salary difference between each employee and the next highest-paid employee.
-- Uses LEAD() to compare an employee's salary with the next highest.
SELECT employee_id, salary, 
       LEAD(salary) OVER (ORDER BY salary DESC) - salary AS salary_diff
FROM employees;

-- 12. Calculate the previous month’s salary for each employee using LAG().
-- Uses LAG() to get the previous salary entry for each employee.
SELECT employee_id, salary, hire_date, 
       LAG(salary) OVER (PARTITION BY employee_id ORDER BY hire_date) AS prev_salary
FROM employees;

-- 13. Identify employees whose salaries increased over time.
-- Uses LAG() to compare an employee's current and previous salaries.
SELECT employee_id, hire_date, salary, 
       LAG(salary) OVER (PARTITION BY employee_id ORDER BY hire_date) AS prev_salary,
       CASE WHEN salary > LAG(salary) OVER (PARTITION BY employee_id ORDER BY hire_date) 
            THEN 'Increased' ELSE 'Decreased' END AS salary_trend
FROM employees;

-- 14. Find the average salary of employees who joined in each year.
-- Computes average salary grouped by year of hire.
SELECT EXTRACT(YEAR FROM hire_date) AS hire_year, AVG(salary) AS avg_salary
FROM employees
GROUP BY EXTRACT(YEAR FROM hire_date)
ORDER BY hire_year;

-- 15. Count the number of employees in each job role.
-- Counts employees for each job role using GROUP BY.
SELECT job_id, COUNT(*) AS total_employees
FROM employees
GROUP BY job_id;

-- 16. Find the total salary expenditure for each manager's team.
-- Sums salaries of employees under each manager.
SELECT manager_id, SUM(salary) AS total_team_salary
FROM employees
GROUP BY manager_id;

-- 17. Find the highest-paid employee in each department.
-- Uses RANK() to find the highest-paid employee in each department.
SELECT department_id, employee_id, salary
FROM (
    SELECT department_id, employee_id, salary,
           RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS salary_rank
    FROM employees
) WHERE salary_rank = 1;

-- 18. Calculate the running total of salaries for employees hired in each department.
-- Uses SUM() OVER() to compute cumulative salary totals.
SELECT department_id, employee_id, salary, 
       SUM(salary) OVER (PARTITION BY department_id ORDER BY hire_date) AS running_total
FROM employees;

-- 19. Find the employees who earn above the average salary of their department.
-- Uses a subquery to filter employees earning above department average.
SELECT employee_id, department_id, salary
FROM employees e
WHERE salary > (SELECT AVG(salary) FROM employees WHERE department_id = e.department_id);

-- 20. Rank employees within their department based on experience.
-- Uses RANK() to order employees by hire date per department.
SELECT employee_id, department_id, hire_date, 
       RANK() OVER (PARTITION BY department_id ORDER BY hire_date ASC) AS experience_rank
FROM employees;

-- 21. Find the difference between each employee’s salary and the department average.
-- Uses AVG() OVER() to compute salary difference from department average.
SELECT employee_id, department_id, salary, 
       salary - AVG(salary) OVER (PARTITION BY department_id) AS salary_diff
FROM employees;

-- 22. Find the department where the most employees have been hired.
-- Counts employees in each department and selects the highest.
SELECT department_id, COUNT(*) AS total_hired
FROM employees
GROUP BY department_id
ORDER BY total_hired DESC
FETCH FIRST 1 ROW ONLY;

-- 23. Identify employees who were hired in the same month and year as someone else.
-- Uses COUNT() OVER() to count employees hired in the same month-year.
SELECT employee_id, hire_date, 
       COUNT(*) OVER (PARTITION BY EXTRACT(MONTH FROM hire_date), EXTRACT(YEAR FROM hire_date)) AS same_month_hires
FROM employees;

-- 24. Calculate the moving average salary over the last 3 employees ordered by hire date.
-- Uses AVG() OVER() with ROWS BETWEEN for moving average calculation.
SELECT employee_id, hire_date, salary, 
       AVG(salary) OVER (ORDER BY hire_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS moving_avg_salary
FROM employees;

-- 25. Find employees whose salary is greater than that of the average of their manager’s team.
-- Uses a subquery to compare employee salary with manager's team average.
SELECT e.employee_id, e.manager_id, e.salary
FROM employees e
WHERE e.salary > (SELECT AVG(salary) FROM employees WHERE manager_id = e.manager_id);
