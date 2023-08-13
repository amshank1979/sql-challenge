-- Create table and view column datatypes
CREATE TABLE dept_emp (
	emp_no VARCHAR,
	dept_no VARCHAR,
	foreign key (dept_no) references departments (dept_no)
);

SELECT * FROM dept_emp;

CREATE TABLE departments (
	dept_no VARCHAR not null,
	primary key (dept_no),
	dept_name VARCHAR
	
);

SELECT * FROM departments;

CREATE TABLE dept_manager (
	dept_no VARCHAR not null,
	emp_no VARCHAR,
	primary key (emp_no)
	
);

SELECT * FROM dept_manager;

CREATE TABLE employees (
	emp_no VARCHAR not null,
	emp_title VARCHAR,
	birth_date VARCHAR,
	first_name VARCHAR,
	last_name VARCHAR,
	sex VARCHAR,
	hire_date DATE
		
);

SELECT * FROM employees;

CREATE TABLE salaries (
	emp_no VARCHAR not null,
	salary VARCHAR

);

SELECT * FROM salaries;

CREATE TABLE titles (
	title_id VARCHAR,
	title VARCHAR
	
);

SELECT * FROM titles

-- List the employee number, last name, first name, sex, and salary of each employee.
SELECT emp_no, last_name, first_name, sex, salary
FROM employees
JOIN salaries USING (emp_no);

-- List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date between '1986-01-01' and '1986-12-31';

--List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
SELECT 
    e.emp_no,
    e.last_name,
    e.first_name,
    de.dept_no,
    d.dept_name
FROM 
    employees e
JOIN 
    dept_emp de ON e.emp_no = de.emp_no
JOIN 
    departments d ON de.dept_no = d.dept_no;

-- List the manager of each department along with their department number, department name, employee number, last name, and first name.
SELECT 
	dept_manager.dept_no,
	dept_manager.emp_no,
	departments.dept_name,
	employees.first_name,
	employees.last_name
FROM dept_manager
	LEFT OUTER JOIN employees using(emp_no)
	LEFT OUTER JOIN departments using(dept_no)
order by
	dept_no ASC

--List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%';

--List each employee in the Sales department, including their employee number, last name, and first name.

SELECT 
    employees.emp_no,
    employees.last_name,
    employees.first_name,
	employees.emp_title,
	departments.dept_no
FROM 
    employees
INNER JOIN
	dept_emp ON (employees.emp_no = dept_emp.emp_no)
INNER JOIN 
    departments on (dept_emp.dept_no = departments.dept_no)
WHERE 
    departments.dept_no = 'd007';

-- List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT 
    employees.emp_no,
    employees.last_name,
    employees.first_name,
	employees.emp_title,
	departments.dept_no
FROM 
    employees
INNER JOIN
	dept_emp ON (employees.emp_no = dept_emp.emp_no)
INNER JOIN 
    departments on (dept_emp.dept_no = departments.dept_no)
WHERE 
    departments.dept_no IN ('d007','d005')

-- List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).

SELECT last_name, COUNT(*) as frequency
FROM employees
GROUP BY last_name
ORDER BY frequency DESC;

