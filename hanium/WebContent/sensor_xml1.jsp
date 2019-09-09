<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/xml;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Calendar"%>

<?xml version="1.0" encoding="UTF-8"?>
<response> 
	<items>
	<%
		request.setCharacterEncoding("UTF-8");

		int count = 0;

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String deviceID, dataTime;
		int temperature, humidity, gas;

		Calendar cal = Calendar.getInstance();

	
		try {
			String jdbcUrl = "jdbc:mysql://3.13.163.79:3306/han_db?serverTimezone=UTC";
			String dbId = "lsk";
			String dbPass = "100609";

			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
			
			
			String sql = "SELECT * FROM deviceVal ORDER BY DATATIME DESC";
			
			System.out.println(sql);
			
			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				deviceID = rs.getString("deviceID");
				dataTime = rs.getString("datatime");
				temperature = rs.getInt("temperature");
				humidity = rs.getInt("humidity");
				gas = rs.getInt("gas");
				count++;
				
		%>
		<item>
			<deviceID><%=deviceID%></deviceID>
			<dataTime><%=dataTime%></dataTime>
			<temperature><%=temperature%></temperature> 
			<humidity><%=humidity%></humidity> 
			<gas><%=gas%></gas> 
		</item>
		<%
			}} catch (ClassNotFoundException e) {
				e.printStackTrace();	
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				if (rs != null)
					try {
						rs.close();
					} catch (SQLException sqle) {
					}
				if (pstmt != null)
					try {
						pstmt.close();
					} catch (SQLException sqle) {
					}
				if (conn != null)
					try {
						conn.close();
					} catch (SQLException sqle) {
					}
			}
			%>
	</items>
	<totalCount><%=count%></totalCount> 
</response>