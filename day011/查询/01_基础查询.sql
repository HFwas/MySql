#基础查询

USE myemployees;

#1.查询表中单个字段
SELECT first_name FROM employees;

#2.查询表中的多个字段
SELECT first_name,last_name,email,salary FROM employees;

#3。查询表中的所有字段

#方式一
SELECT 
  `employee_id`,
  `first_name`,
  `last_name`,
  `email`,
  `phone_number`,
  `job_id`,
  `salary`,
  `commission_pct`,
  `manager_id`,
  `department_id`,
  `hiredate` 
FROM
  employees ;

#方式二
  SELECT * FROM employees;

#4.查询常量值
SELECT 100;
SELECT 'abc';

#5.查询表达式
SELECT 98*100;

#6.查询函数
SELECT VERSION();	

#7.起别名
#方式一：使用AS
SELECT 98%100 AS 余数;
SELECT `first_name` AS 姓,`last_name` AS 名 FROM employees;

#方式二：使用空格
SELECT `first_name` 姓,`last_name` 名 FROM employees;

#案例：查询salary,显示结果为out put 
SELECT `salary` AS "out put" FROM employees;

#8.去重

#案例：查询员工表中涉及到的所有部门编号
SELECT DISTINCT `department_id` FROM employees;

#9.+号的作用
/*
Java中+的作用：
1、加法运算
	100+1.5      'a'+2    1.3+'2'
2、拼接符
	至少有一个操作数为字符串
	"hello"+'a'	
mysql中+的作用：
1、加法运算
①两个操作数都是数值型
100+1.5
②其中一个操作数为字符型
将字符型数据强制转换成数值型,如果无法转换，则直接当做0处理
'张无忌'+100===>100
③其中一个操作数为null
null+null====》null
null+100====》 null
*/

#案例：查询员工名和姓连接起来作为一个字段，并显示为姓名

#方案一：使用concat关键字
SELECT CONCAT('a','b','c') AS 结果;

SELECT CONCAT(`last_name`,`first_name`) AS 姓名 FROM employees;	







