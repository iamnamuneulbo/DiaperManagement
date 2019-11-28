package device;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class PatientInfoDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	public PatientInfoDAO() {
		try {
			String dbURL = "jdbc:mysql://3.136.120.235:3306/han_db?autoReconnect=true&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=Asia/Seoul";
			String dbID = "admin";
			String dbPassword = "Infinite0609!";
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace(); // 오류가 무엇인지 출력
		}
	}

	public ArrayList<PatientInfo> getList() {
		String SQL = "SELECT * FROM patient ORDER BY bedNo";
		ArrayList<PatientInfo> list = new ArrayList<PatientInfo>();

		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				PatientInfo patientInfo = new PatientInfo();
				patientInfo.setUserID(rs.getInt(1));
				patientInfo.setUserName(rs.getString(2));
				patientInfo.setRoomNo(rs.getString(3));
				patientInfo.setBedNo(rs.getInt(4));
				patientInfo.setDeviceID(rs.getString(5));
				list.add(patientInfo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return list;
	}

	public ArrayList<PatientInfo> getRoomDeviceBed(String roomNo) {
		String SQL = "SELECT deviceID, bedNo FROM patient WHERE roomNo=? ORDER BY bedNo";
		ArrayList<PatientInfo> list = new ArrayList<PatientInfo>();

		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, roomNo);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				PatientInfo patientInfo = new PatientInfo();
				patientInfo.setDeviceID(rs.getString(1));
				patientInfo.setBedNo(rs.getInt(2));
				list.add(patientInfo);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return list;
	}

	public ArrayList<Integer> getRoomUserList(String roomNo) {
		String SQL = "SELECT userID FROM patient WHERE roomNo=? ORDER BY bedNo";
		ArrayList<Integer> list = new ArrayList<Integer>();

		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, roomNo);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				list.add(rs.getInt(1));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return list;
	}

	public String getUserName(String deviceID) {
		String userName = null;
		String SQL = "SELECT userName FROM patient WHERE deviceID=?";

		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, deviceID);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				userName = rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return userName;
	}
	public String getUserName(int userID) {
		String userName = null;
		String SQL = "SELECT userName FROM patient WHERE userID=?";

		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, userID);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				userName = rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return userName;
	}
	public int getUserID(String deviceID) {
		int userID = 0;
		String SQL = "SELECT userID FROM patient WHERE deviceID=?";

		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, deviceID);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				userID = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return userID;
	}
	public String getDeviceID(int userID) {
		String SQL = "SELECT deviceID FROM patient WHERE userID=?";
		String deviceID = "";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, userID);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				deviceID = rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return deviceID;
	}

	public void update(String roomNo, int bedNo, String deviceID, int userID) {
		String SQL = "UPDATE patient SET roomNo=?, bedNo=?, deviceID=? WHERE userID=?";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, roomNo);
			pstmt.setInt(2, bedNo);
			pstmt.setString(3, deviceID);
			pstmt.setInt(4, userID);
			
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
