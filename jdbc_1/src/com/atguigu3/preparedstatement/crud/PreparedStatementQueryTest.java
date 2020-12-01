package com.atguigu3.preparedstatement.crud;

import java.lang.reflect.Field;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.util.ArrayList;
import java.util.List;

import org.junit.Test;

import com.atguigu.connection.testConnection;
import com.atguigu3.bean.Customer;
import com.atguigu3.bean.Order;
import com.atguigu3.util.JDBCUtils;

/**
 * 使用PreparedStatement来实现不同表的通用的查询操作
 * @author Administrator
 */
public class PreparedStatementQueryTest {
	
	@Test
	public void testGetForList(){
		String sql = "select id,name,email from customers where id < ?";
		List<Customer> list = getForList(Customer.class, sql,12);
		for (Customer customer : list) {
			System.out.println(customer);
		}
	}
	
	@Test
	public <T> List<T> getForList(Class<T> clazz,String sql,Object...args){
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = JDBCUtils.getConnection();
			ps = conn.prepareStatement(sql);
			
			for(int i = 0;i < args.length;i++){
				ps.setObject(i+1, args[i]);
			}
			
			//执行，获取结果集
			rs = ps.executeQuery();
			//获取结果集的元数据
			ResultSetMetaData resultSetMetaData = rs.getMetaData();
			//获取列数
			int count = resultSetMetaData.getColumnCount();
			//创建集合
			ArrayList<T> list = new ArrayList<>();
			while (rs.next()) {
				T t = clazz.newInstance();
				for (int i = 0; i < count; i++) {
					//获取每个列的列值:通过ResultSet
					Object columnValue = rs.getObject(i+1);
					//获取每个列的列名:通过ResultSetMetaData
					//获取列的列名:getColumnName----不推荐使用
					//获取列的别名:getColumnLabel
					//String columnName = resultSetMetaData.getColumnName(i+1);
					String columnLabel = resultSetMetaData.getColumnLabel(i+1);
					//通过反射，将对象指定名columnName的属性赋值给指定的值columnValue
					Field field = clazz.getDeclaredField(columnLabel);
					field.setAccessible(true);
					field.set(t, columnValue);
				}
				list.add(t);
			}
			return list;
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			JDBCUtils.closeResource(conn, ps, rs);
			
		}
		
		return null;
	}
	
	@Test
	public void testGetInstance(){
		String sql = "select id,name,email from customers where id = ?";
		Customer customer = getInstance(Customer.class, sql, 12);
		System.out.println(customer);
	}
	
	
	@Test
	public <T> T getInstance(Class<T> clazz,String sql,Object...args){
		Connection conn = null;
		PreparedStatement ps = null;
		//执行，获取结果集
		ResultSet rs = null;
		try {
			conn = JDBCUtils.getConnection();
			ps = conn.prepareStatement(sql);
			
			for(int i = 0;i < args.length;i++){
				ps.setObject(i+1, args[i]);
			}
			
			rs = ps.executeQuery();
			//获取结果集的元数据
			ResultSetMetaData resultSetMetaData = rs.getMetaData();
			//获取列数
			int count = resultSetMetaData.getColumnCount();
			if (rs.next()) {
				T t = clazz.newInstance();
				for (int i = 0; i < count; i++) {
					//获取每个列的列值:通过ResultSet
					Object columnValue = rs.getObject(i+1);
					//获取每个列的列名:通过ResultSetMetaData
					//获取列的列名:getColumnName----不推荐使用
					//获取列的别名:getColumnLabel
					//String columnName = resultSetMetaData.getColumnName(i+1);
					String columnLabel = resultSetMetaData.getColumnLabel(i+1);
					//通过反射，将对象指定名columnName的属性赋值给指定的值columnValue
					Field field = clazz.getDeclaredField(columnLabel);
					field.setAccessible(true);
					field.set(t, columnValue);
				}
				
				return t;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			JDBCUtils.closeResource(conn, ps, rs);
			
		}
		
		return null;
	}
	
	
}
