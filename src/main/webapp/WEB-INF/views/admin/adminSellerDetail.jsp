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
	href="${pageContext.request.contextPath}/resources/css/seller/sellerOrdDetail.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/resources/css/seller/product.css"
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
<script src="https://uicdn.toast.com/tui-color-picker/latest/tui-color-picker.min.js"></script>
<script src="https://uicdn.toast.com/editor-plugin-color-syntax/latest/toastui-editor-plugin-color-syntax.min.js"></script>

<!-- favicon -->
<link rel="icon" href="${pageContext.request.contextPath }/resources/images/favicon.png">

<!-- 페이지 전용 JS (외부 파일로 분리) -->
<script src="${pageContext.request.contextPath}/resources/js/admin/adminSellerDetail.js"></script>
</head>
<body id="page-top">
	<div id="wrapper">
		<jsp:include page="../inc/adminSidebar.jsp" />
		<div id="content-wrapper" class="d-flex flex-column">
			<div id="content">
				<!-- Topbar 영역 -->
				<jsp:include page="../inc/adminTopbar.jsp" />
				<!-- Content 영역 -->
				<div class="container-fluid">
					<div class="row">
						<div class="col-lg-12">
							<div class="card shadow mb-4">
								<div class="card-header py-3">
									<h5 class="m-0 font-weight-bold sel">판매자 상세조회</h5>
								</div>
								<div>
									<div class="buyerOrdInfo">
										<div class="section">
											<div class="item-regi-name">상품 정보</div>
											<div class="label">ID:</div>
											<input type="text" class="input-box" id="sel_id" readonly>
											<div class="label">스토어 명:</div>
											<input type="text" class="input-box" id="sel_nm" readonly>
											<div class="label">대표자 명:</div>
											<input type="text" class="input-box" id="sel_rn" readonly>
											<div class="label">담당자 명:</div>
											<input type="text" class="input-box" id="sel_mn" readonly>
											<div class="label">담당자 번호:</div>
											<input type="text" class="input-box" id="sel_mp" readonly>
											<div class="label">고객센터 번호:</div>
											<input type="text" class="input-box" id="sel_cs" readonly>
											<div class="label">사업자등록번호:</div>
											<input type="text" class="input-box" id="sel_br" readonly>
											<div class="label">사업장주소:</div>
											<input type="text" class="input-box" id="sel_ad" readonly>
											<div class="label">계정상태:</div>
											<select class="input-box" id="sel_st">
											    <option value="정상">활성</option>
											    <option value="ss02">휴먼</option>
											    <option value="ss03">정지</option>
											</select>
											<div class="button-container">
												<button id="updateBtn" class="button">수정</button>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- Footer -->
				<footer class="sticky-footer bg-white">
					<div class="container my-auto">
						<div class="copyright text-center my-auto">
							<span>Copyright &copy; UNIPICK SELLER 2025</span>
						</div>
					</div>
				</footer>
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
	<%--   <script src="${pageContext.request.contextPath}/resources/public/js/index.js"></script> --%>