package device;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class DeviceInfoDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	public DeviceInfoDAO() {
		try {
			String dbURL = "jdbc:mysql://3.13.163.79:3306/han_db?autoReconnect=true&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=Asia/Seoul";
			String dbID = "admin";
			String dbPassword = "ifnt0719";
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace(); // 오류가 무엇인지 출력
		}
	}

	public ArrayList<DeviceInfo> getList() {
		String SQL = "SELECT * FROM device ORDER BY deviceID";
		ArrayList<DeviceInfo> list = new ArrayList<DeviceInfo>();

		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				DeviceInfo deviceInfo = new DeviceInfo();
				deviceInfo.setDeviceID(rs.getString(1));
				deviceInfo.setCheckDate(rs.getString(2));
				list.add(deviceInfo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return list;
	}
	
	public String getDate() {
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
			rs.close();
			pstmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ""; // DB 오류
	}
	
	public void insert(String deviceID) {
		String SQL = "INSERT INTO device VALUES(?, ?)";
		
		try {
			String date = getDate();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, deviceID);
			pstmt.setString(2, date);

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
	}
	
	public void update(String checkDate, String deviceID) {
		String SQL = "UPDATE device SET checkDate=? WHERE deviceID=?";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, checkDate);
			pstmt.setString(2, deviceID);
			
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
	}

	public void delete(String deviceID) {
		String SQL = "DELETE FROM device WHERE deviceID=?";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, deviceID);

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
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
