<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="setting.Setting"%>
<%@ page import="setting.SettingDAO"%>
<!-- Topbar -->
<nav
	class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

	<%
		SettingDAO settingDAO = new SettingDAO();
		Setting setting = settingDAO.getValue();
	%>

	
	<ul class="navbar-nav ml-auto">
		<li class="nav-item nav-link">기준 온도: <span id="stdTemp"><%=setting.getTemperature()%></span></li>
		<li class="nav-item nav-link">기준 습도: <span id="stdHumi"><%=setting.getHumidity()%></span></li>
		<li class="nav-item nav-link">기준 가스: <span id="stdGas"><%=setting.getGas()%></span></li>
	</ul>
	<a href="#" class="btn btn-primary btn-circle nav-link" data-toggle="modal"
		data-target="#modalUpdateForm"><i class="fas fa-cog"></i> </a>
	<!-- Update Modal-->
	<div class="modal fade" id="modalUpdateForm" tabindex="-1"
		role="dialog" aria-labelledby="updateModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-sm modal-dialog-centered"
			role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="updateModalLabel">상태 기준 설정</h5>
					<button class="close" type="button" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
				</div>
				<div class="modal-body">
					<form method="post" action="update.jsp" class="user"
						id="updateForm">

						<input type="hidden" id="updateTarget" name="target" value="setting">

						<div class="row mb-3">
							<div class="col-3 text-center">
								<i class="fas fa-thermometer-half fa-2x modal-form-icon"></i>
							</div>
							<div class="col-9">
								<input type="text" class="form-control form-control-user"
									id="updateTemp" name="temp" placeholder="기준 온도">
							</div>
						</div>
						<div class="row mb-3">
							<div class="col-3 text-center">
								<i class="fas fa-tint fa-2x modal-form-icon"></i>
							</div>
							<div class="col-9">
								<input type="text" class="form-control form-control-user"
									id="updateHumi" name="humi" placeholder="기준 습도">
							</div>
						</div>
						<div class="row mb-3">
							<div class="col-3 text-center">
								<i class="fas fa-wind fa-2x modal-form-icon"></i>
							</div>
							<div class="col-9">
								<input type="text" class="form-control form-control-user"
									id="updateGas" name="gas" placeholder="기준 가스">
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button class="btn btn-secondary" type="button"
						data-dismiss="modal">취소</button>
					<button class="btn btn-success" id="updateBtn" type="submit"
						form="updateForm">설정</button>
				</div>
			</div>
		</div>
	</div>
	<!-- End of Update Modal-->

</nav>
<!-- End of Topbar -->

	<!-- Bootstrap core JavaScript-->
	<script src="vendor/jquery/jquery.min.js"></script>
	<script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<!-- Core plugin JavaScript-->
	<script src="vendor/jquery-easing/jquery.easing.min.js"></script>

	<!-- Custom scripts for all pages-->
	<script src="js/sb-admin-2.min.js"></script>

	<script>
		$('[data-target="#modalUpdateForm"]').on(
				"click",
				function() {
					$(".modal-body #updateTemp").val(stdTemp.innerText);
					$(".modal-body #updateHumi").val(stdHumi.innerText);
					$(".modal-body #updateGas").val(stdGas.innerText);
				});

	</script>
	