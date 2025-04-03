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
<script
	src="https://uicdn.toast.com/tui-color-picker/latest/tui-color-picker.min.js"></script>
<script
	src="https://uicdn.toast.com/editor-plugin-color-syntax/latest/toastui-editor-plugin-color-syntax.min.js"></script>

<!-- favicon -->
<link rel="icon"
	href="${pageContext.request.contextPath }/resources/images/favicon.png">
<!-- 페이지 전용 JS (외부 파일로 분리) -->
<script
	src="${pageContext.request.contextPath}/resources/js/seller/sellerOrdDetail.js"></script>
</head>
<body id="page-top">
	<div id="wrapper">
		<jsp:include page="../inc/sellerSidebar.jsp" />
		<div id="content-wrapper" class="d-flex flex-column">
			<div id="content">
				<!-- Topbar 영역 -->
				<nav
					class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">
					<button id="sidebarToggleTop"
						class="btn btn-link d-md-none rounded-circle mr-3">
						<i class="fa fa-bars"></i>
					</button>
					<h4 class="m-0 text-gray-900">판매자 대시보드</h4>
					<ul class="navbar-nav ml-auto">
						<li class="nav-item dropdown no-arrow"><a
							class="nav-link dropdown-toggle" href="#" id="userDropdown"
							role="button" data-toggle="dropdown"> <span
								class="mr-2 d-none d-lg-inline text-gray-600 small">관리자</span> <img
								class="img-profile rounded-circle"
								src="../../resources/adm/img/admin_profile.png">
						</a>
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
				<!-- Logout Modal -->
				<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog">
					<div class="modal-dialog" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title">로그아웃 하시겠습니까?</h5>
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
				<!-- Content 영역 -->
				<div class="container-fluid">
					<div class="row">
						<div class="col-lg-12">
							<div class="card shadow mb-4">
								<div class="card-header py-3">
									<h5 class="m-0 font-weight-bold sel">상품 상세조회</h5>
								</div>
								<div>
									<div class="buyerOrdInfo">
										<div class="section">
											<div class="item-regi-name">상품 정보</div>
											<div class="label">상품코드:</div>
											<input type="text" class="input-box" id="prd_cd" readonly>
											<div class="label">상품명:</div>
											<input type="text" class="input-box" id="prd_nm" readonly>
											<div class="label">주문 사이즈:</div>
											<input type="text" class="input-box" id="siz_nm" readonly>
											<div class="label">주문 컬러:</div>
											<input type="text" class="input-box" id="clr_nm" readonly>
											<div class="label">주문 갯수:</div>
											<input type="text" class="input-box" id="odd_qt" readonly>
										</div>
										<div class="section">
											<div class="item-regi-name">구매자 정보</div>
											<div class="label">이메일:</div>
											<input type="text" class="input-box" id="buy_em" readonly>
											<div class="label">구매자명:</div>
											<input type="text" class="input-box" id="buy_nm" readonly>
											<div class="label">연락처:</div>
											<input type="text" class="input-box" id="buy_ph" readonly>
										</div>
										<div class="section">
											<div class="item-regi-name">수령 정보</div>
											<div class="label">수령자 명</div>
											<input type="text" class="input-box" id="rec_nm" readonly>
											<div class="label">수령자 연락처</div>
											<input type="text" class="input-box" id="rec_ph" readonly>
											<div class="label"> 수령주소:</div>
											<input type="text" class="input-box" id="address" readonly>
											<div class="label">배송메모:</div>
											<input type="text" class="input-box" id="delivery_note"
												readonly>
										</div>
										<div class="section">
											<div class="item-regi-name">결제 정보</div>
											<div class="label">상품금액:</div>
											<input type="text" class="input-box" id="odd_am" readonly>
											<div class="label">결제방식:</div>
											<input type="text" class="input-box" id="payment"
												readonly>
										</div>
										<div class="button-container">
											<button class="button">결제 요청 취소</button>
										</div>
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
	<%--   <script src="${pageContext.request.contextPath}/resources/public/js/index.js"></script> --%>