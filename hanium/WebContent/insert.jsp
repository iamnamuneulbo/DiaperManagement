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
	
	int temperature = deviceVal.getTemperature();
	int humidity = deviceVal.getHumidity();
	int gas = deviceVal.getGas();
	int sum = temperature + humidity + gas;	
	int res = deviceValDAO.insertValues(deviceVal.getDeviceID(), temperature, humidity, gas, sum);
	
	PrintWriter script = response.getWriter();
	if (res == -1) script.println("입력실패");
	else script.println(res);
%>