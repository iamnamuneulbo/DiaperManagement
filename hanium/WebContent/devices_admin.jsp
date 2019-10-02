<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="device.DeviceInfoDAO"%>
<%@ page import="device.DeviceInfo"%>
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

<title>기기 관리 - 설정</title>

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

<style>
i.modal-form-icon {
	line-height: unset;
}
</style>
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

				<section class="container-fluid">
					<!-- Page Heading -->
					<h1 class="h3 mb-2 text-gray-800">기기 관리</h1>
					<p class="mb-4"></p>

					<!-- DataTales Example -->
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<div class="row">
								<div class="col">
									<h6 class="m-0 font-weight-bold text-primary">기기 리스트</h6>
								</div>
								<div class="col text-right">
									<a href="#" class="btn btn-primary btn-circle" data-toggle="modal" data-target="#modalInsertForm"> <i
										class="fas fa-plus"></i></a>
								</div>
							</div>
						</div>
						<div class="card-body">
							<div class="table-responsive">
								<table class="table table-bordered table-striped table-hover"
									id="dataTable" width="100%" cellspacing="0">
									<thead>
										<tr>
											<th>기기번호</th>
											<th>점검일</th>
											<th>수정</th>
											<th>삭제</th>
										</tr>
									</thead>
									<tfoot>
										<tr>
											<th>기기번호</th>
											<th>점검일</th>
											<th>수정</th>
											<th>삭제</th>
										</tr>
									</tfoot>
									<tbody>
										<%
											request.setCharacterEncoding("UTF-8");

											DeviceInfoDAO deviceInfoDAO = new DeviceInfoDAO();
											ArrayList<DeviceInfo> deviceList = deviceInfoDAO.getList();

											String deviceID, checkDate;

											for (DeviceInfo rs : deviceList) {
										%>
										<tr>
											<td><%=rs.getDeviceID()%></td>
											<td><%=rs.getCheckDate()%></td>
											<td><a href="#" class="btn btn-success btn-circle"
												data-toggle="modal" data-target="#modalUpdateForm"><i
													class="fas fa-edit"></i> </a></td>
											<td><a href="#" class="btn btn-danger btn-circle"
												data-toggle="modal" data-target="#modalDelete"><i
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

				</section>
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

	<!-- Insert Modal-->
	<div class="modal fade" id="modalInsertForm" tabindex="-1"
		role="dialog" aria-labelledby="insertModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-sm modal-dialog-centered"
			role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="insertModalLabel">기기 정보 추가</h5>
					<button class="close" type="button" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
				</div>
				<div class="modal-body">
					<form method="post" action="insert.jsp" class="user"
						id="insertForm">

						<input type="hidden" id="insertTarget" name="target"
							value="device">

						<div class="row mb-3">
							<div class="col-3 text-center">
								<i class="fas fa-microchip fa-2x modal-form-icon"></i>
							</div>
							<div class="col-9">
								<input type="text" class="form-control form-control-user"
									id="insertDeviceID" name="deviceID" placeholder="기기번호">
							</div>
						</div>
						<div class="row mb-3">
							<div class="col-3 text-center">
								<i class="fas fa-calendar-day fa-2x modal-form-icon"></i>
							</div>
							<div class="col-9">
								<input type="text" class="form-control form-control-user"
									id="insertCheckDate" name="checkDate" placeholder="점검일(추가 일자 자동 입력)" readonly>
							</div>
						</div>

					</form>
				</div>
				<div class="modal-footer">
					<button class="btn btn-secondary" type="button"
						data-dismiss="modal">취소</button>
					<button class="btn btn-success" id="insertBtn" type="submit"
						form="insertForm">추가</button>
				</div>
			</div>
		</div>
	</div>
	<!-- End of Insert Modal-->
	
	<!-- Update Modal-->
	<div class="modal fade" id="modalUpdateForm" tabindex="-1"
		role="dialog" aria-labelledby="updateModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-sm modal-dialog-centered"
			role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="updateModalLabel">기기 정보 수정</h5>
					<button class="close" type="button" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
				</div>
				<div class="modal-body">
					<form method="post" action="update.jsp" class="user"
						id="updateForm">

						<input type="hidden" id="updateTarget" name="target"
							value="device">

						<div class="row mb-3">
							<div class="col-3 text-center">
								<i class="fas fa-microchip fa-2x modal-form-icon"></i>
							</div>
							<div class="col-9">
								<input type="text" class="form-control form-control-user"
									id="updateDeviceID" name="deviceID" placeholder="기기번호" readonly>
							</div>
						</div>
						<div class="row mb-3">
							<div class="col-3 text-center">
								<i class="fas fa-calendar-day fa-2x modal-form-icon"></i>
							</div>
							<div class="col-9">
								<input type="text" class="form-control form-control-user"
									id="updateCheckDate" name="checkDate" placeholder="점검일">
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button class="btn btn-secondary" type="button"
						data-dismiss="modal">취소</button>
					<button class="btn btn-success" id="updateBtn" type="submit"
						form="updateForm">수정</button>
				</div>
			</div>
		</div>
	</div>
	<!-- End of Update Modal-->

	<!-- Delete Modal-->
	<div class="modal fade" id="modalDelete" tabindex="-1" role="dialog"
		aria-labelledby="deleteModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-sm modal-dialog-centered"
			role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="deleteModalLabel">기기 정보 삭제</h5>
					<button class="close" type="button" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
				</div>
				<div class="modal-body">
					<form method="post" action="delete.jsp" class="user"
						id="deleteForm">

						<input type="hidden" id="deleteTarget" name="target"
							value="device">

						<div class="row mb-3">
							<div class="col-3 text-center">
								<i class="fas fa-microchip fa-2x modal-form-icon"></i>
							</div>
							<div class="col-9">
								<input type="text" class="form-control form-control-user"
									id="deleteDeviceID" name="deviceID" placeholder="기기번호" readonly>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button class="btn btn-secondary" type="button"
						data-dismiss="modal">취소</button>
					<button class="btn btn-danger" id="deleteBtn" type="submit"
						form="deleteForm">삭제</button>
				</div>
			</div>
		</div>
	</div>
	<!-- End of Delete Modal-->

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

		$('[data-target="#modalUpdateForm"]').on(
				"click",
				function() {
					var deviceID = $(this).closest('tr')
							.find('td:nth-child(1)').text();
					var checkDate = $(this).closest('tr').find(
							'td:nth-child(2)').text();

					$(".modal-body #updateDeviceID").val(deviceID);
					$(".modal-body #updateCheckDate").val(checkDate);
				});

		$('[data-target="#modalDelete"]').on(
				"click",
				function() {
					var deviceID = $(this).closest('tr')
							.find('td:nth-child(1)').text();

					$(".modal-body #deleteDeviceID").val(deviceID);
				});
	</script>
</body>

</html>
