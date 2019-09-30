package device;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
			Class.forName("com.mysql.jdbc.Driver");
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
		}
		return ""; // DB 오류
	}

	public int insertValues(DeviceVal deviceVal) {
		String SQL = "INSERT INTO deviceVal VALUES(?, ?, ?, ?, ?, ?, NULL)";

		try {
			pstmt = conn.prepareStatement(SQL);

			pstmt.setString(1, deviceVal.getDeviceID());
			pstmt.setString(2, getDate());
			pstmt.setInt(3, deviceVal.getTemperature());
			pstmt.setInt(4, deviceVal.getHumidity());
			pstmt.setInt(5, deviceVal.getGas());
			pstmt.setInt(6, deviceVal.getState());

			return pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
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
				deviceVal.setDatatime(rs.getString(2));
				deviceVal.setTemperature(rs.getInt(3));
				deviceVal.setHumidity(rs.getInt(4));
				deviceVal.setGas(rs.getInt(5));
				deviceVal.setValueID(rs.getInt(6));
				list.add(deviceVal);
			}
		} catch (Exception e) {
			e.printStackTrace();
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
			deviceVal.setDatatime(rs.getString(2));
			deviceVal.setTemperature(rs.getInt(3));
			deviceVal.setHumidity(rs.getInt(4));
			deviceVal.setGas(rs.getInt(5));
			deviceVal.setState(rs.getInt(6));
			deviceVal.setValueID(rs.getInt(7));
		} catch (Exception e) {
			e.printStackTrace();
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
		}
		return state;
	}
}
