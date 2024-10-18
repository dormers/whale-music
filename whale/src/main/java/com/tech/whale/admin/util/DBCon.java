package com.tech.whale.admin.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBCon {
	static Connection con = null;
	public static Connection getConnection() {
		
		try {
			String driver = "oracle.jdbc.driver.OracleDriver";
			String url = "jdbc:oracle:thin:@localhost:1521:xe";
			String user = "hr";
			String pw = "123456";
			Class.forName(driver);
			con = DriverManager.getConnection(url,user,pw);
			
		} catch (Exception e) {
			System.out.println("db error");
		}
		return con;
	}
}
