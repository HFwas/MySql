#二）非等值连接

#案例：查询员工的工资级别
SELECT * FROM sal_grade;

SELECT `salary`,`grade_level`
FROM employees e
JOIN `job_grades` g
ON e.`salary` BETWEEN `lowest_sal` AND g.`highest_sal`;

#查询工资级别>20的个数，并且按工资级别降序
SELECT COUNT(*),`grade_level`
FROM employees e
JOIN `job_grades` g
ON e.`salary` BETWEEN `lowest_sal` AND g.`highest_sal`
WHERE e.`salary` BETWEEN g.`lowest_sal` AND g.`highest_sal`
GROUP BY `grade_level`
HAVING COUNT(*)>20
ORDER BY `grade_level` DESC;

#三）自连接

#案例：查询员工名和对应的领导名

SELECT e.`last_name`,m.`last_name`
FROM `employees` e
INNER JOIN `employees` m
ON e.`manager_id`=m.`employee_id`;

#案例：查询员工名包含字符k的员工的名字和对应的领导名

SELECT e.`last_name`,m.`last_name`
FROM `employees` e
INNER JOIN `employees` m
ON e.`manager_id`=m.`employee_id`
WHERE e.`last_name` LIKE '%k%';

#二、外连接

/*

说明：查询结果为主表中所有的记录，如果从表有匹配项，则显示匹配项；如果从表没有匹配项，则显示null

应用场景：一般用于查询主表中有但从表没有的记录

特点：

1、外连接分主从表，两表的顺序不能任意调换
2、左连接的话，left join左边为主表
   右连接的话，right join右边为主表
   

语法：

select 查询列表
from 表1 别名
left|right|full 【outer】 join 表2 别名
on 连接条件
where 筛选条件;

*/
USE girls;
#案例1：查询所有女神记录，以及对应的男神名，如果没有对应的男神，则显示为null
#左连接
SELECT b.*,bo.*
FROM beauty b
LEFT JOIN boys bo ON b.`boyfriend_id` = bo.`id`;

#右连接
SELECT b.*,bo.*
FROM boys bo
RIGHT JOIN  beauty b ON b.`boyfriend_id` = bo.`id`;


#案例2：查哪个女神没有男朋友

#左连接
SELECT b.`name`
FROM beauty b
LEFT JOIN boys bo ON b.`boyfriend_id` = bo.`id`
WHERE bo.`id`  IS NULL;

#右连接
SELECT b.*,bo.*
FROM boys bo
RIGHT JOIN  beauty b ON b.`boyfriend_id` = bo.`id`
WHERE bo.`id`  IS NULL;


#案例3：查询哪个部门没有员工，并显示其部门编号和部门名

SELECT d.*,e.`employee_id`
FROM departments d
LEFT JOIN employees e ON d.`department_id` = e.`department_id`
WHERE e.`employee_id` IS NULL;

#全外连接


#交叉连接
SELECT b.*,bo.*
FROM `beauty` b
CROSS JOIN `boys` bo;