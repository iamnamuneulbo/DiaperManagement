<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="device.DeviceInfoDAO"%>
<%@ page import="device.DeviceInfo"%>

<%
	String target = request.getParameter("target");
	String deviceID = request.getParameter("deviceID");

	if (target.equals("device")) {
		System.out.println(deviceID+"삭제");
		DeviceInfoDAO deviceInfoDAO = new DeviceInfoDAO();
		deviceInfoDAO.delete(deviceID);
		response.sendRedirect("devices_admin.jsp");
	}
%>