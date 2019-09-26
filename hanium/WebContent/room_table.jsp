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
				}
			%>
			
          <!-- DataTales Example -->
          <div class="card shadow mb-4">
            <div class="card-header py-3">
              <h6 class="m-0 font-weight-bold text-primary">DataTables Example</h6>
            </div>
            <div class="card-body">
              <div class="table-responsive">
                <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                  <thead>
                    <tr>
                      <th>Name</th>
                      <th>Position</th>
                      <th>Office</th>
                      <th>Age</th>
                      <th>Start date</th>
                      <th>Salary</th>
                    </tr>
                  </thead>
                  <tfoot>
                    <tr>
                      <th>Name</th>
                      <th>Position</th>
                      <th>Office</th>
                      <th>Age</th>
                      <th>Start date</th>
                      <th>Salary</th>
                    </tr>
                  </tfoot>
                  <tbody>
                    <tr>
                      <td>Tiger Nixon</td>
                      <td>System Architect</td>
                      <td>Edinburgh</td>
                      <td>61</td>
                      <td>2011/04/25</td>
                      <td>$320,800</td>
                    </tr>
                    <tr>
                      <td>Garrett Winters</td>
                      <td>Accountant</td>
                      <td>Tokyo</td>
                      <td>63</td>
                      <td>2011/07/25</td>
                      <td>$170,750</td>
                    </tr>
                    <tr>
                      <td>Ashton Cox</td>
                      <td>Junior Technical Author</td>
                      <td>San Francisco</td>
                      <td>66</td>
                      <td>2009/01/12</td>
                      <td>$86,000</td>
                    </tr>
                  </tbody>
                </table>
              </div>
            </div>
          </div>

		</article>

</body>
</html>