#常见函数的学习

/*
常见函数：
单行函数
	字符函数
		concat
		substr
		length（str）
		char_length
		upper
		lower
		trim
		left
		right
		lpad
		rpad
		instr
		strcmp
	数学函数
		abs
		ceil
		floor
		round
		truncate
		mod
		
	日期函数
		now 
		curtime
		curdate
		datediff
		date_format
		str_to_date
		
	流程控制函数
		if
		case
*/

# 字符函数
#1.length 获取参数值的字节个数
SELECT LENGTH(’john‘);

# 拼接字符串concat
SELECT CONCAT(last_name, '_', first_name) FROM employees;

# 大小写转换
SELECT UPPER(last_name) FROM employees;
SELECT LOWER("joHn");

# 截取字符串，索引从1开始
# 从指定位置开始截取到末尾
SELECT SUBSTR("hello", 3); // llo

#从指定位置开始截取指定个数
SELECT SUBSTR("hello", 1, 2); // he

# 子串第一次出现的位置，找不到返回0
SELECT INSTR('hello world', 'wor') AS out_put; // 7

# 删除前后字符
# 删除空格
SELECT LENGTH(TRIM('   你好   ')) AS out_put; // 6

# 删除指定字符trim
SELECT TRIM('a' FROM 'aaaa你好aaaa你aaaaa') AS out_put;
SELECT TRIM('ab' FROM 'aba你好babab') AS out_put; // a你好b

# 用指定的字符实现左填充指定长度lpad
SELECT LPAD("hello", 10, '*');
SELECT RPAD("hello", 10, '*');

# 替换
SELECT REPLACE("I love U U U...", 'U', 'you');






