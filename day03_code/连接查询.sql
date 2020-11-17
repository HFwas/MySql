#连接查询

/*
说明：又称多表查询，当查询语句涉及到的字段来自于多个表时，就会用到连接查询
笛卡尔乘积现象：表1 有m行，表2有n行，结果=m*n行
	发生原因：没有有效的连接条件
	如何避免：添加有效的连接条件

分类：
	按年代分类：
	1、sql92标准:仅仅支持内连接
		内连接：
			等值连接
			非等值连接
			自连接
	2、sql99标准【推荐】：支持内连接+外连接（左外和右外）+交叉连接
	
	按功能分类：
		内连接：
			等值连接
			非等值连接
			自连接
		外连接：
			左外连接
			右外连接
			全外连接
		
		交叉连接
*/


#查询
SELECT NAME FROM beauty;

SELECT * FROM boys;

SELECT NAME,boyName FROM boys,beauty WHERE beauty.`boyfriend_id`= boys.`id`;


#1.等值连接
#实例一：查询女神名和对应的男神名
SELECT 
  NAME,
  boyName 
FROM
  boys,
  beauty 
WHERE beauty.`boyfriend_id` = boys.`id` ;

#实例二：查询员工名和对应的部门名
SELECT last_name,department_name FROM departments,employees
WHERE `departments`.`department_id`=`employees`.`department_id`;

#2.为表起别名
#实例一：查询员工名，工种号，工种名
SELECT 
  `last_name`,
  e.`job_id`,
  `job_title` 
FROM
  jobs j,
  employees e 
WHERE e.`job_id` = j.`job_id` ;

#3.两个表的顺序是否可以调换
#实例一：查询员工名，工种号，工种名
SELECT 
  `last_name`,
  e.`job_id`,
  `job_title` 
FROM
  employees e,
  jobs j
WHERE e.`job_id` = j.`job_id` ;

#4.可以加筛选吗？
#案例一：查询有奖金的员工名和部门名
SELECT 
  `last_name`,
  `department_name` 
FROM
  `departments` d,
  `employees` e 
WHERE d.`department_id` = e.`department_id` 
  AND e.`commission_pct` IS NOT NULL ;
  
#案例二：查询城市名中第二个字符o的部门名和城市名
SELECT 
  `department_name`,
  `city` 
FROM
  `departments` d,
  `locations` l 
WHERE d.`location_id` = l.`location_id` 
  AND `city` LIKE '_o%' ;
  
#5.可以加分组

#案例一：查询每个城市的部门个数
SELECT 
  COUNT(*),
  `city` 
FROM
  `locations` l,
  `departments` d 
WHERE l.`location_id` = d.`location_id` 
GROUP BY city ;

#案例二：查询有奖金的每个部门的部门名和部门的领导编号和该部门的最低工资
SELECT 
  `department_name`,
  d.`manager_id`,
  MIN(salary) 
FROM
  `departments` d,
  `employees` e 
WHERE d.`department_id` = e.`department_id` 
  AND e.`commission_pct` IS NOT NULL 
GROUP BY d.`department_name`,
  d.`manager_id` ;

#6.可以加排序
#案例一：查询每个工种的工种名和员工的个数，并且按员工个数降序
SELECT 
  `job_title`,
  COUNT(*) 
FROM
  `employees` e,
  `jobs` j 
WHERE e.`job_id` = j.`job_id` 
GROUP BY `job_title` 
ORDER BY job_title DESC ;


#7.可以实现三表连接

#案例一：查询员工名，部门名，所在的城市
SELECT 
  `last_name`,
  `department_name`,
  `city` 
FROM
  `employees` e,
  `departments` d,
  `locations` l 
WHERE e.`department_id` = d.`department_id` 
  AND d.`location_id` = l.`location_id` 
  AND city LIKE 's%'
ORDER BY department_name DESC;


#2.非等值连接

#案例一：查询员工的工资和工资级别
SELECT 
  `salary`,
  `grade_level` 
FROM
  `employees` e,
  `job_grades` j 
WHERE `salary` BETWEEN j.`lowest_sal` 
  AND j.`highest_sal` 
  AND j.`grade_level`='A';

SELECT * FROM job_grades;


#3.自连接

#案例一：查询员工名和上级的名称
SELECT e.`employee_id`,e.`last_name`,k.`employee_id`,k.`last_name`
FROM `employees` e,`employees` k
WHERE e.`manager_id`=k.`employee_id`;






























