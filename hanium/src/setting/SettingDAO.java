package setting;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class SettingDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	public SettingDAO() {
		try {
			String dbURL = "jdbc:mysql://3.13.163.79:3306/han_db?autoReconnect=true&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=Asia/Seoul";
			String dbID = "admin";
			String dbPassword = "ifnt0719";
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 현재의 시간을 가져오는 함수
	public String getDate() {
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt2 = conn.prepareStatement(SQL);
			rs = pstmt2.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
			rs.close();
			pstmt2.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ""; // DB 오류
	}

	public int insert(int temperature, int humidity, int gas) {
		String SQL = "INSERT INTO setting VALUES(?, ?, ?, ?)";

		try {
			pstmt = conn.prepareStatement(SQL);

			pstmt.setString(1, getDate());
			pstmt.setInt(2, temperature);
			pstmt.setInt(3, humidity);
			pstmt.setInt(4, gas);

			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return -1; // DB 오류
	}
	
	public Setting getValue() {
		String SQL = "SELECT * FROM setting ORDER BY DATATIME DESC LIMIT 1";
		Setting setting = new Setting();

		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			rs.next();
			setting.setDatatime(rs.getString(1));
			setting.setTemperature(rs.getInt(2));
			setting.setHumidity(rs.getInt(3));
			setting.setGas(rs.getInt(4));
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return setting;
	}
	
	private void close() {
		try {
			if (rs != null)
				rs.close();
			if (pstmt != null)
				pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
