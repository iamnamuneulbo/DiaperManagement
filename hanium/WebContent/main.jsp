<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="device.DeviceInfoDAO"%>
<%@ page import="device.DeviceValDAO"%>
<%@ page import="device.DeviceVal"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>메인화면</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 스타일시트 참조  -->
<link rel="stylesheet" href="css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
	integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
	crossorigin="anonymous"></script>
</head>

<body>
	<div class="container">
		<div class="row">
			<div class="col-lg-12">
				<h1>한이음 스마트 기저귀 Main Page</h1>
				<p class="lead">기기의 최근 기록 출력</p>
			</div>
			<%
				request.setCharacterEncoding("UTF-8");

				DeviceValDAO deviceValDAO = new DeviceValDAO();
				ArrayList<DeviceVal> list = deviceValDAO.getList();

				DeviceInfoDAO deviceInfoDAO = new DeviceInfoDAO();

				String deviceID, dataTime, tag, state, img, userName;
				int temperature, humidity, gas, sum;

				for (DeviceVal rs : list) {
					deviceID = rs.getDeviceID();
					dataTime = rs.getDatatime();
					temperature = rs.getTemperature();
					humidity = rs.getHumidity();
					gas = rs.getGas();
					sum = temperature + humidity + gas;

					userName = deviceInfoDAO.getUserName(deviceID);

					if (sum < 80) {
						tag = "bg-success";
						img = "smile";
						state = "좋음";
					} else if (sum < 100) {
						tag = "bg-warning";
						img = "meh";
						state = "보통";
					} else {
						tag = "bg-danger";
						img = "sad";
						state = "나쁨";
					}
			%>
			<div class="col-md-4 col-xl-3">
				<div class="card text-white <%=tag%> mt-1 mb-1 ml-1 mr-1">
					<div class="card-header">
						[<%=deviceID%>]
						<%=userName%></div>
					<div class="card-body">
						<img src="img/<%=img%>.png" alt="<%=state%>"
							class="img-responsive w-20 float-right d-inline">
						<h4 class="card-title d-inline align-middle"><%=state%></h4>
						<p class="card-text"><br><br>
						온도<span class="float-right"><%=temperature%></span><br>
						습도<span class="float-right"><%=humidity%></span><br>
						가스<span class="float-right"><%=gas%></span><br>
						<span class="float-right"><%=dataTime%></span>
						
						</p>
					</div>
				</div>
			</div>
			<%
				}
			%>
		</div>
	</div>

	<link rel="stylesheet"
		href="https://use.fontawesome.com/releases/v5.5.0/css/all.css"
		integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU"
		crossorigin="anonymous">
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
		integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
		crossorigin="anonymous"></script>
	<script src="js/bootstrap.min.js"></script>

</body>
</html>