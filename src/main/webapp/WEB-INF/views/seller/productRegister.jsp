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
	
	
			<!-- Content -->
			<div class="container-fluid">
				<div class="row">
					<div class="col-lg-12">
						<div class="card shadow mb-4">
							<div class="card-header py-3">
								<h5 class="m-0 font-weight-bold text-primary">상품 등록</h5>
							</div>
							<div class="card-body">
						<section class="item-regi">
					<div>
						<form action="ProductRegist" id="productRegist" method="post" enctype="multipart/form-data">
							<section class="item-regi-img">
								<h2 class="item-regi-name">상품이미지</h2>
								<div class="item-thumb">
									<button class="item-thumb-upload" type="button">
										<img src="/resources/img/product-thumb-no.jpg" id="item-thumb-preview1">
									</button>
									<input type="file" class="item-thumb-upload-btn" id="item-thumb-upload-btn1" name="pic1">
								</div>
								<div class="item-thumb">
									<button class="item-thumb-upload" type="button">
										<img src="/resources/img/product-thumb-no.jpg" id="item-thumb-preview2">
									</button>
									<input type="file" class="item-thumb-upload-btn" id="item-thumb-upload-btn2" name="pic2">
								</div>
								<div class="item-thumb">
									<button class="item-thumb-upload" type="button">
										<img src="/resources/img/product-thumb-no.jpg" id="item-thumb-preview3">
									</button>
									<input type="file" class="item-thumb-upload-btn" id="item-thumb-upload-btn3" name="pic3">
								</div>
								<div class="item-thumb">
									<button class="item-thumb-upload" type="button">
										<img src="/resources/img/product-thumb-no.jpg" id="item-thumb-preview4">
									</button>
									<input type="file" class="item-thumb-upload-btn" id="item-thumb-upload-btn3" name="pic4">
								</div>
								<div class="item-thumb">
									<button class="item-thumb-upload" type="button">
										<img src="/resources/img/product-thumb-no.jpg" id="item-thumb-preview5">
									</button>
									<input type="file" class="item-thumb-upload-btn" id="item-thumb-upload-btn3" name="pic5">
								</div>
								<div class="item-thumb">
									<button class="item-thumb-upload" type="button">
										<img src="/resources/img/product-thumb-no.jpg" id="item-thumb-preview6">
									</button>
									<input type="file" class="item-thumb-upload-btn" id="item-thumb-upload-btn3" name="pic6">
								</div>
								<div class="item-thumb">
									<button class="item-thumb-upload" type="button">
										<img src="/resources/img/product-thumb-no.jpg" id="item-thumb-preview7">
									</button>
									<input type="file" class="item-thumb-upload-btn" id="item-thumb-upload-btn3" name="pic7">
								</div>
								<div class="item-thumb">
									<button class="item-thumb-upload" type="button">
										<img src="/resources/img/product-thumb-no.jpg" id="item-thumb-preview8">
									</button>
									<input type="file" class="item-thumb-upload-btn" id="item-thumb-upload-btn3" name="pic8">
								</div>
								<div class="item-thumb">
									<button class="item-thumb-upload" type="button">
										<img src="/resources/img/product-thumb-no.jpg" id="item-thumb-preview9">
									</button>
									<input type="file" class="item-thumb-upload-btn" id="item-thumb-upload-btn3" name="pic9">
								</div>
								<div class="item-thumb">
									<button class="item-thumb-upload" type="button">
										<img src="/resources/img/product-thumb-no.jpg" id="item-thumb-preview10">
									</button>
									<input type="file" class="item-thumb-upload-btn" id="item-thumb-upload-btn3" name="pic10">
								</div>
								<h2 class="item-thumb-description">첫번째 상품 이미지는 썸네일로 보여져요.</h2>
							</section>
							<section class="item-regi-section">
								<h2 class="item-regi-name">상품명</h2>
								<div class="item-regi-box">
									<input type="text" name="product_title" class="item-regi-title-text" id="item-regi-title-text">
									<a href="ProductBanedItem" target='_blank'>거래금지 품목 보기</a>
								</div>
								<h6 class="item-regi-name-byte" id="item-regi-name-byte">(0 / 100)</h6>
							</section>
							<section class="item-regi-section">
								<h2 class="item-regi-name">상품설명</h2>
									<div><textarea class="item-regi-description-text" id="item-regi-description-text" name="product_intro"></textarea>
								</div>
								<h6 class="item-regi-description-byte" id="item-regi-description-byte">(0 / 2000)</h6>
							</section>
							<section class="item-regi-category">
								<h6 class="item-regi-category-name">카테고리 & 태그</h6>
								<select class="item-regi-category-box" name="product_category" id="product_category">
								</select>
							</section>
							<section class="item-regi-trade-adr">
								<h6 class="item-regi-name">직거래 주소 설정</h6>
								<div class="item-regi-trade-active">
									<label><input type="radio" name="trade-adr-val" id="trade-enable" value="1" checked>직거래 가능</label>
									<label><input type="radio" name="trade-adr-val" id="trade-disable" value="0">직거래 불가능</label>
									<div class="item-trade-adr-box" id="item-trade-adr-box">
										<div>
											<input type="text" class="item-trade-adr-sub" id="item-trade-adr-sub" name="product_trade_adr1" readonly>
											<input type="button" class="item-trade-adr-search" value="주소검색" onclick="searchAdr()">
										</div>
									</div>
								</div>	
							</section>
							<section class="item-regi-price">
								<h6 class="item-regi-name">상품 가격 설정</h6>
								<div class="item-regi-price-box">
									<label><input type="radio" name="shipping-fee" id="shipping-fee-enable"  value="0" checked>택배비 미포함</label>
									<label><input type="radio" name="shipping-fee" id="shipping-fee-disable" value="1">택배비 포함</label>
									<div class="item-regi-price-number">
										<input type="number" class="shipping-fee-price" id="shipping-fee-price" name="product_shipping_fee" placeholder="택배비를 입력해주세요.">
										<div><input type="number" class="item-price" name="product_price" id="product_price" placeholder="상품 가격을 입력해주세요."></div>
										<label class="item-discount-box"><input type="checkbox" class="item-discount" name="product_discount_status" value="1">가격 제안 가능</label>
										<input type="hidden" name="product_discount_status" value="0">
									</div>
								</div>
							</section>
							<div class="item-regi-submit-group">
								<input type="button" class="item-backpage" onclick="history.back()" value="뒤로 가기">
								<input type="submit" class="item-submit" value="상품 등록">
							</div>
						</form>
					</div>
				</section>
		
							
							</div>
						</div>
					</div>
				</div><!-- /.container-fluid -->
			</div><!-- End of Content -->
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