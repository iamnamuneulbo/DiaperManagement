<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*, java.util.*, java.text.*"%>
<%@ page import="device.DeviceValDAO"%>
<%@ page import="device.DeviceInfoDAO"%>
<%@ page import="device.RoomDAO"%>
<%@ page import="device.PatientInfoDAO"%>
<%@ page import="device.DeviceRecDAO"%>
<%@ page import="setting.Setting"%>
<%@ page import="setting.SettingDAO"%>
<%@ page import="java.io.PrintWriter"%>

<%
	request.setCharacterEncoding("UTF-8");
	String target = request.getParameter("target");

	if (target.equals("deviceVal")) {
		SettingDAO settingDAO = new SettingDAO();
		Setting setting = settingDAO.getValue();
		
		String deviceID = request.getParameter("deviceID");
		String temperature = request.getParameter("temperature");
		String humidity = request.getParameter("humidity");
		String gas = request.getParameter("gas");
		
		int state;
		int intTemp = Integer.valueOf(temperature);
		int intHumi = Integer.valueOf(humidity);
		int intGas = Integer.valueOf(gas);

		int stdTemp = setting.getTemperature();
		int stdHumi = setting.getHumidity();
		int stdGas = setting.getGas();
		
		if (intTemp > stdTemp + 3 || intHumi > stdHumi + 5) {
			state = 2;
		} else if (intTemp > stdTemp || intHumi > stdHumi) {
			state = 1;
		} else {
			state = 0;
		}

		DeviceValDAO deviceValDAO = new DeviceValDAO();
		PatientInfoDAO patientInfoDAO = new PatientInfoDAO();
		int userID = patientInfoDAO.getUserID(deviceID);
		int res = deviceValDAO.insert(deviceID, userID, intTemp, intHumi, intGas, state);

		PrintWriter script = response.getWriter();

		if (res == -1) {
			script.println("입력실패");
		} else {
			script.println(res);
		}
	} else if (target.equals("record")) {
		String deviceID = request.getParameter("deviceID");
		DeviceRecDAO deviceRecDAO = new DeviceRecDAO();
		deviceRecDAO.insert(deviceID);
		
	} else if (target.equals("device")) {
		String deviceID = request.getParameter("deviceID");
		DeviceInfoDAO deviceInfoDAO = new DeviceInfoDAO();
		deviceInfoDAO.insert(deviceID);

		response.sendRedirect("devices_admin.jsp");
	} else if (target.equals("room")) {
		String roomNo = request.getParameter("roomNo");
		String maxBed = request.getParameter("maxBed");
		int intMaxBed = Integer.valueOf(maxBed);
		RoomDAO roomDAO = new RoomDAO();
		roomDAO.insert(roomNo, intMaxBed);

		response.sendRedirect("rooms_admin.jsp");
	}
%>
