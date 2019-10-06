package device;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class DeviceValDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	public DeviceValDAO() { // 생성자 실행될때마다 자동으로 db연결이 이루어 질 수 있도록함
		try {
			String dbURL = "jdbc:mysql://3.13.163.79:3306/han_db?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=Asia/Seoul";
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
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return ""; // DB 오류
	}

	public int insert(String deviceID, int userID, int temperature, int humidity, int gas, int state) {
		String SQL = "INSERT INTO deviceVal VALUES(?, ?, ?, ?, ?, ?, ?, NULL)";

		try {
			pstmt = conn.prepareStatement(SQL);

			pstmt.setString(1, deviceID);
			pstmt.setInt(2, userID);
			pstmt.setString(3, getDate());
			pstmt.setInt(4, temperature);
			pstmt.setInt(5, humidity);
			pstmt.setInt(6, gas);
			pstmt.setInt(7, state);

			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return -1; // DB 오류
	}

	public ArrayList<DeviceVal> getList() {
		String SQL = "SELECT * FROM deviceVal ORDER BY DATATIME DESC LIMIT 4";
		ArrayList<DeviceVal> list = new ArrayList<DeviceVal>();

		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				DeviceVal deviceVal = new DeviceVal();
				deviceVal.setDeviceID(rs.getString(1));
				deviceVal.setUserID(rs.getInt(2));
				deviceVal.setDatatime(rs.getString(3));
				deviceVal.setTemperature(rs.getInt(4));
				deviceVal.setHumidity(rs.getInt(5));
				deviceVal.setGas(rs.getInt(6));
				deviceVal.setState(rs.getInt(7));
				deviceVal.setValueID(rs.getInt(8));
				list.add(deviceVal);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return list;
	}
	
	public ArrayList<DeviceVal> getValueList(String deviceID, int userID) {
		String SQL = "SELECT * FROM deviceVal WHERE deviceID=? AND userID=? ORDER BY DATATIME DESC";
		ArrayList<DeviceVal> list = new ArrayList<DeviceVal>();

		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, deviceID);
			pstmt.setInt(2, userID);

			rs = pstmt.executeQuery();
			while (rs.next()) {
				DeviceVal deviceVal = new DeviceVal();
				deviceVal.setDeviceID(rs.getString(1));
				deviceVal.setUserID(rs.getInt(2));
				deviceVal.setDatatime(rs.getString(3));
				deviceVal.setTemperature(rs.getInt(4));
				deviceVal.setHumidity(rs.getInt(5));
				deviceVal.setGas(rs.getInt(6));
				deviceVal.setState(rs.getInt(7));
				deviceVal.setValueID(rs.getInt(8));
				list.add(deviceVal);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return list;
	}

	public DeviceVal getValue(String deviceID) {
		String SQL = "SELECT * FROM deviceVal WHERE deviceID=" + deviceID + " ORDER BY DATATIME DESC LIMIT 1";
		DeviceVal deviceVal = new DeviceVal();

		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			rs.next();
			deviceVal.setDeviceID(rs.getString(1));
			deviceVal.setUserID(rs.getInt(2));
			deviceVal.setDatatime(rs.getString(3));
			deviceVal.setTemperature(rs.getInt(4));
			deviceVal.setHumidity(rs.getInt(5));
			deviceVal.setGas(rs.getInt(6));
			deviceVal.setState(rs.getInt(7));
			deviceVal.setValueID(rs.getInt(8));
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return deviceVal;
	}
	

	public int getState(String deviceID) {
		String SQL = "SELECT state FROM deviceVal WHERE deviceID=" + deviceID + " ORDER BY DATATIME DESC LIMIT 1";
		int state = -1;

		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			rs.next();
			state = rs.getInt(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return state;
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
