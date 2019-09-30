<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*, java.util.*, java.text.*"%>
<%@ page import="device.DeviceValDAO"%>
<%@ page import="java.io.PrintWriter"%>

<jsp:useBean id="deviceVal" class="device.DeviceVal" scope="page" />
<jsp:setProperty name="deviceVal" property="deviceID" />
<jsp:setProperty name="deviceVal" property="temperature" />
<jsp:setProperty name="deviceVal" property="humidity" />
<jsp:setProperty name="deviceVal" property="gas" />
<%
	request.setCharacterEncoding("UTF-8");

	DeviceValDAO deviceValDAO = new DeviceValDAO();
	
	String deviceID = deviceVal.getDeviceID();
	int temperature = deviceVal.getTemperature();
	int humidity = deviceVal.getHumidity();
	int gas = deviceVal.getGas();
	int sum = temperature + humidity + gas;
	
	if (sum > 60) {
		deviceVal.setState(2);
	}
	else if (sum > 40) {
		deviceVal.setState(1);
	}
	else {
		deviceVal.setState(0);
	}

	int res = deviceValDAO.insertValues(deviceVal);
	
	PrintWriter script = response.getWriter();

	if (res == -1) script.println("입력실패");
	else script.println(res);
	
	
%>
