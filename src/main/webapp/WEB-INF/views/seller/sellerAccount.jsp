<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>정산관리</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- DataTables CSS -->
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.24/css/jquery.dataTables.css">
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <!-- DataTables JS -->
    <script type="text/javascript" src="https://cdn.datatables.net/1.10.24/js/jquery.dataTables.js"></script>
    <!-- Custom JS -->
    <script src="${pageContext.request.contextPath}/resources/js/seller/sellerAccount.js"></script>
    <style>
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
<body>
<!-- Main Content -->
	<div id="content">
		<div>
			<jsp:include page="../inc/sellerTopbar.jsp"></jsp:include>
		</div>
	</div>
    <div class="container mt-4">
        <h2 class="mb-4">정산관리</h2>
        
        <!-- 검색 필터 -->
        <div class="row mb-4">
            <div class="col-12">
                <div class="card shadow">
                    <div class="card-body">
                        <form id="searchForm" class="row g-3">
                            <div class="col-md-3">
                                <select class="form-select" id="periodType">
                                    <option value="daily">일별</option>
                                    <option value="weekly">주간별</option>
                                    <option value="monthly">월별</option>
                                    <option value="yearly">연도별</option>
                                </select>
                            </div>
                            <div class="col-md-3">
                                <input type="date" class="form-control" id="startDate">
                            </div>
                            <div class="col-md-3">
                                <input type="date" class="form-control" id="endDate">
                            </div>
                            <div class="col-md-3">
<!--                                 <button type="button" class="btn btn-primary" id="searchBtn">검색</button> -->
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

    <!-- contextPath 변수 설정 -->
    <script>
        const contextPath = '${pageContext.request.contextPath}';
    </script>
</body>
</html>