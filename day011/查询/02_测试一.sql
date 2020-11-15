#测试1-基本SQL-SELECT语句
#1. 下面的语句是否可以执行成功 （true）
SELECT 
  last_name,
  job_id,
  salary AS sal 
FROM
  employees ;

  
#2. 下面的语句是否可以执行成功 （true）
SELECT 
  * 
FROM
  employees ;

  
#3. 找出下面语句中的错误 (false last_name，)
SELECT 
  employee_id,
  last_name,
  salary * 12 “ ANNUAL SALARY ” 
FROM
  employees ;

 
4. 显示表 departments 的结构，并查询其中的全部数据 
DESC departments;
SELECT * FROM `departments`;
SHOW COLUMNS FROM departments;

5. 显示出表 employees 中的全部 job_id （不能重复） 
SELECT DISTINCT 
  job_id 
FROM
  employees ;
 
6. 显示出表 employees 的全部列，各个列之间用逗号连接，列头显示成 OUT_PUT 
SELECT 
  CONCAT(
    employee_id,
    ',',
    first_name,
    ',',
    last_name,
    ',',
    salary,
    ',',
    IFNULL(commission_pct, ',')
  ) AS "out_put" 
FROM
  employees ;








