package device;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class DeviceRecDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	public DeviceRecDAO() { // 생성자 실행될때마다 자동으로 db연결이 이루어 질 수 있도록함
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
	public void insert(String deviceID) {
		String SQL = "INSERT INTO deviceRec VALUES(NULL, ?, ?, ?)";
		try {
			PatientInfoDAO patientInfoDAO = new PatientInfoDAO(); 
			int userID = patientInfoDAO.getUserID(deviceID);
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, deviceID);
			pstmt.setInt(2, userID);
			pstmt.setString(3, getDate());

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
	}
	public ArrayList<DeviceRec> getRoomRec(String roomNo) {
		PatientInfoDAO patientInfoDAO = new PatientInfoDAO();
		ArrayList<Integer> userList = patientInfoDAO.getRoomUserList(roomNo);
		String userID = userList.toString();
		userID = userID.substring(1, userID.length()-1);
		
		String SQL = "SELECT deviceID, userID, datatime FROM deviceRec WHERE userID IN(" + userID + ") ORDER BY datatime DESC";
		ArrayList<DeviceRec> list = new ArrayList<DeviceRec>();
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				DeviceRec deviceRec = new DeviceRec();
				deviceRec.setDeviceID(rs.getString(1));
				deviceRec.setUserID(rs.getInt(2));
				deviceRec.setDatatime(rs.getString(3));
				
				list.add(deviceRec);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return list;
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
