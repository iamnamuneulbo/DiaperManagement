<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="device.PatientInfoDAO"%>
<%@ page import="device.DeviceInfoDAO"%>
<%@ page import="device.RoomDAO"%>
<%@ page import="setting.SettingDAO"%>

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
	} else if (target.equals("room")) {
		String roomNo = request.getParameter("roomNo");
		String maxBed = request.getParameter("maxBed");
		int intMaxBed = Integer.valueOf(maxBed);
		RoomDAO roomDAO = new RoomDAO();
		roomDAO.update(roomNo, intMaxBed);
		
		response.sendRedirect("rooms_admin.jsp");
	} else if (target.equals("setting")) {
		String temp = request.getParameter("temp");
		String humi = request.getParameter("humi");
		String gas = request.getParameter("gas");
		SettingDAO settingDAO = new SettingDAO();
		settingDAO.insert(Integer.valueOf(temp), Integer.valueOf(humi), Integer.valueOf(gas));
		
		response.sendRedirect("index.jsp");
	}
%>