<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="device.DeviceInfoDAO"%>
<%@ page import="device.DeviceInfo"%>
<%@ page import="device.RoomDAO"%>

<%
	request.setCharacterEncoding("UTF-8");
	String target = request.getParameter("target");
	String deviceID = request.getParameter("deviceID");

	if (target.equals("device")) {
		System.out.println(deviceID + "삭제");
		DeviceInfoDAO deviceInfoDAO = new DeviceInfoDAO();
		deviceInfoDAO.delete(deviceID);
		
		response.sendRedirect("devices_admin.jsp");
	} else if (target.equals("room")) {
		String roomNo = request.getParameter("roomNo");
		RoomDAO roomDAO = new RoomDAO();
		roomDAO.delete(roomNo);

		response.sendRedirect("rooms_admin.jsp");
	}
%>