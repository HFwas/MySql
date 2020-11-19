#连接查询           SQL99语法

#一、内连接
语法：

SELECT 查询列表
FROM 表名1 别名
【INNER】 JOIN  表名2 别名
ON 连接条件
WHERE 筛选条件
GROUP BY 分组列表
HAVING 分组后筛选
ORDER BY 排序列表;


SQL92和SQL99的区别：

	SQL99，使用JOIN关键字代替了之前的逗号，并且将连接条件和筛选条件进行了分离，提高阅读性！！！

#案例一：查询员工名，部门名
SELECT last_name,`department_name`
FROM `departments` d
INNER JOIN `employees` e
ON e.`department_id` = d.`department_id`;

#案例二：查询名字中包含e的员工名和工种名（添加筛选）
SELECT `last_name`,`job_title`
FROM `employees` e
INNER JOIN `jobs` j
ON e.`job_id`=j.`job_id`
WHERE e.`last_name` LIKE '%e%';

#3.查询部门个数>3的城市名和部门个数
SELECT city,COUNT(*)
FROM `departments` d
INNER JOIN `locations` l
ON d.`location_id` = l.`location_id`
GROUP BY city
HAVING COUNT(*)>3;

#4.查询哪个部门的部门员工个数>3的部门名和员工个数，并按个数降序排序
SELECT COUNT(*) ,`department_name`
FROM `employees` e
INNER JOIN `departments` d
ON e.`department_id` = d.`department_id`
GROUP BY `department_name`
HAVING COUNT(*)>3
ORDER BY COUNT(*) DESC;

#5.查询员工名，部门名，工种名，并将部门名降序
SELECT `last_name`,`department_name`,`job_title`
FROM `employees` e
INNER JOIN `departments` d
ON e.`department_id` = d.`department_id`
INNER JOIN `jobs` j
ON e.`job_id`=j.`job_id`
ORDER BY `department_name` DESC;
