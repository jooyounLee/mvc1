package kr.mz.study.mvc1.db;

import java.sql.Connection;
import java.sql.DriverManager;


public class DBConn {
	public static Connection getConnection () {
		Connection conn = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			
			String url = "jdbc:mysql://localhost:3306/test?useUnicode=true&characterEncoding=utf8";
			String id = "root";
			String pw = "Sfodqh4878S_";
			
			conn = DriverManager.getConnection(url, id, pw);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return conn;
	}
}
