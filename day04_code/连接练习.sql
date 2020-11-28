#查询编号>3的女神的男朋友的信息，如果有则列出详细，如果灭有，用null填充

SELECT b.`id`,b.`name`,bo.*
FROM `beauty` b
LEFT JOIN `boys` bo
ON b.`boyfriend_id` = bo.`id`
WHERE b.`id` >3;

#查询那个城市没有部门

SELECT `city`,d.*
FROM `departments` d
RIGHT JOIN `locations` l
ON l.`location_id` = d.`location_id`
WHERE d.`department_id` IS NULL;

#查询部门名为SAL或IT的员工信息

SELECT e.*,d.`department_name`
FROM `departments` d
LEFT JOIN `employees` e
ON d.`department_id` = e.`department_id`
WHERE d.`department_name`='SAL'
OR d.`department_name` = 'IT';

SELECT e.*,d.`department_name`
FROM `departments` d
LEFT JOIN `employees` e
ON d.`department_id` = e.`department_id`
WHERE d.`department_name` IN('SAL','IT');