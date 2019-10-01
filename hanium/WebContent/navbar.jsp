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
	<!-- Sidebar -->
	<nav>
		<ul
			class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion toggled"
			id="accordionSidebar">

			<!-- Sidebar - Brand -->
			<a
				class="sidebar-brand d-flex align-items-center justify-content-center"
				href="index.jsp">
				<div class="sidebar-brand-icon rotate-n-15">
					<i class="fas fa-laugh-wink"></i>
				</div>
				<div class="sidebar-brand-text mx-3">스마트 기저귀</div>
			</a>

			<!-- Divider -->
			<hr class="sidebar-divider my-0">

			<!-- Nav Item - Dashboard -->
			<li class="nav-item"><a class="nav-link"
				href="/hanium/index.jsp"> <i class="fas fa-fw fa-tachometer-alt"></i>
					<span>Dashboard</span>
			</a></li>

			<!-- Divider -->
			<hr class="sidebar-divider">

			<!-- Heading -->
			<div class="sidebar-heading">ROOMS</div>

			<!-- Nav Item - Pages Collapse Menu -->
			<li class="nav-item"><a class="nav-link collapsed" href="#"
				data-toggle="collapse" data-target="#collapsePages"
				aria-expanded="true" aria-controls="collapsePages"> <i
					class="fas fa-fw fa-folder"></i> <span>병실 목록</span>
			</a>
				<div id="collapsePages" class="collapse"
					aria-labelledby="headingPages" data-parent="#accordionSidebar">
					<div class="bg-white py-2 collapse-inner rounded">
						<h6 class="collapse-header">2층:</h6>
						<%
							request.setCharacterEncoding("UTF-8");

							DeviceValDAO deviceValDAO = new DeviceValDAO();
							PatientInfoDAO patientInfoDAO = new PatientInfoDAO();
							RoomDAO roomDAO = new RoomDAO();
							ArrayList<Room> roomList = roomDAO.getRoomList();

							String roomNo;
							int maxBed, cnt;

							for (Room rs : roomList) {
								roomNo = rs.getRoomNo();
								maxBed = rs.getMaxBed();

								ArrayList<String> RDList = patientInfoDAO.getRoomDeviceList(roomNo);
								cnt = RDList.size();
						%>
						<a class="collapse-item"
							href="/hanium/room_page.jsp?roomNo=<%=roomNo%>"><%=roomNo%>호(<%=cnt%>/<%=maxBed%>)</a>
						<%
							}
						%>
					</div>
				</div></li>

			<!-- Divider -->
			<hr class="sidebar-divider d-none d-md-block">

			<!-- Heading -->
			<div class="sidebar-heading">SETTINGS</div>

			<!-- Nav Item - Pages Collapse Menu -->
			<li class="nav-item"><a class="nav-link collapsed" href="#"
				data-toggle="collapse" data-target="#collapseTwo"
				aria-expanded="true" aria-controls="collapseTwo"> <i
					class="fas fa-fw fa-cog"></i> <span>관리 페이지</span>
			</a>
				<div id="collapseTwo" class="collapse" aria-labelledby="headingTwo"
					data-parent="#accordionSidebar">
					<div class="bg-white py-2 collapse-inner rounded">
						<h6 class="collapse-header">SETTINGS:</h6>
						<a class="collapse-item" href="/hanium/patients_admin.jsp">환자
							관리</a> <a class="collapse-item" href="/hanium/rooms_admin.jsp">병실
							관리</a> <a class="collapse-item" href="/hanium/devices_admin.jsp">기기
							관리</a>
					</div>
				</div></li>

			<!-- Divider -->
			<hr class="sidebar-divider">

			<!-- Sidebar Toggler (Sidebar) -->
			<div class="text-center d-none d-md-inline">
				<button class="rounded-circle border-0" id="sidebarToggle"></button>
			</div>

		</ul>
	</nav>

	<!-- End of Sidebar -->

	<script src="vendor/jquery/jquery.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			var location = window.location
			var url = location.pathname;
			var para = location.search;
			var sel;

			if (url.match(/index/)) {
				$('li.nav-item a[href="' + url + '"]').parent().addClass('active');
			}
			else if ($('a.collapse-item[href="' + url + '"]').length > 0) {
				sel = $('a.collapse-item[href="' + url + '"]');
				sel.closest('li').addClass('active');
				sel.addClass('active');
				sel.closest('div.collapse').addClass('show');
			} else if ($('a.collapse-item[href="' + url + para + '"]').length > 0){
				sel = $('a.collapse-item[href="' + url + para + '"]');
				sel.closest('li').addClass('active');
				sel.addClass('active');
				sel.closest('div.collapse').addClass('show');
			}
		});
	</script>
</body>


</html>