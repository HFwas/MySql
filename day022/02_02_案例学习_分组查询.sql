#案例1 ：查询员工信息表中，所有员工的工资和、工资平均值、最低工资、最高工资、有工资的个数

SELECT SUM(salary),AVG(salary),MIN(salary),MAX(salary),COUNT(salary) FROM employees;

#案例2：添加筛选条件
	#①查询emp表中记录数：
	SELECT COUNT(employee_id) FROM employees;

	#②查询emp表中有佣金的人数：
	
	SELECT COUNT(salary) FROM employees;
	
	
	#③查询emp表中月薪大于2500的人数：
	SELECT COUNT(salary) FROM employees WHERE salary>2500;

	
	#④查询有领导的人数：
	SELECT COUNT(manager_id) FROM employees;
	
#2.查询员工表中的最大入职时间和最小入职时间的相差天数(DATEDIFF)
MAX(hiredate);
MIN(hiredate);

SELECT DATEDIFF(NOW(),'1997-03-20');

SELECT DATEDIFF(MAX(hiredate),MIN(hiredate)) DIFFERENCE FROM employees;

#3.查询部门编号为90的员工个数
SELECT COUNT(*) FROM employees WHERE `department_id`<=>90; 














