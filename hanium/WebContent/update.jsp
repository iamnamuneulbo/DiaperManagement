<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="device.PatientInfoDAO"%>
<%@ page import="device.DeviceInfoDAO"%>

<%
	String target = request.getParameter("target");

	if (target.equals("patient")) {
		String roomNo = request.getParameter("roomNo");
		String bedNo = request.getParameter("bedNo");
		String deviceID = request.getParameter("deviceID");
		String patientID = request.getParameter("patientID");
		System.out.println(patientID+"수정");
		PatientInfoDAO patientInfoDAO = new PatientInfoDAO();
		patientInfoDAO.update(roomNo, Integer.valueOf(bedNo), deviceID, Integer.valueOf(patientID));
		response.sendRedirect("patients_admin.jsp");
		
	}
	else if (target.equals("device")) {
		String checkDate = request.getParameter("checkDate");
		String deviceID = request.getParameter("deviceID");
		System.out.println(deviceID+"수정"+checkDate);
		DeviceInfoDAO deviceInfoDAO = new DeviceInfoDAO();
		deviceInfoDAO.update(checkDate, deviceID);
		response.sendRedirect("devices_admin.jsp");
	}
%>