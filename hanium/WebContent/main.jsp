<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="device.DeviceValDAO"%>
<%@ page import="device.DeviceVal"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>메인화면</title>
<!-- 스타일시트 참조  -->
<link rel="stylesheet" href="css/bootstrap.min.css">
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
		integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
		crossorigin="anonymous"></script>
</head>

<body>
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
<link href="css/card.css" rel="stylesheet">
<div class="container">
    <div class="row">
        <%
		request.setCharacterEncoding("UTF-8");
		
		DeviceValDAO deviceValDAO = new DeviceValDAO();
		ArrayList<DeviceVal> list = deviceValDAO.getList();
		
		String deviceID, dataTime, tag, state;
		int temperature, humidity, gas, sum;

		for (DeviceVal rs : list) {
			deviceID = rs.getDeviceID();
			dataTime = rs.getDatatime();
			temperature = rs.getTemperature();
			humidity = rs.getHumidity();
			gas = rs.getGas();
			sum = temperature + humidity + gas;
			
			if (sum < 80) {
				tag = "bg-c-blue";
				state = "좋음";
			}
			else if (sum < 100) {
				tag = "bg-c-yellow"; 
				state = "보통";
			}
			else {
				tag = "bg-c-pink"; 
				state = "나쁨";
			}
		%>
		<div class="col-md-4 col-xl-3">
            <div class="card <%=tag%> order-card">
                <div class="card-block">
                    <h6 class="m-b-20">[<%=deviceID%>]</h6>
                    <h2 class="text-right"><i class="fa fa-cart-plus f-left"></i><span><%=state%></span></h2>
                    <p class="m-b-0"><%=dataTime%><span class="f-right"></span></p>
                    <p class="m-b-0">온도<span class="f-right"><%=temperature%></span></p>
                    <p class="m-b-0">습도<span class="f-right"><%=humidity%></span></p>
                    <p class="m-b-0">가스<span class="f-right"><%=gas%></span></p>
                </div>
            </div>
        </div>
        
		<%}%>
	</div>
</div>

	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU" crossorigin="anonymous">
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="js/bootstrap.min.js"></script>

</body>
</html>