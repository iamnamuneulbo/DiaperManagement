<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="device.PatientInfoDAO"%>
<%@ page import="device.DeviceInfoDAO"%>

<%
	request.setCharacterEncoding("UTF-8");
	String target = request.getParameter("target");

	if (target.equals("patient")) {
		String roomNo = request.getParameter("roomNo");
		String bedNo = request.getParameter("bedNo");
		String deviceID = request.getParameter("deviceID");
		String userID = request.getParameter("userID");
		PatientInfoDAO patientInfoDAO = new PatientInfoDAO();
		patientInfoDAO.update(roomNo, Integer.valueOf(bedNo), deviceID, Integer.valueOf(userID));
		response.sendRedirect("patients_admin.jsp");

	} else if (target.equals("device")) {
		String checkDate = request.getParameter("checkDate");
		String deviceID = request.getParameter("deviceID");
		DeviceInfoDAO deviceInfoDAO = new DeviceInfoDAO();
		deviceInfoDAO.update(checkDate, deviceID);
		response.sendRedirect("devices_admin.jsp");
	}
%>