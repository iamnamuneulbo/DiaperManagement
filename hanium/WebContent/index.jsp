<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="device.RoomDAO"%>
<%@ page import="device.Room"%>
<%@ page import="device.PatientInfoDAO"%>
<%@ page import="device.DeviceValDAO"%>
<%@ page import="device.DeviceVal"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html lang="ko">
<head>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<meta http-equiv="refresh" content="180">
<title>스마트 기저귀 - Dashboard</title>

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
		<jsp:include page="navbar.jsp"></jsp:include>
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
					<div
						class="d-sm-flex align-items-center justify-content-between mb-4">
						<h1 class="h3 mb-0 text-gray-800">병실 목록</h1>
					</div>

					<!-- Content Row -->
					<section class="row">
						<%
							DeviceValDAO deviceValDAO2 = new DeviceValDAO();
							PatientInfoDAO patientInfoDAO2 = new PatientInfoDAO();
							RoomDAO roomDAO2 = new RoomDAO();
							ArrayList<Room> roomList2 = roomDAO2.getRoomList();

							String roomNo, active = "";
							int maxBed, cnt;

							int roomCnt = 0, state;
							String roomState;
							for (Room rs : roomList2) {
								roomNo = rs.getRoomNo();
								maxBed = rs.getMaxBed();

								state = deviceValDAO2.getRoomState(roomNo);

								if (state == 0) {
									roomState = "success";
								} else if (state == 1) {
									roomState = "warning";
								} else {
									roomState = "danger";
								}

								ArrayList<Integer> RUList = patientInfoDAO2.getRoomUserList(roomNo);
								cnt = RUList.size();
						%>
						<article id="<%=roomNo%>" class="col-5 mb-4" data-toggle="popover"
							data-placement="right" data-html="true" title="<%=roomNo%>호"
							data-content='<jsp:include page="room_card_preview.jsp"><jsp:param name="roomNo" value="<%=roomNo%>" /></jsp:include>'>
							<div class="card border-left-<%=roomState%> shadow h-100 py-2">
								<div class="card-body">
									<div class="row no-gutters align-items-center">
										<div class="col mr-2">
											<div
												class="text-xs font-weight-bold text-primary text-uppercase mb-1"></div>
											<div class="h5 mb-0 font-weight-bold text-gray-800">
												<a href="room_page.jsp?roomNo=<%=roomNo%>"><%=roomNo%>호(<%=cnt%>/<%=maxBed%>)</a>
											</div>
										</div>
										<div class="col-auto">
											<i class="fas fa-procedures fa-2x text-gray-300"></i>
										</div>
									</div>
								</div>
							</div>
						</article>
						<%
							if (roomCnt % 2 == 0) {
						%>
						<article class="col-2 mb-4"></article>
						<%
							}
								roomCnt++;
							}
						%>
					</section>

					<!-- Content Row -->

					<div class="row">

						<!-- Content Row -->
						<div class="row">

							<!-- Content Column -->
							<div class="col-lg-6 mb-4">

								<div class="col-lg-6 mb-4"></div>
							</div>

						</div>
						<!-- /.container-fluid -->

					</div>
					<!-- End of Main Content -->

					<!-- Footer -->
					<jsp:include page="footer.jsp"></jsp:include>
					<!-- End of Footer -->

				</div>
				<!-- End of Content Wrapper -->

			</div>
		</div>
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

	<script type="text/javascript">
		var pop_timer;

		$(document).ready(function() {
			$('[data-toggle="popover"]').popover();
		});
		$('[data-toggle="popover"]').on('click', function(e) {
			clearTimeout(pop_timer);
			$('[data-toggle="popover"]').not(this).popover('hide');
			pop_timer = setTimeout(function() {
				$('[data-toggle="popover"]').popover('hide');
			}, 2000);
		});
		$("html").on("mouseup", function(e) {
			var l = $(e.target);
			if (l[0].className.indexOf("popover") == -1) {
				$(".popover").each(function() {
					$(this).popover("hide");
				});
			}
		});
	</script>
</body>

<style>
.popover {
	width: 50%;
	max-width: 50%;
	position: relative;
	margin: auto;
}
</style>
</html>
