<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
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

<!-- CSS for Page -->
<link href="${pageContext.request.contextPath }/resources/public/css/sb-admin-2.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/public/css/adm.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/public/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/public/vendor/datatables/datatables.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/css/seller/productRegister.css" rel="stylesheet">
</head>
<body id="page-top">
<div id="wrapper">
<div><jsp:include page="../inc/sellerSidebar.jsp"></jsp:include></div>
<!-- Content Wrapper -->
<div id="content-wrapper" class="d-flex flex-column">
	<!-- Main Content -->
     <div id="content">               
		<!-- Topbar -->
				<nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">
					<!-- Sidebar Toggle (Mobile Topbar) -->
					<button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3"><i class="fa fa-bars"></i></button>
					<!-- Title -->
					<h4 class="m-0 text-gray-900">판매자 대시보드</h4>
					<!-- Topbar Navbar -->
					<ul class="navbar-nav ml-auto">
						<li class="nav-item dropdown no-arrow"><a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true"aria-expanded="false">
							<span class="mr-2 d-none d-lg-inline text-gray-600 small">관리자</span>
							 <img class="img-profile rounded-circle" src="../../resources/adm/img/admin_profile.png"></a>
							 <!-- Dropdown - User Information -->
							<div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown">
								<a class="dropdown-item" href="/." target="_blank">
								<i class="fas fa-list fa-sm fa-fw mr-2 text-gray-400"></i>사용자 화면</a>
								<a class="dropdown-item" href="AdmLogList">
								<i class="fas fa-list fa-sm fa-fw mr-2 text-gray-400"></i>로그 기록</a>
								<div class="dropdown-divider"></div>
								<a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal">
								<i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>로그아웃</a>
							</div>
						</li>
					</ul>
				</nav>
				<!-- Logout Modal-->
				<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
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
	</div><!-- End of Topbar -->
		        <!-- Begin Page Content -->
                <div class="container-fluid">
					<div class="row">
                        <div class="col-lg-12">
                            <div class="card shadow mb-4">
                                <div class="card-header py-3">
                                    <h5 class="m-0 font-weight-bold text-primary">상품 목록</h5>
                                </div>
                                <div class="card-body">
                                	<div class="search-wrap border">
                                		<section class="d-flex search-inner">
	                                		<div class="col-5 px-4 search-box">
			                                	<div class="search-ttl">상태별</div>
											    <div class="category-filter input-group">
											        <div class="form-check">
													    <input class="form-check-input" id="reset" type="radio" name="status"  value="" checked>
													    <label class="form-check-label" for="reset">전체</label>
													</div>
											        <div class="form-check ml-3">
													    <input class="form-check-input" id="status0" type="radio" name="status" value="0">
													    <label class="form-check-label" for="status0">판매중</label>
													</div>
											        <div class="form-check ml-3">
													    <input class="form-check-input" id="status1" type="radio" name="status" value="1">
													    <label class="form-check-label" for="status1">거래중</label>
													</div>
													<div class="form-check ml-3">
													    <input class="form-check-input" id="status2" type="radio" name="status" value="2">
													    <label class="form-check-label" for="status2">예약중</label>
													</div>
													<div class="form-check ml-3">
													    <input class="form-check-input" id="status3" type="radio" name="status" value="3">
													    <label class="form-check-label" for="status3">거래완료</label>
													</div>
													<div class="form-check ml-3">
													    <input class="form-check-input" id="status4" type="radio" name="status" value="4">
													    <label class="form-check-label" for="status4">신고처리</label>
													</div>
												</div>
										    </div>
										    <div class="col-3 px-4 search-box">
			                                	<div class="search-ttl">기간별</div>
												<div class="input-group align-items-center justify-content-center schDate-wrap">
													<input type="text" class="form-control rounded-sm mr-2" placeholder="날짜 선택" value="" name="schDate" id="schDate"  autocomplete="off"/>
													<button class="btn btn-primary" id="searchDateBtn" type="button"><i class="fa-solid fa-magnifying-glass"></i></button>
													<button class="btn btn-success ml-2" id="initDateBtn" type="button"><i class="fa-solid fa-rotate"></i></button>
												</div>
										    </div>
										    <div class="col-4 px-4 search-box">
						                        <div class="input-group">
						                            <input type="text" id="searchKeyword" class="form-control bg-light border small" name="keyword_search" placeholder="회원ID, 상품명, 상품소개, 상태 검색" aria-label="Search" aria-describedby="basic-addon2">
						                            <div class="input-group-append">
						                                <button class="btn btn-primary" id="searchBtn" type="button">검색</button>
						                            </div>
						                        </div>
					                        </div>
									   	</section>
									</div>
                                	<div class="table-responsive">
		                                <table class="table table-bordered compact" id="productList" width="100%" cellspacing="0">
		                                    <thead></thead>
		                                    <tbody></tbody>
		                                </table>
		                          	</div>
                                </div>
                            </div>
                        </div>
                     </div>
                <!-- /.container-fluid -->
            </div><!-- End of Main Content -->
		<!-- Footer -->
		<footer class="sticky-footer bg-white">
			<div class="container my-auto">
				<div class="copyright text-center my-auto">
					<span>Copyright &copy; UNIPICK SELLER 2025</span>
				</div>
			</div>
		</footer><!-- End of Footer -->
	</div><!-- End of Page Wrapper -->
</div>

<!-- --------------------------------------------------------------- -->
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
<script>
document.addEventListener("DOMContentLoaded", function(){
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
</body>
</html>