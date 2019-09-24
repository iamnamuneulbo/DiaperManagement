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

<title>스마트 기저귀 - 병실</title>

<!-- Custom fonts for this template-->
<link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet"
	type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i|Noto+Sans+KR&display=swap"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link href="css/sb-admin-2.min.css" rel="stylesheet">

</head>

<body id="page-top">

	<!-- Page Wrapper -->
	<div id="wrapper">

		<!-- Sidebar -->
		<ul
			class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion"
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
			<li class="nav-item"><a class="nav-link" href="index.jsp"> <i
					class="fas fa-fw fa-tachometer-alt"></i> <span>Dashboard</span></a></li>

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
						<a class="collapse-item active" href="subPage.jsp">201호</a>

						<%
					request.setCharacterEncoding("UTF-8");
					
					RoomDAO roomDAO = new RoomDAO();
					ArrayList<Room> roomList = roomDAO.getList();
					
					String roomNo;
					int maxBed;
					
					for (Room rs : roomList) {
						roomNo = rs.getRoomNo();
						maxBed = rs.getMaxBed();
						
				%>
						<a class="collapse-item active"
							href="subPage.jsp?roomNo=<%=roomNo%>"><%=roomNo%>호(0/<%=maxBed%>)</a>
						<%}%>
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

						<!-- Nav Item - Search Dropdown (Visible Only XS) -->
						<li class="nav-item dropdown no-arrow d-sm-none"><a
							class="nav-link dropdown-toggle" href="#" id="searchDropdown"
							role="button" data-toggle="dropdown" aria-haspopup="true"
							aria-expanded="false"> <i class="fas fa-search fa-fw"></i>
						</a> <!-- Dropdown - Messages -->
							<div
								class="dropdown-menu dropdown-menu-right p-3 shadow animated--grow-in"
								aria-labelledby="searchDropdown">
								<form class="form-inline mr-auto w-100 navbar-search">
									<div class="input-group">
										<input type="text"
											class="form-control bg-light border-0 small"
											placeholder="Search for..." aria-label="Search"
											aria-describedby="basic-addon2">
										<div class="input-group-append">
											<button class="btn btn-primary" type="button">
												<i class="fas fa-search fa-sm"></i>
											</button>
										</div>
									</div>
								</form>
							</div></li>
						<div class="topbar-divider d-none d-sm-block"></div>

					</ul>

				</nav>
				<!-- End of Topbar -->

				<!-- Begin Page Content -->
				<div class="container-fluid">

					<!-- Page Heading -->
					<h1 class="h3 mb-4 text-gray-800"><%=request.getParameter("roomNo")%></h1>

				</div>
				<!-- /.container-fluid -->

				<div class="container">
					<section class="row">
						<%
					request.setCharacterEncoding("UTF-8");

					DeviceValDAO deviceValDAO = new DeviceValDAO();
					ArrayList<DeviceVal> list = deviceValDAO.getList();

					DeviceInfoDAO deviceInfoDAO = new DeviceInfoDAO();

					String deviceID, dataTime, tag, state, img, userName;
					int temperature, humidity, gas, sum, cnt = 0;

					for (DeviceVal rs : list) {
						deviceID = rs.getDeviceID();
						dataTime = rs.getDatatime();
						temperature = rs.getTemperature();
						humidity = rs.getHumidity();
						gas = rs.getGas();
						sum = temperature + humidity + gas;

						userName = deviceInfoDAO.getUserName(deviceID);

						if (sum < 80) {
							tag = "success";
							img = "far fa-smile";
							state = "좋음";
						} else if (sum < 100) {
							tag = "warning";
							img = "far fa-meh";
							state = "보통";
						} else {
							tag = "danger";
							img = "far fa-frown";
							state = "나쁨";
						}
				%>
						<article class="col-5 mb-4">
							<div class="card bg-<%=tag%> shadow mb-2">
								<div class="card-header bg-<%=tag%> py-2">
									<h6 class="m-0 font-weight-bold text-gray-100">
										[<%=deviceID%>]<%=userName%></h6>
								</div>
								<div class="card-body text-gray-100 py-2">
									<i class="<%=img%> fa-3x float-right"></i>
									<h4 class="card-title d-inline align-middle"><%=state%></h4>
									<p class="card-text">
										<br> <br> 온도<span class="float-right"><%=temperature%></span><br>
										습도<span class="float-right"><%=humidity%></span><br> 가스<span
											class="float-right"><%=gas%></span><br> <span
											class="float-right"><%=dataTime%></span>
									</p>
								</div>
							</div>
						</article>
						<%
						if (cnt % 2 == 0) {%>
						<article class="col-2 mb-2"></article>
						<%							
						}
						cnt++;
					}
				%>
						<article class="col-5 mb-2"></article>
						<article class="col-2 mb-2">
							<div class="card bg-secondary text-white shadow">
								<div class="card-body text-center">입구</div>
							</div>
						</article>
						<article class="col-2 mb-2"></article>
					</section>
				</div>

			</div>
			<!-- End of Main Content -->

			<!-- Footer -->
			<footer class="sticky-footer bg-white">
				<div class="container my-auto">
					<div class="copyright text-center my-auto">
						<span>Copyright &copy; 한이음 스마트 기저귀 2019</span>
					</div>
				</div>
			</footer>
			<!-- End of Footer -->

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

</body>

</html>
