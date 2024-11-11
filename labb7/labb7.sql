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

INSERT INTO countries (name) VALUES
('Kazakhstan'),
('United Kingdom'),
('Germany'),
('Canada'),
('Australia');


INSERT INTO departments (department_name, budget) VALUES
('Human Resources', 500000),
('Finance', 1000000),
('Marketing', 750000),
('Engineering', 1200000),
('Sales', 600000);
INSERT INTO employees (first_name, last_name, email, phone_number, salary, department_id) VALUES
('John', 'Doe', 'john.doe@example.com', '123-456-7890', 55000, 1),  -- HR
('Jane', 'Smith', 'jane.smith@example.com', '987-654-3210', 65000, 2),  -- Finance
('Michael', 'Johnson', 'michael.johnson@example.com', '555-123-4567', 75000, 3),  -- Marketing
('Emily', 'Williams', 'emily.williams@example.com', '444-987-6543', 85000, 4),  -- Engineering
('David', 'Brown', 'david.brown@example.com', '333-222-1111', 70000, 5);  -- Sales

--1
CREATE INDEX name_index_countries ON countries(name);
SELECT * FROM countries WHERE name = 'Kazakhstan';

--2
CREATE INDEX employ_name_index ON employees(first_name, last_name);

    SELECT * FROM employees WHERE first_name = 'Michael'
    AND last_name = 'Johnson';

--3
CREATE INDEX employees_id_index ON employees(salary);

EXPLAIN SELECT * FROM employees WHERE salary < 10000000
    AND salary > 5000000;

--4
CREATE INDEX sub_name_index ON employees(substring(first_name FROM 1 FOR 4));

SELECT * FROM employees WHERE substring(first_name
                                        from 1 for 4) = 'Emil';
--5
CREATE INDEX employees_departments_salary_budget_index ON employees (department_id, salary);
CREATE INDEX departments_budget_index ON departments (department_id, budget);

SELECT * FROM employees e JOIN departments d
ON d.department_id = e.department_id
WHERE d.budget > 5000000 AND e.salary < 45060000;

