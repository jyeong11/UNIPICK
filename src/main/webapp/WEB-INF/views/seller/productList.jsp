<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>UNIPICK</title>
<!-- default -->
<script
	src="${pageContext.request.contextPath }/resources/js/jquery-3.7.1.js"></script>

<!-- font-awesome -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/public/fontawesome/all.min.css" />
<script
	src="${pageContext.request.contextPath }/resources/public/fontawesome/all.min.js"></script>

<!-- font -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&family=Nunito:wght@200..1000&display=swap"
	rel="stylesheet">

<!-- CSS for Page -->
<link
	href="${pageContext.request.contextPath }/resources/public/css/sb-admin-2.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath }/resources/public/css/adm.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath }/resources/public/vendor/datatables/dataTables.bootstrap4.min.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath }/resources/public/vendor/datatables/datatables.min.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath }/resources/css/seller/productRegister.css"
	rel="stylesheet">

<script
	src="${pageContext.request.contextPath }/resources/js/seller/prdList.js"></script>

<link rel="icon"
	href="${pageContext.request.contextPath }/resources/images/favicon.png">
</head>
<body id="page-top">
	<div id="wrapper">
		<div><jsp:include page="../inc/sellerSidebar.jsp"></jsp:include></div>
		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">
			<!-- Main Content -->
			<div id="content">
				<div>
					<jsp:include page="../inc/sellerTopbar.jsp"></jsp:include>
				</div>
				<!-- Begin Page Content -->
				<div class="container-fluid">
					<div class="row">
						<div class="col-lg-12">
							<div class="card shadow mb-4">
								<div class="card-header py-3">
									<h5 class="m-0 font-weight-bold text-primary">상품 목록</h5>
								</div>
								<div class="container">
									<div class="row align-items-start justify-content-end">
										<div class="col-2">
											<select class="form-select" id="noticeSearchKind">
												<option value="name">상품명</option>
												<option value="category">카테고리</option>
												<option value="color">컬러</option>
											</select>
										</div>
										<div class="col-3">
											<input type="text" id="noticeSearchWord" class="form-control"
												placeholder="검색어 입력">
										</div>
										<div class="col-1">
											<button id="noticeSearch" class="btn btn_main_color"
												type="button">조회</button>
										</div>
									</div>
								</div>
								<!-- 상품 목록 테이블 -->
								<div class="table-responsive">
									<table class="table table-bordered" id="productList">
										<thead>
											<tr>
												<th>상품코드</th>
												<th>상품명</th>
												<th>판매가</th>
												<th>카테고리</th>
												<th>컬러이름</th>
												<th>사이즈이름</th>
												<th>재고수량</th>
												<th>등록일</th>
												<th>상태</th>
											</tr>
										</thead>
										<tbody id="noticeListTable">
											<!-- 상품 목록이 여기에 동적으로 추가됩니다 -->
										</tbody>
									</table>
								</div>
								<section id="pageList"></section>
							</div>
						</div>
					</div>
				</div>
				<!-- Footer -->
				<jsp:include page="../inc/sellerfooter.jsp"></jsp:include>
				<!-- End of Footer -->
			</div>
			<!-- End of Page Wrapper -->
		</div>
		<!-- Bootstrap core JavaScript-->
		<script
			src="${pageContext.request.contextPath }/resources/public/vendor/jquery/jquery.min.js"></script>
		<script
			src="${pageContext.request.contextPath }/resources/public/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

		<!-- Core plugin JavaScript-->
		<script
			src="${pageContext.request.contextPath }/resources/public/vendor/jquery-easing/jquery.easing.min.js"></script>

		<!-- Custom scripts for all pages-->
		<script
			src="${pageContext.request.contextPath }/resources/public/js/sb-admin-2.min.js"></script>

		<!-- Page level plugins -->
		<script
			src="${pageContext.request.contextPath }/resources/public/vendor/chart.js/Chart.min.js"></script>
		<script
			src="${pageContext.request.contextPath }/resources/public/vendor/datepicker/moment.min.js"></script>
		<script
			src="${pageContext.request.contextPath }/resources/public/vendor/datatables/jquery.dataTables.min.js"></script>
		<script
			src="${pageContext.request.contextPath }/resources/public/vendor/datatables/dataTables.bootstrap4.min.js"></script>

		<!-- Page level custom scripts -->
		<script
			src="${pageContext.request.contextPath }/resources/public/js/index.js"></script>
</body>
</html>