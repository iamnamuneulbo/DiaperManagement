<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="device.PatientInfoDAO"%>
<%@ page import="device.PatientInfo"%>
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

<title>환자 관리 - 설정</title>

<!-- Custom fonts for this template -->
<link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet"
	type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i|Noto+Sans+KR&display=swap"
	rel="stylesheet">

<!-- Custom styles for this template -->
<link href="css/sb-admin-2.min.css" rel="stylesheet">
<link href="vendor/datatables/dataTables.bootstrap4.min.css"
	rel="stylesheet">

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
					<h1 class="h3 mb-2 text-gray-800">환자 관리</h1>
					<p class="mb-4"></p>


					<!-- DataTales Example -->
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold text-primary">환자 리스트</h6>
						</div>
						<div class="card-body">
							<div class="table-responsive">
								<table class="table table-bordered stripe hover" id="dataTable"
									width="100%" cellspacing="0">
									<thead>
										<tr>
											<th>환자번호</th>
											<th>이름</th>
											<th>병실</th>
											<th>침대번호</th>
											<th>기기번호</th>
											<th>수정</th>
											<th>삭제</th>
										</tr>
									</thead>
									<tfoot>
										<tr>
											<th>환자번호</th>
											<th>이름</th>
											<th>병실</th>
											<th>침대번호</th>
											<th>기기번호</th>
											<th>수정</th>
											<th>삭제</th>
										</tr>
									</tfoot>
									<tbody>
										<%
											request.setCharacterEncoding("UTF-8");

											PatientInfoDAO patientInfoDAO = new PatientInfoDAO();
											ArrayList<PatientInfo> patientList = patientInfoDAO.getList();

											for (PatientInfo rs : patientList) {
										%>
										<tr>
											<td><%=rs.getUserID()%></td>
											<td><%=rs.getUserName()%></td>
											<td><%=rs.getRoomNo()%></td>
											<td><%=rs.getBedNo()%></td>
											<td><%=rs.getDeviceID()%></td>
											<td><a href="#" class="btn btn-success btn-circle"><i
													class="fas fa-edit"></i> </a></td>
											<td><a href="#" class="btn btn-danger btn-circle"><i
													class="fas fa-trash"></i> </a></td>
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
				<!-- /.container-fluid -->

			</div>
			<!-- End of Main Content -->

			<!-- Footer -->
			<jsp:include page="footer.jsp"></jsp:include>
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

	<!-- Page level plugins -->
	<script src="vendor/datatables/jquery.dataTables.min.js"></script>
	<script src="vendor/datatables/dataTables.bootstrap4.min.js"></script>

	<!-- Page level custom scripts -->
	<script src="js/demo/datatables-demo.js"></script>

	<script>
		$(document).ready(function() {
			$('table').DataTable();
		});
	</script>
</body>

</html>
