#分组函数

/*
说明：分组函数往往用于实现将一组数据进行统计计算，最终得到一个值，又称为聚合函数或统计函数
分组函数清单：

sum(字段名)：求和
avg(字段名)：求平均数
max(字段名)：求最大值
min(字段名)：求最小值
count(字段名)：计算非空字段值的个数

特点：
1.sum,avg一般用于处理数值类型
   max,min,count可以处理任何类型
2.以上分组函数都忽略Null值

3.可以和distinct搭配实现去重的运算

4.count函数的单独介绍
   一般使用count(*)用作统计行数
5.和分组函数一同查询的字段要求是group by后的字段
*/

#1.简单的使用
SELECT SUM(salary) FROM employees;
SELECT AVG(salary) FROM employees;
SELECT MIN(salary) FROM employees;
SELECT MAX(salary) FROM employees;
SELECT COUNT(salary) FROM employees;

SELECT SUM(salary),ROUND(AVG(salary),2),MAX(salary),MIN(salary),COUNT(salary) FROM employees;

#2.参数支持那些类型

SELECT SUM(last_name),AVG(last_name) FROM employees;
SELECT SUM(hiredate),AVG(hiredate) FROM employees;

SELECT MAX(hiredate),MIN(hiredate) FROM employees;// 2016-03-03 00:00:00 1992-04-03 00:00:00
SELECT MAX(last_name),MIN(last_name) FROM employees; 

SELECT COUNT(hiredate) FROM employees; //107
SELECT COUNT(commission_pct) FROM employees; //35


#3.是否忽略null值    sum忽略null值
SELECT SUM(commission_pct),AVG(commission_pct),SUM(commission_pct)/35,
SUM(commission_pct)/107 FROM employees;//7.80    0.222857 0.222857   0.072897

SELECT MAX(commission_pct),MIN(commission_pct) FROM employees;

SELECT COUNT(commission_pct) FROM employees;

#4.和distinct搭配使用
SELECT SUM(DISTINCT salary),SUM(salary) FROM employees; // 397900.00      691400.00 

SELECT COUNT(DISTINCT salary) FROM employees;  //57

#5.count函数的详细介绍
SELECT COUNT(salary) FROM employees;

SELECT COUNT(*) FROM employees;//统计总行数

SELECT COUNT(1) FROM employees;

SELECT COUNT(2) FROM employees;

效率：
MYISAM:存储引擎下,COUNT(*)的效率高
INNODB:存储引擎下,COUNT(*)和COUNT(1)的效率比COUNT('字段')要高一些

#6.和分组函数一同查询的字段由限制
SELECT AVG(salary),`employee_id` FROM employees;

