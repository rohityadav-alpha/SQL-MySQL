-- QUESTION 01: Department-Wise Salary Aggregation & High-Expense Filter

-- Scenario Description: An enterprise HR operations team wants to identify departments that have more than 3 active employees and an average salary exceeding $60,000. You are given an `employees` table. Write a query to return the `department_name`, the total employee count, and the rounded average salary for only qualifying departments, sorted by average salary in descending order.



mysql> create database practicedb;
Query OK, 1 row affected (0.02 sec)

mysql> use practicedb
Database changed
mysql> ;
ERROR:
No query specified

mysql> create table employees (emp_id int not null primary key, emp_name varchar(30) not null, department_name varchar(20) not null, salary int, status varchar(30));
Query OK, 0 rows affected (0.04 sec)

mysql> desc employees;
-- +-----------------+-------------+------+-----+---------+-------+
-- | Field           | Type        | Null | Key | Default | Extra |
-- +-----------------+-------------+------+-----+---------+-------+
-- | emp_id          | int         | NO   | PRI | NULL    |       |
-- | emp_name        | varchar(30) | NO   |     | NULL    |       |
-- | department_name | varchar(20) | NO   |     | NULL    |       |
-- | salary          | int         | YES  |     | NULL    |       |
-- | status          | varchar(30) | YES  |     | NULL    |       |
-- +-----------------+-------------+------+-----+---------+-------+
-- 5 rows in set (0.01 sec)

mysql> insert into employees values(101,"Alice Johnson","Engineering",85000,"Active");
Query OK, 1 row affected (0.01 sec)

mysql> select * from employees;
-- +--------+---------------+-----------------+--------+--------+
-- | emp_id | emp_name      | department_name | salary | status |
-- +--------+---------------+-----------------+--------+--------+
-- |    101 | Alice Johnson | Engineering     |  85000 | Active |
-- +--------+---------------+-----------------+--------+--------+
-- 1 row in set (0.00 sec)

mysql> alter table employees
    -> modify column salary double;
Query OK, 1 row affected (0.07 sec)
Records: 1  Duplicates: 0  Warnings: 0

mysql> desc employees;
-- +-----------------+-------------+------+-----+---------+-------+
-- | Field           | Type        | Null | Key | Default | Extra |
-- +-----------------+-------------+------+-----+---------+-------+
-- | emp_id          | int         | NO   | PRI | NULL    |       |
-- | emp_name        | varchar(30) | NO   |     | NULL    |       |
-- | department_name | varchar(20) | NO   |     | NULL    |       |
-- | salary          | double      | YES  |     | NULL    |       |
-- | status          | varchar(30) | YES  |     | NULL    |       |
-- +-----------------+-------------+------+-----+---------+-------+
-- 5 rows in set (0.00 sec)

mysql> insert into employees values(102, 'Bob Smith', 'Engineering', 92000, 'Active'),
    -> (103, 'Charlie Brown', 'Engineering', 78000, 'Active'),
    -> (104, 'Diana Prince', 'Engineering', 65000, 'Active'),
    -> (105, 'Evan Wright', 'Marketing', 55000, 'Active'),
    -> (106, 'Fiona Gallagher', 'Marketing', 62000, 'Active'),
    -> (107, 'George Clark', 'HR', 50000, 'Active'),
    -> (108, 'Hannah Abbott', 'HR', 52000, 'Terminated');
Query OK, 7 rows affected (0.01 sec)
Records: 7  Duplicates: 0  Warnings: 0

mysql> select * from employees;
-- +--------+-----------------+-----------------+--------+------------+
-- | emp_id | emp_name        | department_name | salary | status     |
-- +--------+-----------------+-----------------+--------+------------+
-- |    101 | Alice Johnson   | Engineering     |  85000 | Active     |
-- |    102 | Bob Smith       | Engineering     |  92000 | Active     |
-- |    103 | Charlie Brown   | Engineering     |  78000 | Active     |
-- |    104 | Diana Prince    | Engineering     |  65000 | Active     |
-- |    105 | Evan Wright     | Marketing       |  55000 | Active     |
-- |    106 | Fiona Gallagher | Marketing       |  62000 | Active     |
-- |    107 | George Clark    | HR              |  50000 | Active     |
-- |    108 | Hannah Abbott   | HR              |  52000 | Terminated |
-- +--------+-----------------+-----------------+--------+------------+
-- 8 rows in set (0.00 sec)


mysql> select * from employees
    -> where status="Active";
-- +--------+-----------------+-----------------+--------+--------+
-- | emp_id | emp_name        | department_name | salary | status |
-- +--------+-----------------+-----------------+--------+--------+
-- |    101 | Alice Johnson   | Engineering     |  85000 | Active |
-- |    102 | Bob Smith       | Engineering     |  92000 | Active |
-- |    103 | Charlie Brown   | Engineering     |  78000 | Active |
-- |    104 | Diana Prince    | Engineering     |  65000 | Active |
-- |    105 | Evan Wright     | Marketing       |  55000 | Active |
-- |    106 | Fiona Gallagher | Marketing       |  62000 | Active |
-- |    107 | George Clark    | HR              |  50000 | Active |
-- +--------+-----------------+-----------------+--------+--------+
-- 7 rows in set (0.00 sec)


mysql> select round(avg(salary)) from employees;
-- +--------------------+
-- | round(avg(salary)) |
-- +--------------------+
-- |              67375 |
-- +--------------------+
-- 1 row in set (0.00 sec)

mysql> select department_name from employees
    -> group by department_name;
-- +-----------------+
-- | department_name |
-- +-----------------+
-- | Engineering     |
-- | Marketing       |
-- | HR              |
-- +-----------------+
-- 3 rows in set (0.00 sec)

mysql> select department_name from employees
    -> group by department_name
    -> having count(*)>3;
-- +-----------------+
-- | department_name |
-- +-----------------+
-- | Engineering     |
-- +-----------------+
-- 1 row in set (0.00 sec)


mysql> select department_name from employees
    -> group by department_name
    -> having count(department_name);
-- +-----------------+
-- | department_name |
-- +-----------------+
-- | Engineering     |
-- | Marketing       |
-- | HR              |
-- +-----------------+
-- 3 rows in set (0.00 sec)

mysql> select department_name, count(department_name) from employees
    -> group by department_name;
-- +-----------------+------------------------+
-- | department_name | count(department_name) |
-- +-----------------+------------------------+
-- | Engineering     |                      4 |
-- | Marketing       |                      2 |
-- | HR              |                      2 |
-- +-----------------+------------------------+
-- 3 rows in set (0.00 sec)

mysql> select department_name, count(*) as total_emp, round(avg(salary),2) as avg_salary
    -> from employees
    -> where status="Active"
    -> group by department_name
    -> having count(*)>3 and avg_salary>60000
    -> order by avg_salary desc;
-- +-----------------+-----------+------------+
-- | department_name | total_emp | avg_salary |
-- +-----------------+-----------+------------+
-- | Engineering     |         4 |      80000 |
-- +-----------------+-----------+------------+
-- 1 row in set (0.00 sec)
