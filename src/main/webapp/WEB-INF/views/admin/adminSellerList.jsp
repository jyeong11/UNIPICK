<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>UNIPICK</title>
<!-- default -->
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.1.js"></script>

<!-- font-awesome -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/public/fontawesome/all.min.css" />
<script src="${pageContext.request.contextPath }/resources/public/fontawesome/all.min.js"></script>

<!-- font -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&family=Nunito:wght@200..1000&display=swap" rel="stylesheet">

<!-- CSS for Page -->
<link href="${pageContext.request.contextPath }/resources/public/css/sb-admin-2.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/public/css/adm.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/public/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/public/vendor/datatables/datatables.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/css/admin/adminSellerList.css" rel="stylesheet">
<script src="${pageContext.request.contextPath }/resources/js/admin/adminSellerList.js"></script>
<link rel="icon" href="${pageContext.request.contextPath }/resources/images/favicon.png">
</head>
<body id="page-top">
	<div id="wrapper">
		<jsp:include page="../inc/adminSidebar.jsp"></jsp:include>
		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">
			<!-- Main Content -->
			<div id="content">
				<!-- Topbar -->
				<nav
					class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">
					<!-- Sidebar Toggle (Mobile Topbar) -->
					<button id="sidebarToggleTop"
						class="btn btn-link d-md-none rounded-circle mr-3">
						<i class="fa fa-bars"></i>
					</button>
					<!-- Title -->
					<h4 class="m-0 text-gray-900">UNIPICK 관리자 대시보드</h4>
					<!-- Topbar Navbar -->
					<ul class="navbar-nav ml-auto">
						<li class="nav-item dropdown no-arrow"><a
							class="nav-link dropdown-toggle" href="#" id="userDropdown"
							role="button" data-toggle="dropdown" aria-haspopup="true"
							aria-expanded="false"> <span
								class="mr-2 d-none d-lg-inline text-gray-600 small">관리자</span> <img
								class="img-profile rounded-circle"
								src="../../resources/adm/img/admin_profile.png"></a> <!-- Dropdown - User Information -->
							<div
								class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
								aria-labelledby="userDropdown">
								<a class="dropdown-item" href="/." target="_blank"> <i
									class="fas fa-list fa-sm fa-fw mr-2 text-gray-400"></i>사용자 화면
								</a> <a class="dropdown-item" href="AdmLogList"> <i
									class="fas fa-list fa-sm fa-fw mr-2 text-gray-400"></i>로그 기록
								</a>
								<div class="dropdown-divider"></div>
								<a class="dropdown-item" href="#" data-toggle="modal"
									data-target="#logoutModal"> <i
									class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>로그아웃
								</a>
							</div></li>
					</ul>
				</nav>
				<!-- Logout Modal-->
				<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog"
					aria-labelledby="exampleModalLabel" aria-hidden="true">
					<div class="modal-dialog" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="exampleModalLabel">로그아웃 하시겠습니까?</h5>
								<button class="close" type="button" data-dismiss="modal"
									aria-label="Close">
									<span aria-hidden="true">×</span>
								</button>
							</div>
							<div class="modal-body">로그아웃 후에는 관리자 사이트 접근이 불가능합니다.</div>
							<div class="modal-footer">
								<button class="btn btn-secondary" type="button"
									data-dismiss="modal">취소</button>
								<a class="btn btn-primary" href="MemberLogout">로그아웃</a>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- End of Topbar -->
			<main>
				<!-- 계정설정 -->
				<section class="wrapper">
					<div class="container-fluid">
						<div class="row">
							<div class="col-lg-12">
							<div class="card shadow mb-4">
								<div class="card-header py-3">
									<h5 class="m-0 font-weight-bold text-primary">판매자 목록</h5>
								</div>
								<div class="container">
									<div class="row align-items-start justify-content-end">
										<div class="col-2">
											<select class="form-select" id="noticeSearchKind">
												<option value="sel_id">ID</option>
												<option value="sel_nm">스토어 명</option>
												<option value="sel_mn">담당자 명</option>
											</select>
										</div>
										<div class="col-3">
											<input type="text" id="noticeSearchWord" class="form-control" placeholder="검색어 입력">
										</div>
										<div class="col-1">
											<button id="noticeSearch" class="btn btn_main_color" type="button">조회</button>
										</div>
									</div>
								</div>
									<!-- 상품 목록 테이블 -->
									<div class="table-responsive">
										<table class="table table-bordered" id="productList">
											<thead>
												<tr>
													<th>순번</th>
													<th>ID</th>
													<th>스토어 명</th>
													<th>스토어 담당자 명</th>
													<th>스토어 전화번호</th>
												</tr>
											</thead>
											<tbody id="sellerListTable"></tbody>
										</table>
									</div>
									<section id="pageList"></section>
								</div>
							</div>
						</div>
					</div>
				</section>
			</main>
			<!-- Footer -->
			<footer class="sticky-footer bg-white">
				<div class="container my-auto">
					<div class="copyright text-center my-auto">
						<span>Copyright &copy; UNIPICK SELLER 2025</span>
					</div>
				</div>
			</footer>
			<!-- End of Footer -->
		</div>
		<!-- End of Page Wrapper -->
	</div>
	<!-- Bootstrap core JavaScript-->
	<script src="${pageContext.request.contextPath }/resources/public/vendor/jquery/jquery.min.js"></script>
	<script src="${pageContext.request.contextPath }/resources/public/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<!-- Core plugin JavaScript-->
	<script src="${pageContext.request.contextPath }/resources/public/vendor/jquery-easing/jquery.easing.min.js"></script>

	<!-- Custom scripts for all pages-->
	<script src="${pageContext.request.contextPath }/resources/public/js/sb-admin-2.min.js"></script>

	<!-- Page level plugins -->
	<script src="${pageContext.request.contextPath }/resources/public/vendor/chart.js/Chart.min.js"></script>
	<script src="${pageContext.request.contextPath }/resources/public/vendor/datepicker/moment.min.js"></script>
	<script src="${pageContext.request.contextPath }/resources/public/vendor/datatables/jquery.dataTables.min.js"></script>
	<script src="${pageContext.request.contextPath }/resources/public/vendor/datatables/dataTables.bootstrap4.min.js"></script>
	
	<!-- Page level custom scripts -->
	<script src="${pageContext.request.contextPath }/resources/public/js/index.js"></script>
	

</body>
</html>