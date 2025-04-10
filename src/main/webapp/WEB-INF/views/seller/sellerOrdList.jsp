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
<link href="${pageContext.request.contextPath }/resources/css/seller/sellerOrdList.css" rel="stylesheet">
<script src="${pageContext.request.contextPath }/resources/js/seller/sellerOrdList.js"></script>
<link rel="icon" href="${pageContext.request.contextPath }/resources/images/favicon.png">
<style>
    .col-lg-12 {
        flex: 0 0 100%;
        max-width: 100%;
        height: 47rem !important;
    }

</style>
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
										<h5 class="m-0 font-weight-bold text-primary">주문 목록</h5>
									</div>
									<div class="container">
										<div class="row">
											<div class="my-tabs">
												<button class="filter-btn active" data-status="all">전체</button>
												<button class="filter-btn" data-status="결제완료">결제완료</button>
												<button class="filter-btn" data-status="배송중">배송중</button>
												<button class="filter-btn" data-status="배송완료">배송완료</button>
												<button class="filter-btn" data-status="취소접수">취소접수</button>
												<button class="filter-btn" data-status="반품접수">반품접수</button>
											</div>
											<div class="search-container">
												<div class="col-md-3">
													<select class="form-select" id="noticeSearchKind">
														<option value="name">이름</option>
														<option value="phone">연락처</option>
														<option value="order">주문번호</option>
													</select>
												</div>
												<div class="col-md-6">
													<input type="text" id="noticeSearchWord" class="form-control" placeholder="검색어 입력">
												</div>
												<div class="col-md-3">
													<button id="noticeSearch" class="btn btn_main_color" type="button">조회</button>
												</div>
											</div>
										</div>
									</div>
									<!-- 상품 목록 테이블 -->
									<div class="table-responsive">
										<table class="table table-bordered" id="productList">
											<thead>
												<tr>
													<th>주문번호</th>
													<th>주문일</th>
													<th>구매자</th>
													<th>연락처</th>
													<th>구매수량</th>
													<th>결제금액</th>
													<th>주문상태</th>
													<th>상태변경</th>
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
				</section>
			</main>
			<!-- Footer -->
			<jsp:include page="../inc/sellerfooter.jsp"></jsp:include>
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