DROP TABLE IF EXISTS departments;

DROP TABLE IF EXISTS dept_empl;

DROP TABLE IF EXISTS dept_manager;

DROP TABLE IF EXISTS employees;

DROP TABLE IF EXISTS salaries;

DROP TABLE IF EXISTS titles;

-- create table departments with columns dept_no	dept_name and import departments.csv

create table departments (
  dept_no character varying(6) PRIMARY KEY,
  dept_name character varying(50) NOT NULL
  );
  
Select * from departments LIMIT 5;
--create table employees with fields emp_no	birth_date	first_name	last_name	gender	hire_date

create table employees (
  emp_no SERIAL Primary Key,
  birth_date date,
  first_name character varying(50) NOT NULL,
  last_name character varying(50) NOT NULL,
  gender character varying (10),
  hire_date date
   );
-- create table titles with fields as emp_no	title	from_date	to_date
DROP TABLE IF EXISTS titles;
create table titles (
 titles_id SERIAL PRIMARY KEY,
 emp_no INT,
 title character varying(30) NOT NULL,
 from_date date ,
 to_date date, 
 FOREIGN KEY(emp_no) REFERENCES employees(emp_no)
	);
Select * from titles LIMIT 5;	

--create table dept_empl with datafields emp_no	dept_no	from_date	to_date

create table dept_empl (
  table_id SERIAL PRIMARY KEY,
  emp_no SERIAL  ,
  dept_no character varying(6) NOT NULL ,
  from_date date,
  to_date date
    );
SELECT * from dept_empl LIMIT 5; 
--create table dept_manager with fields dept_no	emp_no	from_date	to_date

create table dept_manager (
  dept_no character varying(6),
  emp_no SERIAL ,
  from_date date,
  to_date date
   );
  select * from Dept_manager LIMIT 5;

 -- create table salaries with fields emp_no	salary	from_date	to_date

 create table salaries (
  emp_no SERIAL PRIMARY KEY,
  salary INT,
  from_date date not null,
  to_date date , 
  FOREIGN KEY(emp_no) REFERENCES employees(emp_no) 
   );
   
select * from salaries LIMIT 5;

-- 1. List the following details of each employee: employee number, last name, first name, gender, and salary
SELECT employees.emp_no, employees.first_name, employees.last_name, employees.gender, salaries.salary
FROM employees INNER JOIN salaries 
ON employees.emp_no = salaries.emp_no
ORDER By employees.emp_no ;

--2. List employees who were hired in 1986.

SELECT emp.first_name, emp.last_name, emp.hire_date, emp.gender  
FROM employees emp 
where hire_date >= '1986-01-01' and hire_date < '1987-01-01';

--3. List the manager of each department with the following information: 
--department number, department name, the manager's employee number, last name, first name, and start and end employment dates.
-- tables to be used employees,  departments , dept_manager

SELECT dept.dept_no, dept.dept_name, dm.emp_no,emp.first_name, emp.last_name, dm.from_date, dm.to_date
FROM departments dept INNER JOIN dept_manager dm 
ON dept.dept_no = dm.dept_no
INNER JOIN employees emp 
ON dm.emp_no = emp.emp_no ; 

  
--4. List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT emp.emp_no,emp.last_name, emp.first_name, dept.dept_no, dept.dept_name 
FROM employees emp, departments dept, dept_empl
WHERE emp.emp_no = dept_empl.emp_no AND dept_empl.dept_no = dept.dept_no; 

--5. List all employees whose first name is "Hercules" and last names begin with "B."

SELECT * from employees where first_name ='Hercules' and last_name like 'B%';

--6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT emp.emp_no,emp.last_name, emp.first_name, dept.dept_name 
FROM employees emp, departments dept, dept_empl
WHERE emp.emp_no = dept_empl.emp_no AND dept_empl.dept_no = dept.dept_no
AND dept.dept_name = 'Sales';  

--7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT emp.emp_no,emp.last_name, emp.first_name, dept.dept_name 
FROM employees emp, departments dept, dept_empl
WHERE emp.emp_no = dept_empl.emp_no AND dept_empl.dept_no = dept.dept_no
AND (dept.dept_name = 'Sales' OR dept.dept_name = 'Development') order by emp.emp_no, dept_name;  

--8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name, COUNT(last_name) 
FROM employees GROUP BY last_Name
ORDER BY Count(last_name) DESC; 
