<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="shortcut icon" href="/resources/img/g_favicon.ico" type="image/x-icon">
<link rel="icon" href="/resources/img/g_favicon.ico" type="image/x-icon">
<title>유니픽 관리자</title>

<!-- default -->
<script src="/resources/js/jquery-3.7.1.js"></script>

<!-- font-awesome -->
<link rel="stylesheet" href="/resources/fontawesome/all.min.css" />
<script src="/resources/fontawesome/all.min.js"></script>

<!-- CSS for Page -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&family=Nunito:wght@200..1000&display=swap" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/css/admincopy/admCopy.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/css/admincopy/sd-admin-2Copy.css" rel="stylesheet">
<link href="/resources/adm/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
<link href="/resources/adm/vendor/datatables/datatables.min.css" rel="stylesheet">
<!-- Favicon -->
<link rel="icon" href="${pageContext.request.contextPath }/resources/images/favicon.png">

</head>
<body id="page-top">

    <!-- Page Wrapper -->
    <div id="wrapper">

		<!-- Sidebar -->
       	
<!-- Sidebar -->
<ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">
    <a class="sidebar-brand d-flex align-items-center justify-content-center" href="admin">UNIPICK</a>
    <hr class="sidebar-divider my-0">
    <li class="nav-item">
        <a class="nav-link" href="admin"><i class="fa-solid fa-house"></i> <span>Main</span></a>
    </li>
    <hr class="sidebar-divider">
    <div class="sidebar-heading">System Setting</div>
    <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#menu01" aria-expanded="true" aria-controls="menu01">
            <i class="fas fa-fw fa-cog"></i> <span>공통코드 관리</span>
        </a>
        <div id="menu01" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
            <div class="bg-white py-2 collapse-inner rounded">
                <a class="collapse-item" href="AdmCommoncodeRegistForm">공통코드 등록</a>
                <a class="collapse-item" href="AdmCommoncodeList">공통코드 목록</a>
            </div>
        </div>
    </li>
    <hr class="sidebar-divider">
    <div class="sidebar-heading">Site Setting</div>
    <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#menu02" aria-expanded="true" aria-controls="menu02">
        	<i class="fa-solid fa-user"></i> <span>회원 관리</span>
        </a>
        <div id="menu02" class="collapse" aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
            <div class="bg-white py-2 collapse-inner rounded">
            	<h6 class="collapse-header">User List</h6>
                <a class="collapse-item" href="AdmMemberList" data-sub-page="AdmMemberDetailForm">회원 목록</a>
            </div>
        </div>
    </li>
    <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#menu03" aria-expanded="true" aria-controls="menu03">
        	<i class="fa-solid fa-credit-card"></i> <span>거래 관리</span>
        </a>
        <div id="menu03" class="collapse" aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
            <div class="bg-white py-2 collapse-inner rounded">
            	<h6 class="collapse-header">Payment Management</h6>
                <a class="collapse-item" href="AdmProductList">상품 목록</a>
                <a class="collapse-item" href="AdmProductOrderList">상품 거래내역</a>
<!--                 <a class="collapse-item" href="AdmPaymentList">페이 판매내역</a> -->
            </div>
        </div>
    </li>
    <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#menu04" aria-expanded="true" aria-controls="menu04">
        	<i class="fa-solid fa-land-mine-on"></i> <span>신고 관리</span>
        </a>
        <div id="menu04" class="collapse" aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
            <div class="bg-white py-2 collapse-inner rounded">
            	<h6 class="collapse-header">Report Management</h6>
                <a class="collapse-item" href="AdmProductReportList">신고 상품 관리</a>
                <a class="collapse-item" href="AdmMemberReportList">신고 회원 관리</a>
            </div>
        </div>
    </li>
    <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#menu05" aria-expanded="true" aria-controls="menu05">
        	<i class="fa-solid fa-newspaper"></i> <span>고객지원 관리</span>
        </a>
        <div id="menu05" class="collapse" aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
            <div class="bg-white py-2 collapse-inner rounded">
            	<h6 class="collapse-header">Customer Management</h6>
                <a class="collapse-item" href="AdmNoticeList" data-sub-page="AdmNoticeModify" data-sub-page2="AdmNoticeRegist">공지사항 관리</a>
                <a class="collapse-item" href="AdmSupportList">1:1 문의 관리</a>
                <a class="collapse-item" href="AdmFaqList">FAQ 관리</a>
            </div>
        </div>
    </li>
    <hr class="sidebar-divider">
    <div class="sidebar-heading">Chart</div>
    <li class="nav-item">
        <a class="nav-link" href="#" data-toggle="collapse" data-target="#menu06" aria-expanded="true" aria-controls="menu06">
            <i class="fas fa-fw fa-chart-area"></i>
            <span>통계 및 로그</span>
        </a>
        <div id="menu06" class="collapse" aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
            <div class="bg-white py-2 collapse-inner rounded">
            	<h6 class="collapse-header">ADMIN</h6>
                <a class="collapse-item" href="AdmChartList">채팅 통계</a>
                <a class="collapse-item" href="PeriodAnalysis">기간별 통계</a>
                <a class="collapse-item" href="AdmLogList">로그 기록</a>
            </div>
        </div>
</ul>
<!-- End of Sidebar -->
<script>
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
               
<!-- Topbar -->
<nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">
    <!-- Sidebar Toggle (Topbar) -->
   <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
       <i class="fa fa-bars"></i>
   </button>
   
   <!-- Title -->
	<h4 class="m-0 text-gray-900"> UNIPICK BOARD</h4>
	
   <!-- Topbar Navbar -->
   <ul class="navbar-nav ml-auto">
       <li class="nav-item dropdown no-arrow">
<!--            <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> -->
               <span class="mr-2 d-none d-lg-inline text-gray-600 small"><a href="adminmypage">${sessionScope.admId }</a></span>
               <img class="img-profile rounded-circle" src="../../resources/adm/img/admin_profile.png">
<!--            </a> -->
           <div id="임시">
               <a href="adminlogin">로그아웃</a>
           </div>
           <!-- Dropdown - User Information -->
            <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
                aria-labelledby="userDropdown">
                <a class="dropdown-item" href="/." target="_blank">
                    <i class="fas fa-list fa-sm fa-fw mr-2 text-gray-400"></i>
                    사용자 화면
                </a>
                <a class="dropdown-item" href="AdmLogList">
                    <i class="fas fa-list fa-sm fa-fw mr-2 text-gray-400"></i>
                    로그 기록
                </a>
                <div class="dropdown-divider"></div>
                <a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal">
                    <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                    로그아웃
                </a>
            </div>
        </li>
    </ul>
</nav>
<!-- Logout Modal-->
<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
    aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">로그아웃 하시겠습니까?</h5>
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
<!-- End of Topbar -->
               <!-- End of Topbar -->

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
                                <div class="card-body" id="body-card">
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
                                </div>
                            </div>
                        </div>
                    </div> <!-- /.row -->
                </div>
                <!-- /.container-fluid -->
            </div>
            <!-- End of Main Content -->
        </div>
        <!-- End of Content Wrapper -->

    </div>
    <!-- End of Page Wrapper -->

    <!-- Scroll to Top Button-->
<!--     <a class="scroll-to-top rounded" href="#page-top"> -->
<!--         <i class="fas fa-angle-up"></i> -->
<!--     </a> -->

    <!-- Bootstrap core JavaScript-->
<!--     <script src="/resources/adm/vendor/jquery/jquery.min.js"></script> -->
    <script src="/resources/js/admin/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
<!--     <script src="/resources/adm/vendor/jquery-easing/jquery.easing.min.js"></script> -->

    <!-- Custom scripts for all pages-->
    <script src="/resources/js/admin/sb-admin-2.js"></script>
    
    <!-- Page level plugins -->
<!--     <script src="/resources/adm/vendor/chart.js/Chart.min.js"></script> -->
<!-- 	<script src="/resources/adm/vendor/datepicker/moment.min.js"></script> -->
<!-- 	<script src="/resources/adm/vendor/datatables/jquery.dataTables.min.js"></script> -->
<!--     <script src="/resources/adm/vendor/datatables/dataTables.bootstrap4.min.js"></script> -->
	
    <!-- Page level custom scripts -->
<!--     <script src="/resources/adm/js/index.js"></script> -->
    

</body>


</html>