-- QUESTION 02: Employees Earning More Than Their Direct Managers

-- Scenario Description: A corporate audit team suspects salary discrepancies 
-- across hierarchical levels. You are provided an `employees` table containing 
-- `emp_id`, `emp_name`, `salary`, and `manager_id`. Write an SQL query to find 
-- the names of all employees who earn strictly more than their direct manager, 
-- along with their salary, their manager's name, and the manager's salary.

mysql> use practicedb;
Database changed
mysql> show tables;
-- +----------------------+
-- | Tables_in_practicedb |
-- +----------------------+
-- | employees            |
-- +----------------------+
-- 1 row in set (0.01 sec)

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
-- 5 rows in set (0.03 sec)

mysql> alter table employees
    -> add column manager_id int ;
Query OK, 0 rows affected (0.08 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> desc employees
    -> ;
-- +-----------------+-------------+------+-----+---------+-------+
-- | Field           | Type        | Null | Key | Default | Extra |
-- +-----------------+-------------+------+-----+---------+-------+
-- | emp_id          | int         | NO   | PRI | NULL    |       |
-- | emp_name        | varchar(30) | NO   |     | NULL    |       |
-- | department_name | varchar(20) | NO   |     | NULL    |       |
-- | salary          | double      | YES  |     | NULL    |       |
-- | status          | varchar(30) | YES  |     | NULL    |       |
-- | manager_id      | int         | YES  |     | NULL    |       |
-- +-----------------+-------------+------+-----+---------+-------+
-- 6 rows in set (0.01 sec)


mysql> select * from employees;
-- +--------+-----------------+-----------------+--------+------------+------------+
-- | emp_id | emp_name        | department_name | salary | status     | manager_id |
-- +--------+-----------------+-----------------+--------+------------+------------+
-- |    101 | Alice Johnson   | Engineering     |  85000 | Active     |       NULL |
-- |    102 | Bob Smith       | Engineering     |  92000 | Active     |       NULL |
-- |    103 | Charlie Brown   | Engineering     |  78000 | Active     |       NULL |
-- |    104 | Diana Prince    | Engineering     |  65000 | Active     |       NULL |
-- |    105 | Evan Wright     | Marketing       |  55000 | Active     |       NULL |
-- |    106 | Fiona Gallagher | Marketing       |  62000 | Active     |       NULL |
-- |    107 | George Clark    | HR              |  50000 | Active     |       NULL |
-- |    108 | Hannah Abbott   | HR              |  52000 | Terminated |       NULL |
-- +--------+-----------------+-----------------+--------+------------+------------+
-- 8 rows in set (0.00 sec)

mysql> update employees
    -> set manager_id=4
    -> where emp_id=102;
Query OK, 1 row affected (0.01 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> update employees
    -> set manager_id=3
    -> where emp_id=105;
Query OK, 1 row affected (0.01 sec)
Rows matched: 1  Changed: 1  Warnings: 0

-- mysql> select * from employees;
-- +--------+-----------------+-----------------+--------+------------+------------+
-- | emp_id | emp_name        | department_name | salary | status     | manager_id |
-- +--------+-----------------+-----------------+--------+------------+------------+
-- |    101 | Alice Johnson   | Engineering     |  85000 | Active     |       NULL |
-- |    102 | Bob Smith       | Engineering     |  92000 | Active     |          4 |
-- |    103 | Charlie Brown   | Engineering     |  78000 | Active     |       NULL |
-- |    104 | Diana Prince    | Engineering     |  65000 | Active     |       NULL |
-- |    105 | Evan Wright     | Marketing       |  55000 | Active     |          3 |
-- |    106 | Fiona Gallagher | Marketing       |  62000 | Active     |       NULL |
-- |    107 | George Clark    | HR              |  50000 | Active     |       NULL |
-- |    108 | Hannah Abbott   | HR              |  52000 | Terminated |       NULL |
-- +--------+-----------------+-----------------+--------+------------+------------+
-- 8 rows in set (0.00 sec)

mysql> update employees
    -> set manager_id=1
    -> where emp_id=101;
Query OK, 1 row affected (0.01 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> select * from employees;
-- +--------+-----------------+-----------------+--------+------------+------------+
-- | emp_id | emp_name        | department_name | salary | status     | manager_id |
-- +--------+-----------------+-----------------+--------+------------+------------+
-- |    101 | Alice Johnson   | Engineering     |  85000 | Active     |          1 |
-- |    102 | Bob Smith       | Engineering     |  92000 | Active     |          4 |
-- |    103 | Charlie Brown   | Engineering     |  78000 | Active     |       NULL |
-- |    104 | Diana Prince    | Engineering     |  65000 | Active     |       NULL |
-- |    105 | Evan Wright     | Marketing       |  55000 | Active     |          3 |
-- |    106 | Fiona Gallagher | Marketing       |  62000 | Active     |       NULL |
-- |    107 | George Clark    | HR              |  50000 | Active     |       NULL |
-- |    108 | Hannah Abbott   | HR              |  52000 | Terminated |       NULL |
-- +--------+-----------------+-----------------+--------+------------+------------+
-- 8 rows in set (0.00 sec)