package com.atguigu3.preparedstatement.crud;

import java.lang.reflect.Field;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.util.Objects;

import org.junit.Test;

import com.atguigu3.bean.Order;
import com.atguigu3.util.JDBCUtils;

/**
 * 针对order表的操作
 * @author Administrator
 *
 */
public class OrderForQuery {
	
	@Test
	public Order orderForQuery(String sql,Objects ...args){
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
				Order order = new Order();
				for (int i = 0; i < count; i++) {
					//获取每个列的列值:通过ResultSet
					Object columnValue = rs.getObject(i+1);
					//获取每个列的列名:通过ResultSetMetaData
					String columnName = resultSetMetaData.getColumnName(i+1);
				
					//通过反射，将对象指定名columnName的属性赋值给指定的值columnValue
					Field field = Order.class.getDeclaredField(columnName);
					field.setAccessible(true);
					field.set(order, columnValue);
				}
				
				return order;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			JDBCUtils.closeResource(conn, ps, rs);
			
		}
		
		return null;
	}
	
	@Test
	public void testQuery1(){
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = JDBCUtils.getConnection();
			String sql = "select order_id,order_name,order_date from `order` where order_id = ?";
			ps = conn.prepareStatement(sql);
			ps.setObject(1, 1);
			
			rs = ps.executeQuery();
			if (rs.next()) {
				
				int id = (int) rs.getObject(1);
				String name = rs.getString(2);
				Date date = rs.getDate(3);
				
				Order order = new Order(id, name, date);
				System.out.println(order);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			JDBCUtils.closeResource(conn, ps, rs);
		}
	}
	
	
	
	
	
	
	
	
	
	
}
