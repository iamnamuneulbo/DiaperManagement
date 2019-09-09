<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*, java.util.*, java.text.*"%>
<%@ page import="device.DeviceValDAO"%>

<jsp:useBean id="device" class="device.DeviceVal" scope="page" />
<jsp:setProperty name="device" property="deviceID" />
<jsp:setProperty name="device" property="datatime" />
<jsp:setProperty name="device" property="temperature" />
<jsp:setProperty name="device" property="humidity" />
<jsp:setProperty name="device" property="gas" />
<%
	request.setCharacterEncoding("UTF-8");

	String date;
	String temp;
	String humi;
	String gas;
	
	Connection conn = null;
	PreparedStatement pstmt = null;

	try {
		String jdbcUrl = "jdbc:mysql://3.13.163.79:3306/han_db?serverTimezone=UTC";
		String dbId = "lsk";
		String dbPass = "100609";

		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPass);
		
		//System.out.println("MySQL Conn");
		String sql = "INSERT INTO test VALUES(?, ?, ?, ?)";
		pstmt = conn.prepareStatement(sql);

		java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		date = formatter.format(new java.util.Date());
		temp = request.getParameter("temp");
		humi = request.getParameter("humi");
		gas = request.getParameter("gas");
				
		pstmt.setString(1, date);
		pstmt.setString(2, temp);
		pstmt.setString(3, humi);
		pstmt.setString(4, gas);
		pstmt.executeUpdate();
		out.println("MySQL Connection Success!");
	} catch (Exception e) {
		out.println(e);
		e.printStackTrace();
	} finally {
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
