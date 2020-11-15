#查询没有奖金，且工资小于18000的salary,last_name
SELECT `salary`,`last_name` FROM employees WHERE salary IS NULL AND salary < 18000;
#查询employees表中，job_id不为'IT'或者工资为12000的员工信息
SELECT * FROM employees WHERE job_id<>'IT' OR salary <=>12000;
#查看部门departments表的结构，查询效果
DESC departments;
#查询部门departments表中涉及到了那些位置编号
SELECT DISTINCT location_id FROM departments;

#经典面试题：试问select * from emplpoyees ;和select * from employees where commission_pct loke '%%' and last_name like '%%'结果是否一样？并说明原因
不一样，如果判断的字段由NULL值