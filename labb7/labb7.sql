CREATE DATABASE lab7;


CREATE TABLE countries(
    country_id SERIAL PRIMARY KEY,
    name VARCHAR(25)
);

CREATE TABLE departments(
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(50) UNIQUE,
    budget INT
);

CREATE TABLE employees(
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(50),
    phone_number VARCHAR(20),
    salary INT,
    department_id INT REFERENCES departments
);


--1
CREATE INDEX name_index_countries ON countries(name);
SELECT * FROM countries WHERE name = 'string';

--2
CREATE INDEX employ_name_index ON employees(first_name, last_name);

    SELECT * FROM employees WHERE first_name = 'string'
    AND last_name = 'string';

--3
CREATE INDEX employees_id_index ON employees(salary);

EXPLAIN SELECT * FROM employees WHERE salary < 10000000
    AND salary > 5000000;

--4
CREATE INDEX sub_name_index ON employees(substring(first_name FROM 1 FOR 4));

SELECT * FROM employees WHERE substring(first_name
                                        from 1 for 4) = 'abcd';
--5
CREATE INDEX employees_departments_salary_budget_index ON employees (department_id, salary);
CREATE INDEX departments_budget_index ON departments (department_id, budget);

SELECT * FROM employees e JOIN departments d
ON d.department_id = e.department_id
WHERE d.budget > 5000000 AND e.salary < 45060000;

