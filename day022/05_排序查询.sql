#排序查询

/*
语法：
select 查询列表
from 表名
【where 筛选条件】
order by 排序列表
执行顺序：
①from子句
②where子句
③select子句
④order by 子句
举例：
select last_name,salary
from employees
where salary>20000
order by salary ;
select * from employees;
特点：
1、排序列表可以是单个字段、多个字段、表达式、函数、列数、以及以上的组合
2、升序 ，通过 asc   ，默认行为
   降序 ，通过 desc
*/


#案例一：查询员工信息，并按工资从高到低排序
SELECT * FROM employees ORDER BY salary DESC;
SELECT * FROM employees ORDER BY salary ASC;

#案例二：查询部门编号>=90的员工信息，按入职时间的先后进行排序
SELECT * FROM employees WHERE `department_id`>=90 ORDER BY `hiredate` ASC;

#案例三：按年薪的高低显示员工的信息和年薪【按表达式排序】
SELECT *,`salary`*12*(1+IFNULL(`commission_pct`,0)) 年薪 
FROM employees ORDER BY `salary`*12*(1+IFNULL(`commission_pct`,0)) DESC;

#案例四：按年薪的高低显示员工的信息和年薪【按表达式排序】
SELECT *,`salary`*12*(1+IFNULL(`commission_pct`,0)) 年薪 
FROM employees ORDER BY 年薪 DESC;

#案例五：按姓名的长度显示员工的姓名和工资【按函数排序】
SELECT LENGTH(`last_name`) 姓名长度,`last_name`,`salary` FROM employees
ORDER BY 姓名长度 DESC;

#案例六：查询员工信息，要求先按工资升序，再按员工编号降序【按多个字段排序】
SELECT * FROM employees ORDER BY salary ASC,`employee_id` DESC;






