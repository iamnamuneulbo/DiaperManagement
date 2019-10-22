<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="device.PatientInfoDAO"%>
<%@ page import="device.DeviceRec"%>
<%@ page import="device.DeviceRecDAO"%>
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
				<h6 class="m-0 font-weight-bold text-primary">기저귀 교체 기록</h6>
			</div>
			<div class="card-body">
				<div class="table-responsive">
					<table class="table table-bordered display" id="room-record-table"
						width="100%" cellspacing="0">
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

								PatientInfoDAO patientInfoDAO4 = new PatientInfoDAO();
								DeviceRecDAO deviceRecDAO = new DeviceRecDAO();
								ArrayList<DeviceRec> recList = deviceRecDAO.getRoomRec(pageRoomNo);

								String deviceID, datatime, userName;
								int userID;

								for (DeviceRec rs : recList) {
									deviceID = rs.getDeviceID();
									datatime = rs.getDatatime();
									userID = rs.getUserID();
									userName = patientInfoDAO4.getUserName(userID);

							%>
							<tr>
								<td><%=userName%></td>
								<td><%=datatime%></td>
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