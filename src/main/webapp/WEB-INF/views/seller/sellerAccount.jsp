<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>정산관리</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/seller/sellerAccount.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        var contextPath = "${pageContext.request.contextPath}";
    </script>
    <script src="${pageContext.request.contextPath}/resources/js/seller/sellerAccount.js"></script>
</head>
<body>
    <div class="container">
        <h2>정산관리</h2>
        
        <!-- 필터 섹션 -->
        <div class="filter-section">
            <div class="row">
                <div class="col-md-3">
                    <select id="periodType" class="form-control">
                        <option value="daily">일별</option>
                        <option value="weekly">주별</option>
                        <option value="monthly">월별</option>
                        <option value="yearly">연도별</option>
                    </select>
                </div>
                <div class="col-md-3 date-input">
                    <input type="date" id="startDate" class="form-control">
                </div>
                <div class="col-md-3 date-input">
                    <input type="date" id="endDate" class="form-control">
                </div>
                <div class="col-md-3">
                    <button id="searchBtn" class="btn btn-primary">검색</button>
                    <button id="excelBtn" class="btn btn-success">엑셀 다운로드</button>
                </div>
            </div>
        </div>

        <!-- 요약 정보 섹션 -->
        <div class="summary-section">
            <div class="row">
                <div class="col-md-3">
                    <div class="card border-left-primary">
                        <div class="card-body">
                            <h5>총 주문건수</h5>
                            <h3 id="totalOrders">0</h3>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card border-left-success">
                        <div class="card-body">
                            <h5>총 판매수량</h5>
                            <h3 id="totalSales">0</h3>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card border-left-info">
                        <div class="card-body">
                            <h5>총 수수료</h5>
                            <h3 id="totalCommission">0원</h3>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card border-left-warning">
                        <div class="card-body">
                            <h5>총 순이익</h5>
                            <h3 id="totalProfit">0원</h3>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 정산 테이블 -->
        <div class="table-responsive">
            <table id="settlementTable" class="table table-bordered">
                <thead>
                    <tr>
                        <th>기간</th>
                        <th>주문건수</th>
                        <th>판매수량</th>
                        <th>교환</th>
                        <th>반품</th>
                        <th>매출액</th>
                        <th>수수료</th>
                        <th>판매이익금</th>
                        <th>정산일자</th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html> 