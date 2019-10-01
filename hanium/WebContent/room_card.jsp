<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="device.RoomDAO"%>
<%@ page import="device.Room"%>
<%@ page import="device.PatientInfoDAO"%>
<%@ page import="device.PatientInfo"%>
<%@ page import="device.DeviceValDAO"%>
<%@ page import="device.DeviceVal"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<body>
	<%
		String pageRoomNo = request.getParameter("roomNo");
	%>
	<div class="container">
		<article class="row">
			<%
				request.setCharacterEncoding("UTF-8");

				DeviceValDAO deviceValDAO2 = new DeviceValDAO();
				PatientInfoDAO patientInfoDAO2 = new PatientInfoDAO();
				ArrayList<PatientInfo> RDList = patientInfoDAO2.getRoomDeviceBed(pageRoomNo); // 병실의 기기 목록 가져오기
				SimpleDateFormat lformat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				SimpleDateFormat sformat = new SimpleDateFormat("MM/dd HH:mm");

				String deviceID, dataTime, dataTimeF, tag, img, userName, ststeText;
				int temperature, humidity, gas, state = -1, cardCnt = 0, bedNo;

				for (PatientInfo rs : RDList) {
					DeviceVal deviceVal = deviceValDAO2.getValue(rs.getDeviceID()); // 기기 아이디-수집한 값 가져오기 

					deviceID = deviceVal.getDeviceID();
					dataTime = deviceVal.getDatatime();
					temperature = deviceVal.getTemperature();
					humidity = deviceVal.getHumidity();
					gas = deviceVal.getGas();
					state = deviceVal.getState();
					bedNo = rs.getBedNo();

					userName = patientInfoDAO2.getUserName(deviceID);
					dataTimeF = sformat.format(lformat.parse(dataTime));

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

					while ((cardCnt + 1) != bedNo) { // 카드 위치와 침대 위치가 일치하지 않으면 빈 공간 출력
			%>
			<div class="col-5 mb-4"></div>
			<%
				cardCnt++;
						if (cardCnt % 2 == 1) {
			%>
			<div class="col-2 mb-4"></div>
			<%
				}
					}
					cardCnt++;
			%>
			<div class="col-5 mb-4">
				<div class="card bg-<%=tag%> shadow mb-2">
					<div class="card-header bg-<%=tag%> py-2">
						<h6 class="m-0 font-weight-bold text-gray-100">
							<i class="fas fa-procedures"></i> [<%=bedNo%>] | <i
								class="fas fa-user"></i>
							<%=userName%>
							| <i class="fas fa-microchip"></i> [<%=deviceID%>]
						</h6>
					</div>
					<div class="card-body text-gray-100 py-2">
						<h4 class="card-title d-inline align-middle"><%=ststeText%></h4>
						<i class="<%=img%> fa-3x float-right"></i>
						<p class="card-text">
							<br /> <i class="fas fa-fw fa-thermometer-half"></i> 온도<span
								class="float-right"><%=temperature%></span><br> <i
								class="fas fa-fw fa-tint"></i> 습도<span class="float-right"><%=humidity%></span><br>
							<i class="fas fa-fw fa-wind"></i> 가스<span class="float-right"><%=gas%></span><br>
							<span class="float-right"><%=dataTimeF%></span>
						</p>
					</div>
				</div>
			</div>
			<%
				if (cardCnt % 2 == 1) { // 병상 사이 여백 출력
			%>
			<div class="col-2 mb-4"></div>
			<%
				}
				}
			%>
		</article>
		<article class="row">
			<div class="col-5 mb-4"></div>
			<div class="col-2 mb-4">
				<div class="card bg-secondary text-white shadow">
					<div class="card-body text-center">입구</div>
				</div>
			</div>
			<div class="col-5 mb-4"></div>
		</article>
	</div>
</body>
</html>