<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <title>UNIPICK - 방문자 통계</title>
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
  <!-- TOAST UI Editor -->
  <link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />
  <script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
  <link rel="stylesheet" href="https://uicdn.toast.com/tui-color-picker/latest/tui-color-picker.min.css" />
  <link rel="stylesheet" href="https://uicdn.toast.com/editor-plugin-color-syntax/latest/toastui-editor-plugin-color-syntax.min.css" />	
  <script src="https://uicdn.toast.com/tui-color-picker/latest/tui-color-picker.min.js"></script>
  <script src="https://uicdn.toast.com/editor-plugin-color-syntax/latest/toastui-editor-plugin-color-syntax.min.js"></script>
  
  <script> var contextPath = '${pageContext.request.contextPath}';</script>
  <!-- 페이지 전용 JS (외부 파일로 분리) -->
  <script src="${pageContext.request.contextPath}/resources/js/seller/sellerVisitorStats.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  
  
  <link rel="icon" href="${pageContext.request.contextPath }/resources/images/favicon.png">
  
  <style>
    /* 커스텀 스타일 */
    .stats-card {
      border: none;
      border-radius: 10px;
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
      transition: transform 0.3s, box-shadow 0.3s;
    }
    
    .stats-card:hover {
      transform: translateY(-5px);
      box-shadow: 0 6px 15px rgba(0, 0, 0, 0.1);
    }
    
    .card-header {
      background: linear-gradient(135deg, #4e73df 0%, #36b9cc 100%);
      color: white;
      border-top-left-radius: 10px !important;
      border-top-right-radius: 10px !important;
      border: none;
    }
    
    .chart-area, .chart-pie {
      height: 400px !important;
      padding: 15px;
      position: relative;
      width: 100%;
      overflow: hidden;
    }
    
    .chart-area canvas, .chart-pie canvas {
      max-width: 100%;
      height: auto !important;
    }
    
    .search-card {
      background-color: #f8f9fc;
      border: none;
      box-shadow: 0 2px 8px rgba(0,0,0,0.03);
    }
    
    .form-control {
      border-radius: 20px;
      padding: 10px 15px;
      border: 1px solid #e3e6f0;
      transition: all 0.2s;
    }
    
    .form-control:focus {
      border-color: #4e73df;
      box-shadow: 0 0 0 0.2rem rgba(78, 115, 223, 0.25);
    }
    
    .btn-primary {
      border-radius: 20px;
      padding: 8px 20px;
      background-color: #4e73df;
      border-color: #4e73df;
      transition: all 0.3s;
    }
    
    .btn-primary:hover {
      background-color: #2e59d9;
      border-color: #2e59d9;
      transform: translateY(-2px);
      box-shadow: 0 4px 8px rgba(0,0,0,0.1);
    }
    
    .table {
      border-radius: 8px;
      overflow: hidden;
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.03);
    }
    
    .table thead th {
      background-color: #f8f9fc;
      border-bottom: 2px solid #e3e6f0;
      color: #5a5c69;
      font-weight: 600;
    }
    
    .data-card {
      text-align: center;
      padding: 20px;
      border-radius: 10px;
      background-color: #fff;
      box-shadow: 0 2px 8px rgba(0,0,0,0.08);
      transition: all 0.3s;
    }
    
    .data-card:hover {
      transform: translateY(-5px);
      box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    }
    
    .data-value {
      font-size: 24px;
      font-weight: 700;
      color: #4e73df;
    }
    
    .data-label {
      font-size: 14px;
      color: #858796;
    }
    
    .period-selector {
      font-size: 15px;
      font-weight: 600;
      padding: 10px 20px;
      border-radius: 50px;
      border: 1px solid #e3e6f0;
      background-color: white;
      cursor: pointer;
      margin-right: 10px;
      transition: all 0.3s ease;
    }
    
    .period-selector.active {
      background-color: #4e73df;
      color: white;
      border-color: #4e73df;
    }
    
    .stats-widget {
      padding: 20px;
      background-color: #fff;
      border-radius: 10px;
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
      margin-bottom: 20px;
    }
    
    .widget-title {
      font-size: 18px;
      font-weight: 600;
      margin-bottom: 15px;
      color: #5a5c69;
    }
    
    @media (max-width: 768px) {
      .search-box {
        flex-direction: column;
      }
      
      .form-group {
        margin-bottom: 10px;
        width: 100%;
      }
      
      .chart-area, .chart-pie {
        height: 250px !important;
      }
    }
    
    .dataTables_length select {
      width: 60px !important;
      height: auto !important;
      padding: 0.25rem 0.5rem;
    }
    
    .dataTables_paginate {
      display: flex;
      justify-content: center;
      margin-top: 1rem;
    }
    
    .pagination {
      margin: 0;
    }
    
    /* 차트 레이블을 위한 스타일 */
    .chart-legend {
      position: absolute;
      right: 0;
      top: 50%;
      transform: translateY(-50%);
      padding: 10px;
      background: rgba(255, 255, 255, 0.9);
      border-radius: 5px;
      box-shadow: 0 2px 5px rgba(0,0,0,0.1);
      max-height: 100%;
      overflow-y: auto;
    }
    
    .chart-legend-item {
      display: flex;
      align-items: center;
      margin-bottom: 5px;
      font-size: 12px;
    }
    
    .chart-legend-color {
      width: 12px;
      height: 12px;
      margin-right: 5px;
      border-radius: 3px;
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
        <!-- Topbar 영역 -->
<!--         <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow"> -->
<!--           <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3"> -->
<!--             <i class="fa fa-bars"></i> -->
<!--           </button> -->
<!--           <h4 class="m-0 text-gray-900 font-weight-bold">방문자 통계 대시보드</h4> -->
<!--           <ul class="navbar-nav ml-auto"> -->
<!--             <li class="nav-item dropdown no-arrow"> -->
<!--               <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown"> -->
<!--                 <span class="mr-2 d-none d-lg-inline text-gray-600 small">관리자</span> -->
<!--                 <img class="img-profile rounded-circle" src="../../resources/adm/img/admin_profile.png"> -->
<!--               </a> -->
<!--               <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown"> -->
<!--                 <a class="dropdown-item" href="/." target="_blank"> -->
<!--                   <i class="fas fa-list fa-sm fa-fw mr-2 text-gray-400"></i>사용자 화면 -->
<!--                 </a> -->
<!--                 <a class="dropdown-item" href="AdmLogList"> -->
<!--                   <i class="fas fa-list fa-sm fa-fw mr-2 text-gray-400"></i>로그 기록 -->
<!--                 </a> -->
<!--                 <div class="dropdown-divider"></div> -->
<!--                 <a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal"> -->
<!--                   <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>로그아웃 -->
<!--                 </a> -->
<!--               </div> -->
<!--             </li> -->
<!--           </ul> -->
<!--         </nav> -->
        <!-- Logout Modal -->
        <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog">
          <div class="modal-dialog" role="document">
            <div class="modal-content">
              <div class="modal-header">
                <h5 class="modal-title">로그아웃 하시겠습니까?</h5>
                <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                  <span aria-hidden="true">×</span>
                </button>
              </div>
              <div class="modal-body">로그아웃 후에는 관리자 사이트 접근이 불가능합니다.</div>
              <div class="modal-footer">
                <button class="btn btn-secondary" type="button" data-dismiss="modal">취소</button>
                <a class="btn btn-primary" href="MemberLogout">로그아웃</a>
              </div>
            </div>
          </div>
        </div>
        <input type="hidden" id="sessionUserId" value="${sessionScope.selId}">
        <!-- Content 영역 -->
        <div class="container-fluid">
          <!-- 요약 통계 카드 -->
          <div class="row mb-4">
            <div class="col-xl-3 col-md-6 mb-4">
              <div class="data-card">
                <i class="fas fa-users fa-2x text-primary mb-3"></i>
                <div class="data-value" id="totalVisits">0</div>
                <div class="data-label">전체 방문자</div>
              </div>
            </div>
            <div class="col-xl-3 col-md-6 mb-4">
              <div class="data-card">
                <i class="fas fa-chart-line fa-2x text-success mb-3"></i>
                <div class="data-value" id="dailyVisits">0</div>
                <div class="data-label">오늘 방문자</div>
              </div>
            </div>
            <div class="col-xl-3 col-md-6 mb-4">
              <div class="data-card">
                <i class="fas fa-box fa-2x text-info mb-3"></i>
                <div class="data-value" id="totalProducts">0</div>
                <div class="data-label">상품 수</div>
              </div>
            </div>
            <div class="col-xl-3 col-md-6 mb-4">
              <div class="data-card">
                <i class="fas fa-shopping-cart fa-2x text-warning mb-3"></i>
                <div class="data-value" id="conversionRate">0%</div>
                <div class="data-label">전환율</div>
              </div>
            </div>
          </div>
          
          <!-- 검색 필터 추가 -->
          <div class="row mb-4">
            <div class="col-12">
              <div class="card shadow search-card">
                <div class="card-body">
                  <form id="searchForm" class="form-inline d-flex justify-content-between flex-wrap search-box">
                    <div class="d-flex align-items-center mb-2 mb-md-0">
                      <button type="button" class="period-selector mr-2 active" data-period="daily">일별</button>
                      <button type="button" class="period-selector mr-2" data-period="weekly">주간</button>
                      <button type="button" class="period-selector mr-2" data-period="monthly">월별</button>
                      <button type="button" class="period-selector" data-period="yearly">연간</button>
                      <input type="hidden" id="periodType" value="daily">
                    </div>
<!--                     <div class="d-flex align-items-center"> -->
<!--                       <div class="form-group mr-3"> -->
<!--                         <input type="date" class="form-control" id="startDate"> -->
<!--                       </div> -->
<!--                       <span class="mx-2">~</span> -->
<!--                       <div class="form-group mr-3"> -->
<!--                         <input type="date" class="form-control" id="endDate"> -->
<!--                       </div> -->
<!--                       <button type="button" class="btn btn-primary" id="searchBtn"> -->
<!--                         <i class="fas fa-search mr-1"></i> 검색 -->
<!--                       </button> -->
<!--                     </div> -->
                  </form>
                </div>
              </div>
            </div>
          </div>
          
          <!-- 차트 영역 -->
          <div class="row">
            <div class="col-xl-8 col-lg-7">
              <div class="card shadow mb-4 stats-card">
                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                  <h6 class="m-0 font-weight-bold text-white">
                    <i class="fas fa-chart-area mr-1"></i> 일별 방문자 통계
                  </h6>
                </div>
                <div class="card-body">
                  <div class="chart-area">
                    <canvas id="dailyVisitChart"></canvas>
                  </div>
                </div>
              </div>
            </div>
            <div class="col-xl-4 col-lg-5">
              <div class="card shadow mb-4 stats-card">
                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                  <h6 class="m-0 font-weight-bold text-white">
                    <i class="fas fa-chart-pie mr-1"></i> 인기 상품
                  </h6>
                </div>
                <div class="card-body">
                  <div class="chart-pie">
                    <canvas id="popularProductsChart"></canvas>
                  </div>
                </div>
              </div>
            </div>
          </div>
          
          <!-- 상세 데이터 테이블 -->
          <div class="row">
            <div class="col-12">
              <div class="card shadow mb-4 stats-card">
                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                  <h6 class="m-0 font-weight-bold text-white">
                    <i class="fas fa-table mr-1"></i> 상세 방문자 통계
                  </h6>
                  <div class="dropdown no-arrow">
                    <a class="dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                      <i class="fas fa-ellipsis-v fa-sm fa-fw text-white"></i>
                    </a>
                    <div class="dropdown-menu dropdown-menu-right shadow animated--fade-in" aria-labelledby="dropdownMenuLink">
                      <div class="dropdown-header">내보내기:</div>
                      <a class="dropdown-item" href="#" id="exportExcel">
                        <i class="fas fa-file-excel mr-2 text-success"></i>Excel로 내보내기
                      </a>
                      <a class="dropdown-item" href="#" id="exportPDF">
                        <i class="fas fa-file-pdf mr-2 text-danger"></i>PDF로 내보내기
                      </a>
                    </div>
                  </div>
                </div>
                <div class="card-body">
                  <div class="table-responsive">
                    <table class="table table-bordered" id="visitorTable" width="100%" cellspacing="0">
                      <thead>
                        <tr>
                          <th>날짜</th>
                          <th>방문자 수</th>
                          <th>인기 상품</th>
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
  <script src="${pageContext.request.contextPath}/resources/public/vendor/jquery/jquery.min.js"></script>
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