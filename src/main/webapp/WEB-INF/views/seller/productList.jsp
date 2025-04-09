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
<link
	href="${pageContext.request.contextPath }/resources/css/seller/product.css"
	rel="stylesheet">
<script
	src="${pageContext.request.contextPath }/resources/js/seller/prdList.js"></script>

<link rel="icon"
	href="${pageContext.request.contextPath }/resources/images/favicon.png">
	
<style>
    .search-container {
        background-color: #f8f9fc;
        border-radius: 10px;
        padding: 20px;
        margin: 15px 0;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
        transition: all 0.3s ease;
    }
    
    .search-container:hover {
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
    }
    
    .search-row {
        display: flex;
        align-items: center;
        justify-content: flex-end;
        gap: 10px;
    }
    
    .search-select {
        border-radius: 5px;
        border: 1px solid #d1d3e2;
        padding: 8px 10px;
        font-size: 14px;
        box-shadow: none;
        transition: border-color 0.2s;
        width: 100%;
        background-color: white;
    }
    
    .search-select:focus {
        border-color: #4e73df;
        box-shadow: 0 0 0 0.2rem rgba(78, 115, 223, 0.25);
    }
    
    .search-input {
        border-radius: 5px;
        border: 1px solid #d1d3e2;
        padding: 8px 15px;
        font-size: 14px;
        transition: all 0.2s;
        width: 100%;
    }
    
    .search-input:focus {
        border-color: #4e73df;
        box-shadow: 0 0 0 0.2rem rgba(78, 115, 223, 0.25);
    }
    
    .search-button {
        background-color: black;
        color: white;
        border: none;
        border-radius: 5px;
        padding: 8px 20px;
        font-size: 14px;
        cursor: pointer;
        transition: all 0.3s;
        font-weight: 500;
        letter-spacing: 0.5px;
        width: 100%;
    }
    
    .search-button:hover {
        background-color: #2e59d9;
        transform: translateY(-2px);
        box-shadow: 0 4px 8px rgba(46, 89, 217, 0.2);
    }
    
    .search-button:active {
        transform: translateY(0);
    }
    
    .table-container {
        border-radius: 5px;
        overflow: hidden;
        box-shadow: 0 0 20px rgba(0, 0, 0, 0.05);
    }
    
    #productList {
        border-collapse: separate;
    }
    
    #productList thead th {
        background-color: #f2a900ff;
        color: white;
        font-weight: 500;
        border: none;
        padding: 12px 15px;
    }
    
    #productList tbody tr {
        transition: all 0.3s;
    }
    
    #productList tbody tr:hover {
        background-color: #f8f9fc;
    }
    
    /* 페이징 스타일 */
    #pageList {
        display: flex;
        justify-content: center;
        align-items: center;
        margin: 25px 0;
        gap: 5px;
    }
    
    #pageList .page-link {
        display: flex;
        align-items: center;
        justify-content: center;
        width: 36px;
        height: 36px;
        border-radius: 5px;
        background-color: #fff;
        color: #4e73df;
        text-decoration: none;
        border: 1px solid #d1d3e2;
        font-size: 14px;
        transition: all 0.2s;
    }
    
    #pageList .page-link:hover {
        background-color: #f8f9fc;
        border-color: #4e73df;
    }
    
    #pageList .page-link.active {
        background-color: #4e73df;
        color: #fff;
        border-color: #4e73df;
        font-weight: bold;
    }
    
    #pageList .prev-page,
    #pageList .next-page {
        font-weight: bold;
        width: auto;
        padding: 0 12px;
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
				<!-- Begin Page Content -->
				<div class="container-fluid">
					<div class="row">
						<div class="col-lg-12">
							<div class="card shadow mb-4">
								<div class="card-header py-3">
									<h5 class="m-0 font-weight-bold text-primary">상품 목록</h5>
								</div>
								<div class="search-container">
									<div class="search-row">
										<div class="col-md-2">
											<select class="search-select" id="noticeSearchKind">
												<option value="name">상품명</option>
												<option value="category">카테고리</option>
												<option value="color">컬러</option>
											</select>
										</div>
										<div class="col-md-3">
											<input type="text" id="noticeSearchWord" class="search-input"
												placeholder="검색어를 입력하세요">
										</div>
										<div class="col-md-1">
											<button id="noticeSearch" class="search-button"
												type="button">조회</button>
										</div>
									</div>
								</div>
								<!-- 상품 목록 테이블 -->
								<div class="table-container">
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
								<div class="pagination-container">
									<section id="pageList" class="pagination"></section>
								</div>
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