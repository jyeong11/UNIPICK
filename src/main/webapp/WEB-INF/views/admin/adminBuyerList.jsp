<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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

<link
  href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
  rel="stylesheet"
  integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
  crossorigin="anonymous">

<!-- Bootstrap JS (모달 동작 기능 포함) -->
<script
  src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
  integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
  crossorigin="anonymous"></script>

<!-- CSS for Page -->
<link href="${pageContext.request.contextPath }/resources/public/css/sb-admin-2.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/public/css/adm.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/public/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/public/vendor/datatables/datatables.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/css/admin/adminSellerList.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/css/admin/adminBuyerList.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/css/admin/adminPublic2.css" rel="stylesheet" type="text/css">

<script src="${pageContext.request.contextPath }/resources/js/admin/adminBuyerList.js"></script>
<link rel="icon" href="${pageContext.request.contextPath }/resources/images/favicon.png">
</head>
<body>
	<div id="wrapper">
		<div>
			<jsp:include page="../inc/adminSidebar.jsp"></jsp:include>
		</div>
		
		<div id="content-wrapper" class="d-flex flex-column">
			<div id="content">
	            <div>
	            	<jsp:include page="../inc/adminTopbar.jsp"></jsp:include>
	            </div>
	            
	            <main>
				<!-- 계정설정 -->
				<section class="wrapper">
					<div class="container-fluid">
						<div class="row">
							<div class="col-lg-12">
							<div class="card shadow mb-4">
								<div class="card-header py-3">
									<h5 class="m-0 font-weight-bold" id="subTitle">구매자 목록</h5>
								</div>
								<div class="container">
									<div class="row align-items-start justify-content-end" id="searchList">
										<div class="col-2">
											<select class="form-select" id="buyerStatusKind">
												<option value="all">전체</option>
											</select>
										</div>
										<div class="col-2">
											<select class="form-select" id="buyerSearchKind">
												<option value="buy_em">이메일</option>
												<option value="buy_nm">이름</option>
												<option value="buy_nn">닉네임</option>
											</select>
										</div>
										<div class="col-3">
											<input type="text" id="buyerSearchWord" class="form-control" placeholder="검색어 입력">
										</div>
										<div class="col-1">
											<button id="buyerSearch" class="btn btn_main_color" type="button">조회</button>
										</div>
									</div>
								</div>
									<!-- 상품 목록 테이블 -->
									<div class="table-responsive left-table">
										<table class="table table-bordered" id="buyerList">
											<thead>
												<tr>
													<th>순번</th>
													<th>ID</th>
													<th>이름</th>
													<th>닉네임</th>
													<th>가입일시</th>
													<th>누적 신고수</th>
													<th>계정상태</th>
												</tr>
											</thead>
											<tbody id="buyerListTable"></tbody>
										</table>
									</div>
									<section id="pageList"></section>
								</div>
								<div class="modal fade" id="exampleModal" tabindex="-1"
									role="dialog" aria-labelledby="exampleModalLabel"
									aria-hidden="true">
									<div id="modal" class="modal-dialog modal-xl"
										role="document">
										<div class="modal-content">
											<div class="modal-header">구매자 상세 정보</div>
											<div class="modal-body">
												<div id="modal-con"></div>
											</div>
										</div>
									</div>
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
            </div>
		</div>
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
	
</body>
</html>