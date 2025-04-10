<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>UNIPICK</title>
  <script> var contextPath = '${pageContext.request.contextPath}';</script>
  <!-- jQuery 먼저 로드 -->
  <script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.1.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<!-- font-awesome -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/public/fontawesome/all.min.css" />
<script src="${pageContext.request.contextPath }/resources/public/fontawesome/all.min.js"></script>

<!-- CSS for Page -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&family=Nunito:wght@200..1000&display=swap" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/public/css/sb-admin-2.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/public/css/adm.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/public/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/public/vendor/datatables/datatables.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/css/seller/sellerMain.css" rel="stylesheet">
  <!-- TOAST UI Editor -->
  <link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />
  <script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
  <link rel="stylesheet" href="https://uicdn.toast.com/tui-color-picker/latest/tui-color-picker.min.css" />
  <link rel="stylesheet" href="https://uicdn.toast.com/editor-plugin-color-syntax/latest/toastui-editor-plugin-color-syntax.min.css" />	
  <script src="https://uicdn.toast.com/tui-color-picker/latest/tui-color-picker.min.js"></script>
  <script src="https://uicdn.toast.com/editor-plugin-color-syntax/latest/toastui-editor-plugin-color-syntax.min.js"></script>
<!-- favicon -->
<link rel="icon" href="${pageContext.request.contextPath }/resources/images/favicon.png">
<!-- js -->
<!-- jQuery를 먼저 로드한 후 다른 스크립트를 로드 -->
<script src="${pageContext.request.contextPath }/resources/js/seller/sellerMain.js"></script>
<!-- jQuery 및 Chart.js에 의존성 있는 sellerVisitorStats.js -->
<script src="${pageContext.request.contextPath}/resources/js/seller/sellerVisitorStats.js"></script>
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
      background: linear-gradient(135deg, #f2a900 0%, #7422bd 100%);
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
	<script>
document.addEventListener("DOMContentLoaded", function () {
    const menuTitles = document.querySelectorAll(".menu-title");

    menuTitles.forEach(title => {
        title.addEventListener("click", function (event) {
            event.preventDefault(); // 링크 이동 방지
            const submenu = this.nextElementSibling;
            submenu.classList.toggle("open");
        });
    });
});
</script>
	<script type="text/javascript">

	document.addEventListener("DOMContentLoaded", function(){
		// 현재 페이지에 해당하는 메뉴 활성화
		let pathName = window.location.pathname.substring(1);
		let collapseItems = document.querySelectorAll(".collapse-item");
		
		collapseItems.forEach((item) => {
			item.classList.remove("active");
			
			if (pathName == item.getAttribute('href') || pathName == item.getAttribute('data-sub-page') || pathName == item.getAttribute('data-sub-page2')) {
				item.classList.add("active");
				item.parentElement.parentElement.classList.add("show");
				item.parentElement.parentElement.parentElement.classList.add("active");
			}
			
		});
	});
</script>
	<!-- // Sidebar -->
	<div id="wrapper">
		<div>
			<jsp:include page="../inc/sellerSidebar.jsp"></jsp:include>
		</div>

		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">

			<!-- Main Content -->
			<div id="content">
				<div>
					<jsp:include page="../inc/sellerTopbar.jsp"></jsp:include>
				</div>
				<!-- 판매자 ID를 위한 hidden input 추가 -->
				<input type="hidden" id="sessionUserId" value="${sessionScope.selId}">
				<!-- sellerVisitorStats.js가 필요로 하는 hidden 폼 요소들 -->
				<input type="hidden" id="periodType" value="daily">
				<input type="hidden" id="startDate" value="">
				<input type="hidden" id="endDate" value="">
				<!-- Begin Page Content -->
				<div class="container-fluid">
					<!-- Page Heading -->
					<div
						class="d-sm-flex align-items-center justify-content-center mb-4">
						<h5 class="mb-0 text-gray-800" id="todayText"></h5>
					</div>

					<!-- Content Row 메인 상단 -->
					<div class="row">

						<div class="col-xl-4 col-md-6 mb-4">
							<div class="card border-left-primary shadow h-100 py-2">
								<a id="orderCnt" href="selOrderList">
									<div class="card-body">
										<div class="row no-gutters align-items-center">
											<div class="col mr-2">
												<div
													class="font-weight-bold text-primary text-uppercase mb-1">신규
													주문</div>
												<div
													class="h3 mb-0 font-weight-bold text-gray-800 counter-text"
													id="totalProduct"></div>
											</div>
											<div class="col-auto">
												<i class="fa-solid fa-box fa-2x text-gray-300"></i>
											</div>
										</div>
									</div>
								</a>
							</div>
						</div>

						<!-- 상단6) 전체 회원 수 -->
						<div class="col-xl-4 col-md-6 mb-4">
							<div class="card border-left-secondary shadow h-100 py-2">
								<a id="account"  href="account">
									<div class="card-body">
										<div class="row no-gutters align-items-center">
											<div class="col mr-2">
												<div
													class="font-weight-bold text-secondary text-uppercase mb-1">이번달
													매출액</div>
												<div
													class="h3 mb-0 font-weight-bold text-gray-800 counter-text"
													id="totalUsers"></div>
											</div>
											<div class="col-auto">
												<i class="fa-solid fa-users fa-2x text-gray-300"></i>
											</div>
										</div>
									</div>
								</a>
							</div>
						</div>

						<div class="col-xl-4 col-md-6 mb-4">
							<div class="card border-left-warning shadow h-100 py-2">
								<a id="sellerVisit" href="sellerVisit">
									<div class="card-body">
										<div class="row no-gutters align-items-center">
											<div class="col mr-2">
												<div
													class="font-weight-bold text-warning text-uppercase mb-1">일자별
													방문내역 수</div>
												<div
													class="h3 mb-0 font-weight-bold text-gray-800 counter-text"
													id="completeTrades">5</div>
											</div>
											<div class="col-auto">
												<i class="fa-solid fa-clipboard-list fa-2x text-gray-300"></i>
											</div>
										</div>
									</div>
								</a>
							</div>
						</div>
					</div>
					<!-- /.row -->
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
					<!-- /.row -->

				</div>
				<!-- /.container-fluid -->

			</div>
			<!-- End of Main Content -->

			<!-- Footer -->
			<jsp:include page="../inc/sellerfooter.jsp"></jsp:include>
			<!-- End of Footer -->

		</div>
		<!-- End of Content Wrapper -->

	</div>
	<!-- End of Page Wrapper -->

	<!-- Scroll to Top Button-->
	<a class="scroll-to-top rounded" href="#page-top"> <i
		class="fas fa-angle-up"></i>
	</a>

  <!-- Bootstrap 및 기타 플러그인 JS -->
  <!-- <script src="${pageContext.request.contextPath}/resources/public/vendor/jquery/jquery.min.js"></script> -->
  <script src="${pageContext.request.contextPath}/resources/public/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
  <script src="${pageContext.request.contextPath}/resources/public/vendor/jquery-easing/jquery.easing.min.js"></script>
  <script src="${pageContext.request.contextPath}/resources/public/js/sb-admin-2.min.js"></script>
  <script src="${pageContext.request.contextPath}/resources/public/vendor/chart.js/Chart.min.js"></script>
  <script src="${pageContext.request.contextPath}/resources/public/vendor/datepicker/moment.min.js"></script>
  <script src="${pageContext.request.contextPath}/resources/public/vendor/datatables/jquery.dataTables.min.js"></script>
  <script src="${pageContext.request.contextPath}/resources/public/vendor/datatables/dataTables.bootstrap4.min.js"></script>
  <script src="${pageContext.request.contextPath}/resources/public/js/index.js"></script>

	<script>
//     	const categoryStats = '';
//     	let data = categoryStats.replaceAll('=', ':').replaceAll('{', '{"').replaceAll(':', '":').replaceAll('", ', '", "');
    </script>
</body>


</html>