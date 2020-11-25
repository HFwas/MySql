#1. 查询和 Zlotkey 相同部门的员工姓名和工资

#①查询Zlotkey的部门编号
SELECT department_id
FROM employees
WHERE last_name = 'Zlotkey'

#②查询department_id = ①的员工姓名和工资
SELECT last_name,salary
FROM employees
WHERE department_id = (
	SELECT department_id
	FROM employees
	WHERE last_name = 'Zlotkey'
);


#2. 查询工资比公司平均工资高的员工的员工号，姓名和工资。

#①查询平均工资
SELECT AVG(salary)
FROM employees

#②查询salary>①的信息
SELECT employee_id,last_name,salary
FROM employees
WHERE salary>(
	SELECT AVG(salary)
	FROM employees
);

#3.查询各部门中工资比本部门平均工资高的员工号，姓名，工资
SELECT 
  AVG(`salary`),
  `department_id` 
FROM
  `employees` 
GROUP BY `department_id` 
  SELECT 
    `employee_id`,
    `last_name`,
    `salary` `department_id` 
  FROM
    `employees` e 
    INNER JOIN 
      (SELECT 
        AVG(`salary`) a,
        `department_id` 
      FROM
        `employees` 
      GROUP BY `department_id`) ag 
      ON e.`department_id` = ag.`department_id` 
  WHERE e.`salary` > ag.a ;


#4.查询和姓名中包含字母u的员工在相同部门的员工的员工号和姓名
#第一步：查询姓名中包含u的员工的部门
SELECT DISTINCT `department_id`
FROM `employees` e
WHERE e.`last_name` LIKE '%u%'

#第二步：查询部门号=第一步中的任意一个的员工号和姓名
SELECT `employee_id`,`last_name` FROM `employees`
WHERE `department_id` IN (
	SELECT DISTINCT `department_id`
	FROM `employees` e
	WHERE e.`last_name` LIKE '%u%'
);


#5.查询在部门的location_id为1700的部门工作的员工的员工号
SELECT DISTINCT `department_id` FROM `departments`
WHERE `location_id`=1700;

SELECT DISTINCT `employee_id` FROM `employees`
WHERE `department_id` IN(
	SELECT `department_id` FROM `departments`
	WHERE `location_id`=1700
);

#6.查询管理者是King的员工姓名和工资
SELECT `employee_id` FROM `employees`
WHERE `last_name`='K_ing'

SELECT `last_name`,`salary` FROM `employees` WHERE 
`manager_id` IN(
	SELECT `employee_id` FROM `employees`
	WHERE `last_name`='K_ing'
);

#7.查询工资最高的员工的姓名，要求`first_name`和`last_name`显示为一列，列名为姓.名
SELECT MAX(`salary`) FROM `employees`

SELECT CONCAT(`first_name`,`last_name`) "姓.名" FROM `employees`
WHERE `salary`=(
	SELECT MAX(`salary`) FROM `employees`
);






