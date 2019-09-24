package device;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class DeviceInfoDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	public DeviceInfoDAO() {
		try {
			String dbURL = "jdbc:mysql://3.13.163.79:3306/han_db?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=Asia/Seoul";
			String dbID = "admin";
			String dbPassword = "ifnt0719";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace(); // 오류가 무엇인지 출력
		}
	}

	public ArrayList<DeviceInfo> getList() {
		String SQL = "SELECT * FROM device ORDER BY bedNo";
		ArrayList<DeviceInfo> list = new ArrayList<DeviceInfo>();
		
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				DeviceInfo deviceInfo = new DeviceInfo();
				deviceInfo.setDeviceID(rs.getString(1));
				deviceInfo.setUserName(rs.getString(2));
				deviceInfo.setRoomNo(rs.getString(3));
				deviceInfo.setBedNo(rs.getString(4));
				list.add(deviceInfo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public String getUserName(String deviceID) {
		String userName = null;
		String SQL = "SELECT userName FROM device WHERE deviceID = " + deviceID;
		
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				userName = rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return userName;
	}
}
