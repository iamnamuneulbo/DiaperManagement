package device;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class RoomDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;

	public RoomDAO() {
		try {
			String dbURL = "jdbc:mysql://3.13.163.79:3306/han_db?autoReconnect=true&serverTimezone=Asia/Seoul";
			String dbID = "admin";
			String dbPassword = "ifnt0719";
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace(); // 오류가 무엇인지 출력
		}
	}

	public ArrayList<Room> getRoomList() {
		String SQL = "SELECT * FROM room ORDER BY roomNo";
		ArrayList<Room> list = new ArrayList<Room>();
		
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Room room = new Room();
				room.setRoomNo(rs.getString(1));
				room.setMaxBed(rs.getInt(2));
				list.add(room);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return list;
	}
	
	public void insert(String roomNo, int maxBed) {
		String SQL = "INSERT INTO room VALUES(?, ?)";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, roomNo);
			pstmt.setInt(2, maxBed);

			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
	}
	
	public void update(String roomNo, int maxBed) {
		String SQL = "UPDATE room SET roomNo=? WHERE maxBed=?";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, roomNo);
			pstmt.setInt(2, maxBed);
			
			pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
	}

	public void delete(String roomNo) {
		String SQL = "DELETE FROM room WHERE roomNo=?";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, roomNo);

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
			//logger.debug("\n[ DBConnection Close Exception ] " + e.toString());
		}
	}
}
