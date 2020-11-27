#1.查询工资最低的员工信息，`last_name`,`salary`
SELECT `last_name`,`salary` FROM `employees`
WHERE salary =(
	SELECT MIN(salary) FROM `employees`
);

#2.查询平均工资最低的部门信息

#方式一：
#第一步：各部门的平均工资
SELECT AVG(`salary`),`department_id` FROM `employees`
GROUP BY `department_id`;

#第二步：查询第一步结果上的最低平均工资
SELECT MIN(avg_sal.ag)
FROM (
	SELECT AVG(`salary`) ag,`department_id` FROM `employees`
	GROUP BY `department_id`
) avg_sal;

#第三步：查询那个部门的平均工资=第二步
SELECT AVG(`salary`),`department_id` FROM `employees`
GROUP BY `department_id`
HAVING AVG(salary)=(
	SELECT MIN(avg_sal.ag)
	FROM (
		SELECT AVG(`salary`) ag,`department_id` FROM `employees`
		GROUP BY `department_id`
	) avg_sal
);

#第四步：查询部门信息
SELECT d.* FROM `departments` d
WHERE d.`department_id`=(
	SELECT `department_id` FROM `employees`
	GROUP BY `department_id`
	HAVING AVG(salary)=(
		SELECT MIN(avg_sal.ag)
		FROM (
			SELECT AVG(`salary`) ag,`department_id` FROM `employees`
			GROUP BY `department_id`
		) avg_sal
	)
);

#方式二：
#第一步：各部门的平均工资
SELECT AVG(`salary`),`department_id` FROM `employees`
GROUP BY `department_id`;

#第二步：求出平均工资最低的部门id
SELECT `department_id` FROM `employees`
GROUP BY `department_id`
ORDER BY AVG(salary)
LIMIT 1;

#第三步：查询部门信息
SELECT d.* FROM `departments` d
	WHERE d.`department_id`=(
	SELECT `department_id` FROM `employees`
	GROUP BY `department_id`
	ORDER BY AVG(salary)
	LIMIT 1;
)

#3.查询平均工资最低的部门信息和该部门的平均工资
#第一步：各部门的平均工资
SELECT AVG(`salary`),`department_id` FROM `employees`
GROUP BY `department_id`;

#第二步：求出平均工资最低的部门id
SELECT AVG(salary),`department_id` FROM `employees`
GROUP BY `department_id`
ORDER BY AVG(salary)
LIMIT 1;
#第三步：查询部门信息
SELECT d.*,ag
FROM `departments` d
JOIN (
	SELECT AVG(salary) ag,`department_id` FROM `employees`
	GROUP BY `department_id`
	ORDER BY AVG(salary)
	LIMIT 1
) ag_a 
ON d.`department_id`=ag_a.`department_id`;

#4.查询平均工资最高的job信息
SELECT `job_id` FROM `employees` 
GROUP BY `job_id`
ORDER BY AVG(salary) DESC LIMIT 1;

SELECT * FROM jobs WHERE `job_id`=(
SELECT `job_id` FROM `employees` 
GROUP BY `job_id`
ORDER BY AVG(salary) DESC LIMIT 1
);

#5.查询平均工资高于公司平均工资的部门有哪些

#第一步：查询平均工资
SELECT AVG(salary) FROM `employees`;

#第二步：查询每个部门的平均工资
SELECT AVG(salary) FROM `employees` GROUP BY `department_id`;

#第三步：筛选第二步结果，满足平均工资大于第一步的
SELECT AVG(salary),`department_id` FROM `employees` GROUP BY `department_id`
HAVING AVG(salary)>(
	SELECT AVG(salary) FROM `employees`
);

#6.查询出公司中所有manager的详细信息
SELECT DISTINCT `manager_id` FROM `employees`;

SELECT * FROM `employees` WHERE `manager_id` IN (
SELECT DISTINCT `manager_id` FROM `employees`
);

#7.各个部门中最高工资最低的那个部门的最低工资是多少
#第一步：各部门中最高工资中最低的
SELECT `department_id` FROM `employees` GROUP BY `department_id` ORDER BY MAX(salary) LIMIT 1;

#第二步：满足第一步的最低的工资
SELECT MIN(salary) FROM `employees` GROUP BY `department_id`
HAVING `department_id`=(
SELECT `department_id` FROM `employees` GROUP BY `department_id` ORDER BY MAX(salary) LIMIT 1
);

#8.查询平均工资最高的部门的manager的详细信息，`last_name`,`department_id`,`email`,`salary`
SELECT `department_id` FROM `employees` GROUP BY `department_id`
ORDER BY AVG(salary) DESC LIMIT 1;

SELECT `last_name`,d.`department_id`,`email`,`salary` FROM `employees` e
INNER JOIN `departments` d
ON d.`manager_id`=e.`employee_id`
WHERE d.`department_id`=(
SELECT `department_id` FROM `employees` GROUP BY `department_id`
ORDER BY AVG(salary) DESC LIMIT 1
);

