<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="device.RoomDAO"%>
<%@ page import="device.Room"%>
<%@ page import="device.PatientInfoDAO"%>
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
	<div class="col-xl-8 col-lg-7">
		<div class="card shadow mb-4">
			<div class="card-header py-3">
				<h6 class="m-0 font-weight-bold text-primary">환자별 통계</h6>
			</div>
			<div class="card-body">
				<div class="table-responsive">
					<table class="table table-bordered display" id="room-statistic-table"
						width="100%" cellspacing="0">
						<thead>
							<tr>
								<th>이름</th>
								<th>평균 온도</th>
								<th>평균 습도</th>
								<th>평균 가스</th>
								<th>평균 교체 주기</th>
							</tr>
						</thead>
						<tfoot>
							<tr>
								<th>이름</th>
								<th>평균 온도</th>
								<th>평균 습도</th>
								<th>평균 가스</th>
								<th>평균 교체 주기</th>
							</tr>
						</tfoot>
						<tbody>
							<%
								request.setCharacterEncoding("UTF-8");

								ArrayList<DeviceVal> valueList = new ArrayList<DeviceVal>();
								DeviceValDAO deviceValDAO3 = new DeviceValDAO();
								PatientInfoDAO patientInfoDAO3 = new PatientInfoDAO();
								ArrayList<Integer> RUList = patientInfoDAO3.getRoomUserList(pageRoomNo);

								String dataTime, tag, img, userName, ststeText;
								double temperature, humidity, avgTemp, avgHumi, avgGas;
								int gas;

								for (int userID : RUList) {
									userName = patientInfoDAO3.getUserName(userID);

									DeviceVal deviceVal = deviceValDAO3.getAvgValue(userID);
									avgTemp = deviceVal.getTemperature() * 100 / 100.0;
									avgHumi = deviceVal.getHumidity() * 100 / 100.0;
									avgGas = deviceVal.getGas() * 100 / 100.0;
							%>
							<tr>
								<td><%=userName%></td>
								<td><%=avgTemp%></td>
								<td><%=avgHumi%></td>
								<td><%=avgGas%></td>
								<td>(추후 수정)</td>
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