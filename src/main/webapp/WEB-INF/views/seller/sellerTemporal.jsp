<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>UNIPICK</title>
<!-- 기본 스크립트 및 스타일 -->
<script
	src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/public/fontawesome/all.min.css" />
<script
	src="${pageContext.request.contextPath}/resources/public/fontawesome/all.min.js"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&family=Nunito:wght@200..1000&display=swap"
	rel="stylesheet">
<!-- 페이지 전용 CSS -->
<link
	href="${pageContext.request.contextPath}/resources/public/css/sb-admin-2.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/resources/public/css/adm.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/resources/public/vendor/datatables/dataTables.bootstrap4.min.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/resources/public/vendor/datatables/datatables.min.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/resources/css/seller/productRegister.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/resources/css/seller/sellerTemporal.css"
	rel="stylesheet">
<!-- TOAST UI Editor -->
<link rel="stylesheet"
	href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />
<script
	src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
<link rel="stylesheet"
	href="https://uicdn.toast.com/tui-color-picker/latest/tui-color-picker.min.css" />
<link rel="stylesheet"
	href="https://uicdn.toast.com/editor-plugin-color-syntax/latest/toastui-editor-plugin-color-syntax.min.css" />
<script
	src="https://uicdn.toast.com/tui-color-picker/latest/tui-color-picker.min.js"></script>
<script
	src="https://uicdn.toast.com/editor-plugin-color-syntax/latest/toastui-editor-plugin-color-syntax.min.js"></script>

<script>
	var contextPath = '${pageContext.request.contextPath}';
</script>
<!-- 페이지 전용 JS (외부 파일로 분리) -->
<script
	src="${pageContext.request.contextPath}/resources/js/seller/sellerTemporal.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<link rel="icon"
	href="${pageContext.request.contextPath }/resources/images/favicon.png">
</head>
<body id="page-top">
	<div id="wrapper">
		<jsp:include page="../inc/sellerSidebar.jsp" />
		<div id="content-wrapper" class="d-flex flex-column">
			<!-- Main Content -->
			<div id="content">
				<div>
					<jsp:include page="../inc/sellerTopbar.jsp"></jsp:include>
				</div>
				<!-- Content 영역 -->
				<div class="container-fluid">
					<div class="row">
						<!-- 일별 방문자 차트 (큰 영역) -->
						<div class="col-xl-8 col-lg-7">
							<div class="card shadow mb-4">
								<div class="card-header py-3">
									<h6 id="fa" class="m-0 font-weight-bold text-primary">일별
										방문자 통계</h6>
									<!-- 검색 필터 추가 -->
									<div class="row mb-4">
										<div class="col-12">
											<div class="card shadow">
												<div class="card-body">
													<form id="searchForm" class="form-inline">
														<div class="form-group mr-3">
															<select class="form-control" id="periodType">
																<option value="daily">일별</option>
																<option value="weekly">주간별</option>
																<option value="monthly">월별</option>
															</select>
														</div>
														<div class="form-group mr-3">
															<input type="date" class="form-control" id="startDate">
														</div>
														<div class="form-group mr-3">
															<input type="date" class="form-control" id="endDate">
														</div>
														<button type="button" class="btn btn-primary"
															id="searchBtn">검색</button>
													</form>
												</div>
											</div>
										</div>
									</div>
								</div>
								<div class="card-body">
									<div class="chart-area">
										<canvas id="dailyVisitChart"></canvas>
									</div>
								</div>
							</div>
						</div>

						<!-- 우측 패널 (인기 상품 차트 & 방문자별 차트) -->
						<div class="col-xl-4 col-lg-5">
							<!-- 인기 상품 차트 -->
							<div class="card shadow mb-4">
								<div class="card-header py-3">
									<h6 id="fa" class="m-0 font-weight-bold text-primary">인기
										상품</h6>
								</div>
								<div class="card-body">
									<div class="chart-pie">
										<canvas id="popularProductsChart"></canvas>
									</div>
								</div>
							</div>

							<!-- 방문자별 차트 -->
							<div class="card shadow mb-4">
								<div class="card-header py-3">
									<h6 id="fa" class="m-0 font-weight-bold text-primary">방문자별
										방문 횟수</h6>
								</div>
								<div class="card-body">
									<div class="chart-bar">
										<canvas id="visitorBarChart"></canvas>
									</div>
								</div>
							</div>
						</div>
					</div>

					<!-- 상세 방문자 테이블 -->
					<div class="row mt-4">
						<div class="col-12">
							<div class="card shadow mb-4">
								<div class="card-header py-3">
									<h6 id="fa" class="m-0 font-weight-bold text-primary">상세
										방문자 통계</h6>
								</div>
								<div class="card-body">
									<div class="table-responsive">
										<table class="table table-bordered" id="visitorTable"
											width="100%" cellspacing="0">
											<thead>
												<tr>
													<th>날짜</th>
													<th>방문자 수</th>
													<th>인기 상품</th>
													<th>상품 방문자 수</th>
												</tr>
											</thead>
											<tbody>
											</tbody>
										</table>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- Footer -->
				<jsp:include page="../inc/sellerfooter.jsp"></jsp:include>
			</div>
		</div>
	</div>
	<!-- Bootstrap 및 기타 플러그인 JS -->
	<script
		src="${pageContext.request.contextPath}/resources/public/vendor/jquery/jquery.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/public/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/public/vendor/jquery-easing/jquery.easing.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/public/js/sb-admin-2.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/public/vendor/chart.js/Chart.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/public/vendor/datepicker/moment.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/public/vendor/datatables/jquery.dataTables.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/public/vendor/datatables/dataTables.bootstrap4.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/public/js/index.js"></script>