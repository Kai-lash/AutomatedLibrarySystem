package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class InitializeConnection {
	
	public Connection initConnect() throws ClassNotFoundException, SQLException{
		
		/*
		 * Class.forName("oracle.jdbc.driver.OracleDriver"); 
		 * Connection con = DriverManager.getConnection(
		 * "jdbc:oracle:thin:@10.3.21.118:1521:orcl", "scott1", "tiger1");
		 */
		
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con = DriverManager.getConnection(
				"jdbc:oracle:thin:@127.0.0.1:1521:", "hr", "hr");

		System.out.println("Connected");
		return con;

	}

}
