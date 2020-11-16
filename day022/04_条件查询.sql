#进阶二：条件查询

/*
语法：

select 查询列表
from  表名
where 筛选条件;

执行顺序：
①from子句
②where子句
③select子句
select last_name,first_name from employees where salary>20000;
特点：
1、按关系表达式筛选
关系运算符：>   <    >=   <=     =       <>     
              补充：也可以使用!=,但不建议
2、按逻辑表达式筛选
逻辑运算符：and    or   not
	      补充：也可以使用&&  ||   !  ，但不建议
3、模糊查询
like
in
between and

is null
*/


#1.按条件表达式查询

#案例一：查询工资>12000的员工信息
SELECT * FROM employees WHERE `salary`>12000;

#案例二：查询部门编号不等于90号的员工名和部门编号
SELECT `last_name`,`department_id` FROM employees WHERE `department_id`<>90;

#2.按逻辑表达式筛选

#案例一：查询工资在10000到20000之间的员工名和工资，奖金
#方法一
SELECT `last_name`,`salary`,`commission_pct` FROM employees WHERE salary >= 10000 AND salary <= 20000; 
#方法二
SELECT `last_name`,`salary`,`commission_pct` FROM employees WHERE salary BETWEEN 10000 AND 20000;

#案例二：查询部门编号不是在90到110之间，或者工资高于15000的员工信息
#方法一
SELECT * FROM employees WHERE `department_id`<90 OR `department_id` > 110 OR salary > 15000;
#方法二
SELECT * FROM employees WHERE NOT(`department_id`>=90 AND `department_id` <= 110) OR salary >15000;

#3.模糊查询

#案例一：查询员工名中包含a的员工信息
SELECT * FROM employees WHERE `last_name` LIKE '%a%';

#案例二：查询员工名中第三个为字符为e，第五个字符为a的员工名和工资
SELECT `last_name`,`salary` FROM employees WHERE last_name LIKE '__n_l%';

#案例三：查询员工名中第二个字符为下划线的员工名,转义字符
#方法一
SELECT `last_name` FROM employees WHERE last_name LIKE '_\_%';
#方法二
#自己设置一个转移字符，使用到ESCAPE关键字
SELECT `last_name` FROM employees WHERE last_name LIKE '_$_%' ESCAPE '$';


#2.between and

#案例一：查询员工编号在100到120的员工信息
SELECT * FROM employees WHERE employee_id BETWEEN 100 AND 120;

#3.in

#案例一：查询员工的工种编号是IT_PROG，AD_VP,AD_PRES的一个员工名和工种编号
#方法一：
SELECT `last_name`,`job_id` FROM employees WHERE job_id = 'IT_PROT' OR job_id = 'AD_VP' OR job_id = 'AD_PRES';
#方法二：
SELECT `last_name`,`job_id` FROM employees WHERE job_id IN('IT_PROT','AD_VP','AD_PRES');

#4.is null

#案例一:查询没有奖金的员工名和奖金率
SELECT `last_name`,`commission_pct` FROM employees WHERE `commission_pct` IS NULL;
SELECT `last_name`,`commission_pct` FROM employees WHERE `commission_pct` IS NOT NULL;

#安全等于<=>

#案例一:查询没有奖金的员工名和奖金率
SELECT `last_name`,`commission_pct` FROM employees WHERE `commission_pct`<=>NULL;
#案例二:查询工资为12000的员工信息
SELECT * FROM employees WHERE `salary`<=>12000;





























