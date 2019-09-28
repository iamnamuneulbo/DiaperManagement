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

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<meta http-equiv="refresh" content="60">

<title>스마트 기저귀 - 병실</title>

<!-- Custom fonts for this template-->
<link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet"
	type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i|Noto+Sans+KR&display=swap"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link href="css/sb-admin-2.min.css" rel="stylesheet">
<link href="vendor/datatables/dataTables.bootstrap4.min.css"
	rel="stylesheet">

</head>

<body id="page-top">
	<%
		String pageRoomNo = request.getParameter("roomNo");
		if (pageRoomNo == null) {
			response.sendRedirect("404.jsp");
		} else {
	%>
	<!-- Page Wrapper -->
	<div id="wrapper">
		<nav>
			<!-- Sidebar -->
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
				<li class="nav-item"><a class="nav-link" href="index.jsp">
						<i class="fas fa-fw fa-tachometer-alt"></i> <span>Dashboard</span>
				</a></li>

				<!-- Divider -->
				<hr class="sidebar-divider">

				<!-- Heading -->
				<div class="sidebar-heading">Addons</div>

				<!-- Nav Item - Pages Collapse Menu -->
				<li class="nav-item active"><a class="nav-link" href="#"
					data-toggle="collapse" data-target="#collapsePages"
					aria-expanded="true" aria-controls="collapsePages"> <i
						class="fas fa-fw fa-folder"></i> <span>병실 목록</span>
				</a>
					<div id="collapsePages" class="collapse show"
						aria-labelledby="headingPages" data-parent="#accordionSidebar">
						<div class="bg-white py-2 collapse-inner rounded">
							<h6 class="collapse-header">2층:</h6>
							<%
								request.setCharacterEncoding("UTF-8");

									DeviceValDAO deviceValDAO = new DeviceValDAO();
									DeviceInfoDAO deviceInfoDAO = new DeviceInfoDAO();
									RoomDAO roomDAO = new RoomDAO();
									ArrayList<Room> roomList = roomDAO.getRoomList();

									String roomNo, active;
									int maxBed, cnt;

									for (Room rs : roomList) {
										roomNo = rs.getRoomNo();
										maxBed = rs.getMaxBed();

										ArrayList<String> RDList = deviceInfoDAO.getRoomDeviceList(roomNo);
										cnt = RDList.size();
										if (pageRoomNo.equals(roomNo)) {
											active = "active";
										} else {
											active = "";
										}
							%>
							<a class="collapse-item <%=active%>"
								href="room_page.jsp?roomNo=<%=roomNo%>"><%=roomNo%>호(<%=cnt%>/<%=maxBed%>)</a>
							<%
								}
									deviceValDAO = null;
									deviceInfoDAO = null;
									roomDAO = null;
									roomList = null;
							%>
						</div>
					</div></li>

				<!-- Divider -->
				<hr class="sidebar-divider d-none d-md-block">

				<!-- Heading -->
				<div class="sidebar-heading">Interface</div>

				<!-- Nav Item - Pages Collapse Menu -->
				<li class="nav-item"><a class="nav-link collapsed" href="#"
					data-toggle="collapse" data-target="#collapseTwo"
					aria-expanded="true" aria-controls="collapseTwo"> <i
						class="fas fa-fw fa-cog"></i> <span>Components</span>
				</a>
					<div id="collapseTwo" class="collapse" aria-labelledby="headingTwo"
						data-parent="#accordionSidebar">
						<div class="bg-white py-2 collapse-inner rounded">
							<h6 class="collapse-header">Custom Components:</h6>
							<a class="collapse-item" href="buttons.html">Buttons</a> <a
								class="collapse-item" href="cards.html">Cards</a>
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

		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">

			<!-- Main Content -->
			<div id="content">

				<!-- Topbar -->
				<nav
					class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

					<!-- Sidebar Toggle (Topbar) -->
					<button id="sidebarToggleTop"
						class="btn btn-link d-md-none rounded-circle mr-3">
						<i class="fa fa-bars"></i>
					</button>

					<!-- Topbar Navbar -->
					<ul class="navbar-nav ml-auto">

						<div class="topbar-divider d-none d-sm-block"></div>

					</ul>

				</nav>
				<!-- End of Topbar -->

				<!-- Begin Page Content -->

				<div class="container-fluid">

					<!-- Page Heading -->
					<h1 class="h3 mb-4 text-gray-800"><%=pageRoomNo%>호
					</h1>

				</div>
				<!-- /.container-fluid -->

				<section class="container-fluid">
					<jsp:include page="room_card.jsp">
						<jsp:param name="roomNo" value="<%=pageRoomNo%>" />
					</jsp:include>

					<article class="row">
						<jsp:include page="room_record_table.jsp">
							<jsp:param name="roomNo" value="<%=pageRoomNo%>" />
						</jsp:include>

						<jsp:include page="room_statistic_table.jsp">
							<jsp:param name="roomNo" value="<%=pageRoomNo%>" />
						</jsp:include>
					</article>
				</section>

				<!-- End of Main Content -->

				<!-- Footer -->
				<jsp:include page="footer.jsp"></jsp:include>
				<!-- End of Footer -->

			</div>
		</div>
		<!-- End of Content Wrapper -->

	</div>
	<!-- End of Page Wrapper -->

	<!-- Scroll to Top Button-->
	<a class="scroll-to-top rounded" href="#page-top"> <i
		class="fas fa-angle-up"></i>
	</a>

	<!-- Bootstrap core JavaScript-->
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<!-- Core plugin JavaScript-->
	<script src="vendor/jquery-easing/jquery.easing.min.js"></script>

	<!-- Custom scripts for all pages-->
	<script src="js/sb-admin-2.min.js"></script>

	<!-- Page level plugins -->
	<script src="vendor/datatables/jquery.dataTables.min.js"></script>
	<script src="vendor/datatables/dataTables.bootstrap4.min.js"></script>

	<!-- Page level custom scripts -->
	<script src="js/demo/datatables-demo.js"></script>
	
	<script>
		$(document).ready(function() {
		    $('table.display').DataTable();
		} );
	</script>


	<%
		}
	%>
</body>

</html>
