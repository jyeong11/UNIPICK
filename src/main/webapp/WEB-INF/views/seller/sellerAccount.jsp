<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>정산관리</title>
    
    <!-- 기본 스크립트 및 스타일 -->
    <script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/public/fontawesome/all.min.css" />
    <script src="${pageContext.request.contextPath}/resources/public/fontawesome/all.min.js"></script>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&family=Nunito:wght@200..1000&display=swap" rel="stylesheet">
    
    <!-- 페이지 전용 CSS -->
    <link href="${pageContext.request.contextPath}/resources/public/css/sb-admin-2.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/public/css/adm.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/public/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/public/vendor/datatables/datatables.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/seller/productRegister.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/seller/product.css" rel="stylesheet">
    
    <!-- Custom JS -->
    <script src="${pageContext.request.contextPath}/resources/js/seller/sellerAccount.js"></script>
    
    <style>
    	.container-fluid{
    	height: 47.5rem;
    	}
    
        .card {
            margin-bottom: 20px;
        }
        .card-title {
            font-size: 1.1rem;
            margin-bottom: 0.5rem;
        }
        .card-text {
            font-size: 1.5rem;
            font-weight: bold;
        }
        .table th {
            background-color: #f8f9fa;
        }
    </style>
</head>
<body id="page-top">
    <div id="wrapper">
        <jsp:include page="../inc/sellerSidebar.jsp" />
        <div id="content-wrapper" class="d-flex flex-column">
            <div id="content">
            	<div>
					<jsp:include page="../inc/sellerTopbar.jsp"></jsp:include>
				</div>
<!--                 <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow"> -->
<!--                     <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3"> -->
<!--                         <i class="fa fa-bars"></i> -->
<!--                     </button> -->
<!--                     <h4 class="m-0 text-gray-900 font-weight-bold">정산관리</h4> -->
<!--                 </nav> -->
                
                <div class="container-fluid">
                    <!-- 검색 필터 -->
                    <div class="row mb-4">
                        <div class="col-12">
                            <div class="card shadow">
                                <div class="card-body">
                                    <form id="searchForm" class="row g-3 align-items-end">
                                        <div class="col-md-2">
                                            <label for="periodType" class="form-label">기간 유형</label>
                                            <select class="form-select" id="periodType">
                                                <option value="daily">일별</option>
                                                <option value="weekly">주간별</option>
                                                <option value="monthly" selected>월별</option>
                                                <option value="yearly">연도별</option>
                                            </select>
                                        </div>
                                        <div class="col-md-3">
                                            <label for="startDate" class="form-label">시작일</label>
                                            <input type="date" class="form-control" id="startDate">
                                        </div>
                                        <div class="col-md-3">
                                            <label for="endDate" class="form-label">종료일</label>
                                            <input type="date" class="form-control" id="endDate">
                                        </div>
                                        <div class="col-md-2">
                                            <button type="button" class="btn btn-primary" id="searchBtn">조회</button>
                                        </div>
                                        <div class="col-md-2">
                                            <button type="button" class="btn btn-success" id="excelBtn">Excel 다운로드</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- 요약 정보 -->
                    <div class="row mb-4">
                        <div class="col-md-3">
                            <div class="card bg-primary text-white">
                                <div class="card-body">
                                    <h5 class="card-title">총 주문수</h5>
                                    <p class="card-text" id="totalOrders">0</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card bg-success text-white">
                                <div class="card-body">
                                    <h5 class="card-title">총 판매수량</h5>
                                    <p class="card-text" id="totalSales">0</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card bg-warning text-white">
                                <div class="card-body">
                                    <h5 class="card-title">총 수수료</h5>
                                    <p class="card-text" id="totalCommission">0</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card bg-info text-white">
                                <div class="card-body">
                                    <h5 class="card-title">총 순이익</h5>
                                    <p class="card-text" id="totalProfit">0</p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- 정산 데이터 테이블 -->
                    <div class="card shadow">
                        <div class="card-body">
                            <table id="settlementTable" class="table table-striped">
                                <thead>
                                    <tr>
                                        <th>기간</th>
                                        <th>주문수</th>
                                        <th>판매수량</th>
                                        <th>교환건수</th>
                                        <th>반품건수</th>
                                        <th>매출액</th>
                                        <th>수수료</th>
                                        <th>순이익</th>
                                        <th>정산일자</th>
                                    </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                        </div>
                    </div>
            
                </div>
                        			<!-- Footer -->
			<jsp:include page="../inc/sellerfooter.jsp"></jsp:include>
            </div>
        </div>
    </div>

    <!-- contextPath 변수 설정 -->
    <script>
        const contextPath = '${pageContext.request.contextPath}';
    </script>
    
    <!-- Bootstrap 및 기타 플러그인 JS -->
    <script src="${pageContext.request.contextPath}/resources/public/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/public/vendor/jquery-easing/jquery.easing.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/public/js/sb-admin-2.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/public/vendor/chart.js/Chart.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/public/vendor/datepicker/moment.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/public/vendor/datatables/jquery.dataTables.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/public/vendor/datatables/dataTables.bootstrap4.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/public/js/index.js"></script>
</body>
</html>