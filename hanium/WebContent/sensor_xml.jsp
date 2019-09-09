<%@ page trimDirectiveWhitespaces="true" %>
<%@ page language="java" contentType="text/xml;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="device.DeviceValDAO"%>
<%@ page import="device.DeviceVal"%>
<%@ page import="java.util.ArrayList"%>
<?xml version="1.0" encoding="UTF-8"?>
<response> 
	<items>
	<%
		request.setCharacterEncoding("UTF-8");
		
		DeviceValDAO deviceValDAO = new DeviceValDAO();
		ArrayList<DeviceVal> list = deviceValDAO.getList();
		
		int count = list.size();
		
		String deviceID, dataTime;
		int temperature, humidity, gas;

		for (DeviceVal rs : list) {
			deviceID = rs.getDeviceID();
			dataTime = rs.getDatatime();
			temperature = rs.getTemperature();
			humidity = rs.getHumidity();
			gas = rs.getGas();
		%>
		<item>
			<deviceID><%=deviceID%></deviceID>
			<dataTime><%=dataTime%></dataTime>
			<temperature><%=temperature%></temperature> 
			<humidity><%=humidity%></humidity> 
			<gas><%=gas%></gas> 
		</item>
		<%}%>
	</items>
	<totalCount><%=count%></totalCount> 
</response>