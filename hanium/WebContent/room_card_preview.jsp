<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="device.RoomDAO"%>
<%@ page import="device.Room"%>
<%@ page import="device.DeviceInfoDAO"%>
<%@ page import="device.DeviceValDAO"%>
<%@ page import="device.DeviceVal"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
	<%
		String pageRoomNo = request.getParameter("roomNo");
	%>
	<div class="container">
		<article class="row">
			<%
				request.setCharacterEncoding("UTF-8");

				DeviceValDAO deviceValDAO2 = new DeviceValDAO();
				DeviceInfoDAO deviceInfoDAO2 = new DeviceInfoDAO();
				ArrayList<String> RDList = deviceInfoDAO2.getRoomDeviceList(pageRoomNo);

				String deviceID, dataTime, tag, img, userName, ststeText;
				int temperature, humidity, gas, state = -1, cardCnt = 0;

				for (String rs : RDList) {
					DeviceVal deviceVal = deviceValDAO2.getValue(rs);

					deviceID = deviceVal.getDeviceID();
					dataTime = deviceVal.getDatatime();
					temperature = deviceVal.getTemperature();
					humidity = deviceVal.getHumidity();
					gas = deviceVal.getGas();
					state = deviceVal.getState();

					userName = deviceInfoDAO2.getUserName(deviceID);

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

			<div class="col-5 mb-4">
				<div class="card bg-<%=tag%> shadow mb-2">
					<div class="card-header bg-<%=tag%> py-2">
						<h6 class="m-0 font-weight-bold text-gray-100">
							[<%=deviceID%>]
							<%=userName%></h6>
					</div>
					<div class="card-body text-gray-100 py-2">
						<h4 class="card-title d-inline align-middle"><%=ststeText%></h4>
						<i class="<%=img%> fa-3x float-right"></i>
						<p class="card-text">
							<br /> <i class="fas fa-fw fa-thermometer-half"></i> 온도<span
								class="float-right"><%=temperature%></span><br /> <i
								class="fas fa-fw fa-tint"></i> 습도<span class="float-right"><%=humidity%></span><br />
							<i class="fas fa-fw fa-wind"></i> 가스<span class="float-right"><%=gas%></span><br />
							<span class="float-right"><%=dataTime%></span>
						</p>
					</div>
				</div>
			</div>
	</div>

	<%
		if (cardCnt % 2 == 0) {
	%>
	<section class="col-2 mb-2"></section>
	<%
		}
			cardCnt++;
		}
	%>
	<section class="col-5 mb-2"></section>
	<section class="col-2 mb-2">
		<div class="card bg-secondary text-white shadow">
			<div class="card-body text-center">입구</div>
		</div>
	</section>
	<section class="col-2 mb-2"></section>
	</article>
	</div>

</body>
</html>