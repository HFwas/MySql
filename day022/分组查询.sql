#分组查询

/*
语法：

select 查询列表
from 表名
where 筛选条件
group by 分组列表
having 分组后筛选
order by 排序列表;

执行顺序：
①from子句
②where子句
③group by 子句
④having子句
⑤select子句
⑥order by子句

特点：
①查询列表往往是  分组函数和被分组的字段 ★
②分组查询中的筛选分为两类
			筛选的基表	使用的关键词		位置
分组前筛选		原始表		where			group by 的前面

分组后筛选		分组后的结果集  having			group by的后面

where——group by ——having

问题：分组函数做条件只可能放在having后面！！！

*/


#1）简单的分组
#案例1：查询每个工种的员工平均工资
SELECT AVG(salary),`job_id` FROM employees GROUP BY `job_id`; 

#查询每个位置上的部门个数
SELECT COUNT(`department_id`),`location_id` FROM departments GROUP BY `location_id`;

#添加筛选条件
#案例一：查询邮箱中包含a字符的，每个部门的平均工资
SELECT 
  AVG(salary),
  `department_id` 
FROM
  employees 
WHERE email LIKE '%a%' 
GROUP BY `department_id` ;

#案例二：查询有奖金的每个领导手下员工的最高工资
SELECT 
  MAX(salary),
  `manager_id` 
FROM
  employees 
WHERE `commission_pct` IS NOT NULL 
GROUP BY `manager_id` ;

#添加分组后的筛选条件

#案例一：查询那个部门员工个数>2

#先查询每个部门的员工个数
SELECT COUNT(*),`department_id` FROM employees GROUP BY `department_id`;

#根据上述查询的结果进行筛选，查询哪个部门的员工个数>2
SELECT 
  COUNT(*),
  `department_id` 
FROM
  employees 
GROUP BY `department_id` 
HAVING COUNT(*) > 2 ;

#案例二:查询每个工种有奖金的员工的最高工资>12000的工种编号和最高工资
#第一步：查询每个工种有奖金的员工的最高工资
SELECT 
  MAX(salary),
  `job_id` 
FROM
  employees 
WHERE `commission_pct` IS NOT NULL 
GROUP BY `job_id` ;

#第二步：根据第一步的结果继续筛选，最高工资是否大于12000，
SELECT 
  MAX(salary),
  `job_id` 
FROM
  employees 
WHERE `commission_pct` IS NOT NULL 
GROUP BY `job_id` 
HAVING MAX(salary) > 12000;

#案例三：查询领导编号>102的每个领导手下的最低工资>5000的领导编号是哪个，以及最低工资
#第一步：查询领导编号>102的每个领导手下的员工固定最低工资
SELECT 
  MIN(salary),
  `manager_id` 
FROM
  employees 
WHERE `manager_id` > 102 
GROUP BY `manager_id` ;

#第二步：添加筛选条件：最低工资大于5000
SELECT 
  MIN(salary),
  `manager_id` 
FROM
  employees 
WHERE `manager_id` > 102 
GROUP BY `manager_id` 
HAVING MIN(salary) > 5000 ;


#按表达式或者函数分组
#案例：按员工姓名的长度分组，查询每一组的员工个数，筛选员工个数>5的有那些
#第一步：查询每个长度的员工个数
SELECT 
  LENGTH(last_name),
  COUNT(*) 
FROM
  employees 
GROUP BY LENGTH(last_name) ;

#第二步：添加筛选条件
SELECT 
  LENGTH(last_name),
  COUNT(*) 
FROM
  employees 
GROUP BY LENGTH(last_name) 
HAVING COUNT(*)>5;

#按多个字段进行分组
#查询每个部门，每个工种之间的员工的平均工资
SELECT 
  AVG(salary),
  `department_id`,
  `job_id` 
FROM
  employees 
GROUP BY `department_id`,
  `job_id` ;

#添加排序
#查询每个部门不为空，每个工种之间的员工的平均工资>10000,并且按平均工资的高低显示出来
SELECT 
  AVG(salary),
  `department_id`,
  `job_id` 
FROM
  employees 
WHERE `department_id` IS NOT NULL 
GROUP BY `department_id`,
  `job_id` 
HAVING AVG(salary) > 10000 
ORDER BY AVG(salary) DESC ;

