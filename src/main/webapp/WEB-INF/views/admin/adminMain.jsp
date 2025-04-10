<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>UNIPICK</title>

<!-- default -->
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.1.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/admin/adminMain.js"></script>

<!-- font-awesome -->
<%-- <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/public/fontawesome/all.min.css" /> --%>
<script src="${pageContext.request.contextPath }/resources/public/fontawesome/all.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<!-- CSS for Page -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&family=Nunito:wght@200..1000&display=swap" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/public/css/sb-admin-2.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/public/css/adm.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/public/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/public/vendor/datatables/datatables.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/css/public.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/css/admin/adminMain.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/css/admin/adminPublic2.css" rel="stylesheet" type="text/css">
<!-- Favicon -->
<link rel="icon" href="${pageContext.request.contextPath }/resources/images/favicon.png">

</head>
<body id="page-top">
    <!-- Page Wrapper -->
    <div id="wrapper"><div>
	<jsp:include page="../inc/adminSidebar.jsp"></jsp:include>
</div>


		<!-- // Sidebar -->
        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">
            <!-- Main Content -->
            <div id="content">
				<div>
					<jsp:include page="../inc/adminTopbar.jsp"></jsp:include>
				</div>
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
                            <div class="card border-left-yellow shadow h-100 py-2">
                                <div class="card-body">
                                    <div class="row no-gutters align-items-center">
                                        <div class="col mr-2">
                                            <div class="font-weight-bold text-uppercase mb-1 text-yellow">오늘의 방문자 수</div>
                                            <div class="h3 mb-0 font-weight-bold text-gray-600 counter-text" id="visit-date"></div>
                                            <div class="h3 mb-0 font-weight-bold text-gray-800 counter-text" id="visit-count"></div>
                                        </div>
                                        <div class="col-auto">
                                        	<i class="fa-solid fa-box fa-2x text-gray-300"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div style="width: 500px;"></div>
                        <div class="col-xl-5 col-lg-5">
	                        <div class="card shadow mb-4">
	                            <div class="card-header py-3">
	                                <h6 class="m-0 font-weight-bold text-yellow">최근 일주일 가입내역</h6>
	                            </div>
	                            <div class="card-body">
	                            	<div class="table-responsive">
		                                <table class="table table-bordered compact" id="joinList" width="100%" cellspacing="0">
		                                    <thead>
		                                    <tr role="row">
		                                    	<th>가입자 유형</th>
		                                    	<th>이름/상호명</th>
		                                 		<th>아이디/이메일</th>
		                                 		<th>가입일시</th>
		                                    </tr>
		                                    </thead>
		                                    <tbody class="join-tbody"></tbody>
		                                </table>
		                          	</div>
	                            </div>
	                        </div>
                    	</div>
                    	<div class="col-xl-6 col-lg-5">
	                        <div class="card shadow mb-4">
	                            <div class="card-header py-3">
	                                <h6 class="m-0 font-weight-bold text-yellow">신고내역</h6>
	                                <a href="adminReportList" id="report-link">신고 리스트 이동</a>
	                            </div>
	                            <div class="card-body">
	                            	<div class="table-responsive">
		                                <table class="table table-bordered compact" id="reportList" width="100%" cellspacing="0">
		                                    <thead>
			                                    <tr role="row">
			                                    	<th>신고자 아아디</th>
			                                 		<th>신고대상자 아이디</th>
			                                 		<th>신고대상</th>
			                                 		<th>신고일시</th>
			                                 		<th>신고상태</th>
			                                    </tr>
		                                    </thead>
		                                    <tbody class="report-tbody"></tbody>
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
        <span>Copyright &copy; UNIPICK Admin 2025</span>
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

</body>


</html>