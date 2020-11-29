package com.atguigu.connection;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

import org.junit.Test;

public class testConnection {
	
	//方式五(final最终版)：将配置信息放到配置文件中去
	/*
	 * 此种方式的好处？
	 * 1.实现了数据与代码的分离。实现了解耦
	 * 2.如果需要修改配置文件信息，可以避免程序重新打包。
	 */
	@Test
	public void testConnection5() throws Exception{
		//1.读取配置文件的信息
		InputStream is = testConnection.class.getClassLoader().getResourceAsStream("jdbc.properties");
		
		Properties pro = new Properties();
		pro.load(is);
		
		String user = pro.getProperty("user");
		String password = pro.getProperty("password");
		String url = pro.getProperty("url");
		String driver = pro.getProperty("driverClass");
		
		//2.加载驱动
		getClass().forName(driver);
		
		//3.获取连接
		Connection conn = DriverManager.getConnection(url, user, password);
		System.out.println(conn);
	}
	
	//方式四：可以只是加载驱动，不用显示的注册驱动
	@Test
	public void testConnection4() throws Exception{
		//1..提供要连接的数据库，密码，用户名
		String url = "jdbc:mysql://localhost:3306/test";
		String user = "root";
		String password = "1230";

		//2.加载Driver
		Class.forName("com.mysql.jdbc.Driver");
		
		//相较于方式三：可以省略以下的操作
//		Driver driver = (Driver) forName.newInstance();
//		//注册驱动
//		DriverManager.registerDriver(driver);
		//为什么可以省略一下的操作
		/**
		 * 在mysql的Driver实现类中，声明了如下的操作：
		 * static {
				try {
					java.sql.DriverManager.registerDriver(new Driver());
				} catch (SQLException E) {
					throw new RuntimeException("Can't register driver!");
				}
			}
		 */
		
		//3.获取连接
		Connection conn = DriverManager.getConnection(url, user, password);
		System.out.println(conn);
	}
	
	//方式三：使用DriverManager替换Driver
	@Test
	public void testConnection3() throws Exception{
		//1.获取Driver的实现类对象:使用反射来实现
		Class forName = Class.forName("com.mysql.jdbc.Driver");
		Driver driver = (Driver) forName.newInstance();
		
		//2.提供要连接的数据库
		String url = "jdbc:mysql://localhost:3306/test";
		//3.提供连接需要的用户名和密码
		String user = "root";
		String password = "1230";
		
		//注册驱动
		DriverManager.registerDriver(driver);
		
		//获取连接
		Connection conn = DriverManager.getConnection(url, user, password);
		System.out.println(conn);
	}
	
	//方式二：对方式一的迭代:在如下的程序中不出现第三方的API,使得程序具有更好的可移植性
	@Test
	public void testConnection2() throws Exception{
		//1.获取Driver的实现类对象:使用反射来实现
		Class forName = Class.forName("com.mysql.jdbc.Driver");
		Driver driver = (Driver) forName.newInstance();
		
		//2.提供要连接的数据库
		String url = "jdbc:mysql://localhost:3306/test";
		
		//3.提供连接需要的用户名和密码
		Properties info = new Properties();
		info.setProperty("user", "root");
		info.setProperty("password", "1230");
		
		//4.获取连接
		Connection connect = driver.connect(url, info);
		System.out.println(connect);
	}
	
	//方式一：
	@SuppressWarnings("null")
	@Test
	public void testConnection1() throws SQLException{
		//获取Driver的实现类对象
		Driver driver = new com.mysql.jdbc.Driver();
		
		//jdbc:mysql协议
		//localhost：ip地址
		//3306:默认端口号
		//test:test数据库
		String url = "jdbc:mysql://localhost:3306/test";
		
		//将用户名和密码封装在Properties中
		Properties info = new Properties();
		info.setProperty("user", "root");
		info.setProperty("password", "1230");
		
		Connection connect = driver.connect(url, info);
		
		System.out.println(connect);
	}
	
}
