<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="device.Room"%>
<%@ page import="device.RoomDAO"%>
<%@ page import="device.DeviceInfo"%>
<%@ page import="device.DeviceInfoDAO"%>
<%@ page import="device.DeviceVal"%>
<%@ page import="device.DeviceValDAO"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");

	DeviceValDAO deviceValDAO = new DeviceValDAO();
	DeviceInfoDAO deviceInfoDAO = new DeviceInfoDAO();

	ArrayList<String> RDList = deviceInfoDAO.getRoomDeviceList("201");

	String deviceID, dataTime, tag, img, userName, ststeText;
	int temperature, humidity, gas, state = 0, cnt = 0;

	for (String rs : RDList) {
		System.out.println(rs);
		DeviceVal deviceVal = deviceValDAO.getValue(rs);
		
		deviceID = deviceVal.getDeviceID();
		dataTime = deviceVal.getDatatime();
		temperature = deviceVal.getTemperature();
		humidity = deviceVal.getHumidity();
		gas = deviceVal.getGas();

		userName = deviceInfoDAO.getUserName(deviceID);

		if (state == 0) {
			tag = "success";
			img = "far fa-smile";
			ststeText = "좋음";
		} else if (state == 1) {
			tag = "warning";
			img = "far fa-meh";
			ststeText = "보통";
		} else {
			tag = "danger";
			img = "far fa-frown";
			ststeText = "나쁨";
		}
	%>

	<%
		}
	%>

</body>
</html>