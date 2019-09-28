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
<body>
	<%
		String pageRoomNo = request.getParameter("roomNo");
	%>
		<!-- DataTales Example -->
		<div class="col-xl-4 col-lg-5">
			<div class="card shadow mb-4">
				<div class="card-header py-3">
					<h6 class="m-0 font-weight-bold text-primary">기저귀 교환 기록</h6>
				</div>
				<div class="card-body">
					<div class="table-responsive">
						<table class="table table-bordered display" id="dataTable" width="100%"
							cellspacing="0">
							<thead>
								<tr>
									<th>이름</th>
									<th>교체 일시</th>
								</tr>
							</thead>
							<tfoot>
								<tr>
									<th>이름</th>
									<th>교체 일시</th>
								</tr>
							</tfoot>
							<tbody>
								<%
									request.setCharacterEncoding("UTF-8");

									DeviceValDAO deviceValDAO4 = new DeviceValDAO();
									DeviceInfoDAO deviceInfoDAO4 = new DeviceInfoDAO();
									ArrayList<String> RDList = deviceInfoDAO4.getRoomDeviceList(pageRoomNo);

									String deviceID, dataTime, tag, img, userName, ststeText;
									int temperature, humidity, gas;

									for (String rs : RDList) {
										DeviceVal deviceVal = deviceValDAO4.getValue(rs);

										deviceID = deviceVal.getDeviceID();
										dataTime = deviceVal.getDatatime();
										temperature = deviceVal.getTemperature();
										humidity = deviceVal.getHumidity();
										gas = deviceVal.getGas();
										userName = deviceInfoDAO4.getUserName(deviceID);
								%>
								<tr>
									<td><%=userName%></td>
									<td><%=dataTime%></td>
								</tr>
								<tr>
									<td><%=userName%></td>
									<td><%=dataTime%></td>
								</tr>
								<tr>
									<td><%=userName%></td>
									<td><%=dataTime%></td>
								</tr>
								<%
									}
								%>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>

</body>
</html>