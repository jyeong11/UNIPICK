<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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

<!-- CSS for Page -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&family=Nunito:wght@200..1000&display=swap" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/public/css/sb-admin-2.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/public/css/adm.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/public/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/public/vendor/datatables/datatables.min.css" rel="stylesheet">

</head>
<body id="page-top">
<div>
<jsp:include page="../inc/sellerSidebar.jsp"></jsp:include>
</div>
 
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

// 	console.log("현재 페이지 주소: " + window.location.pathname);

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
		
        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">

               <!-- Topbar -->
               

                <!-- Begin Page Content -->
                <div class="container-fluid">
                   <!-- Page Heading -->
                    <div class="d-sm-flex align-items-center justify-content-center mb-4">
                        <h5 class="mb-0 text-gray-800" id="todayText"></h5>
                    </div>

                    <!-- Content Row 메인 상단 -->
                    <div class="row">
                    	
                    	<!-- 상단1) 등록된 전체 상품 수 -->
                        <div class="col-xl-4 col-md-6 mb-4">
                            <div class="card border-left-primary shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="font-weight-bold text-primary text-uppercase mb-1">등록된 상품 건수</div>
                                            <div class="h3 mb-0 font-weight-bold text-gray-800 counter-text" id="totalProducts">75</div>
                                        </div>
                                        <div class="col-auto">
                                        	<i class="fa-solid fa-box fa-2x text-gray-300"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                         <!-- 상단2) 현재 거래 진행중인 상품 건수 -->
                        <div class="col-xl-4 col-md-6 mb-4">
                            <div class="card border-left-success shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="font-weight-bold text-success text-uppercase mb-1">진행중인 거래 수</div>
                                            <div class="h3 mb-0 font-weight-bold text-gray-800 counter-text" id="activeTrades">49</div>
                                        </div>
                                        <div class="col-auto">
                                        	<i class="fa-solid fa-tag fa-2x text-gray-300"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- 상단3) 완료된 거래 건수 -->
                        <div class="col-xl-4 col-md-6 mb-4">
                            <div class="card border-left-warning shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="font-weight-bold text-warning text-uppercase mb-1">완료된 거래 수</div>
                                            <div class="h3 mb-0 font-weight-bold text-gray-800 counter-text" id="completeTrades">5</div>
                                        </div>
                                        <div class="col-auto">
                                        	<i class="fa-solid fa-clipboard-list fa-2x text-gray-300"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div> <!-- /.row -->
                    
                    <!-- Content Row 메인 상단2 -->
                    <div class="row">
                    	
                    	<!-- 상단4) 미처리 신고 -->
                        <div class="col-xl-4 col-md-6 mb-4">
                            <div class="card border-left-danger shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="font-weight-bold text-danger text-uppercase mb-1">미처리 신고</div>
                                            <div class="row no-gutters align-items-center">
                                                <div class="col-auto">
                                                    <div class="h3 mb-0 mr-3 font-weight-bold text-gray-800 counter-text" id="pendingReports">17</div>
                                                </div>
<!--                                                 <div class="col"> -->
<!--                                                     <div class="progress progress-sm mr-2"> -->
<!--                                                         <div class="progress-bar bg-danger" role="progressbar" -->
<!--                                                             style="width: 50%" aria-valuenow="50" aria-valuemin="0" -->
<!--                                                             aria-valuemax="100"></div> -->
<!--                                                     </div> -->
<!--                                                 </div> -->
                                            </div>
                                        </div>
                                        <div class="col-auto">
                                            <i class="fa-solid fa-flag fa-2x text-gray-300"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                         <!-- 상단5) 신규 가입자 수 -->
                        <div class="col-xl-4 col-md-6 mb-4">
                            <div class="card border-left-info shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="font-weight-bold text-info text-uppercase mb-1">신규 가입자 수</div>
                                            <div class="h3 mb-0 font-weight-bold text-gray-800 counter-text" id="newUsers">0</div>
                                        </div>
                                        <div class="col-auto">
                                        	<i class="fa-solid fa-user-plus fa-2x text-gray-300"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- 상단6) 전체 회원 수 -->
                        <div class="col-xl-4 col-md-6 mb-4">
                            <div class="card border-left-secondary shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="font-weight-bold text-secondary text-uppercase mb-1">전체 회원 수</div>
                                            <div class="h3 mb-0 font-weight-bold text-gray-800 counter-text"  id="totalUsers">59</div>
                                        </div>
                                        <div class="col-auto">
                                        	<i class="fa-solid fa-users fa-2x text-gray-300"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div> <!-- /.row -->
                    
                     <!-- Content Row 메인 하단 -->
                    <div class="row">
                    
                    	<!-- Area Chart -->
                        <div class="col-xl-3 col-lg-3">
                            <div class="card shadow mb-4">
                                <!-- Card Header -->
                                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                    <h6 class="m-0 font-weight-bold text-primary">가격대별 상품 분포</h6>
                                </div>
                                <!-- Card Body -->
                                <div class="card-body">
                                    <div class="chart-area">
                                        <canvas id="priceRangeChart"></canvas>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Pie Chart -->
                        <div class="col-xl-4 col-lg-4">
                            <div class="card shadow mb-4">
                                <!-- Card Header -->
                                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                    <h6 class="m-0 font-weight-bold text-primary">카테고리별 통계</h6>
                                </div>
                                <!-- Card Body -->
                                <div class="card-body">
                                    <div class="chart-pie pt-4 pb-2">
                                        <canvas id="categoryStats"></canvas>
                                    </div>
                                    <div class="mt-4 text-center small" id="categoryLabels">
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Bar Chart -->
                        <div class="col-xl-5 col-lg-5">
	                        <div class="card shadow mb-4">
	                            <div class="card-header py-3">
	                                <h6 class="m-0 font-weight-bold text-primary">최근 일주일간 중고거래</h6>
	                            </div>
	                            <div class="card-body">
	                            	<div class="text-sm-right font-weight-bold"><a href="AdmProductOrderList">거래내역 보러가기 <i class="fa-solid fa-arrow-right"></i></a></div>
	                            	<div class="table-responsive">
		                                <table class="table table-bordered compact" id="transactionList" width="100%" cellspacing="0">
		                                    <thead></thead>
		                                    <tbody></tbody>
		                                </table>
		                          	</div>
	                            </div>
	                        </div>
                    	</div>
                    
                    
                    </div> <!-- /.row -->

                </div>
                <!-- /.container-fluid -->

            </div>
            <!-- End of Main Content -->

            <!-- Footer -->
            <footer class="sticky-footer bg-white">
                <div class="container my-auto">
    <div class="copyright text-center my-auto">
        <span>Copyright &copy; GoodBuy Admin 2024-2025</span>
    </div>
</div>
            </footer>
            <!-- End of Footer -->

        </div>
        <!-- End of Content Wrapper -->

    </div>
    <!-- End of Page Wrapper -->

    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
        <i class="fas fa-angle-up"></i>
    </a>

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
    
    <script>
//     	const categoryStats = '';
//     	let data = categoryStats.replaceAll('=', ':').replaceAll('{', '{"').replaceAll(':', '":').replaceAll('", ', '", "');
    </script>

</body>


</html>