<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
<link href="${pageContext.request.contextPath }/resources/css/seller/product.css" rel="stylesheet">

<!-- TOAST UI -->
<link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />
<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
<link rel="stylesheet" href="https://uicdn.toast.com/tui-color-picker/latest/tui-color-picker.min.css" />
<link rel="stylesheet" href="https://uicdn.toast.com/editor-plugin-color-syntax/latest/toastui-editor-plugin-color-syntax.min.css" />	
<script src="https://uicdn.toast.com/tui-color-picker/latest/tui-color-picker.min.js"></script>
<script src="https://uicdn.toast.com/editor-plugin-color-syntax/latest/toastui-editor-plugin-color-syntax.min.js"></script>

<script src="${pageContext.request.contextPath }/resources/js/seller/productRegister.js"></script>
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
						<form action="productInsert" id="productRegist" method="post" enctype="multipart/form-data">
							<section class="item-regi-img">
								<div class="card_head"><h2 class="item-regi-name">상품이미지</h2>
								<h2 class="item-thumb-description">첫번째 상품 이미지는 대표썸네일로 등록됩니다.</h2></div>
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
							</section>
							<section class="item-regi-section">
								<h2 class="item-regi-name">상품명</h2>
								<div class="item-regi-box">
									<input type="text" name="product_title" class="item-regi-title-text" id="item-regi-title-text">
								</div>
								<h6 class="item-regi-name-byte" id="item-regi-name-byte">(0 / 50)</h6>
							</section>
							<section class="item-regi-section">
								<h2 class="item-regi-name">상품설명</h2>
								<!-- toast ui editor : 에디터 옵션 설정 필요 -->
									<div id="editor">
									</div>
								<h6 class="item-regi-description-byte" id="item-regi-description-byte">(0 / 2000)토스트UI가져와야하나 고민때려야함</h6>
							</section>
							<section class="item-regi-category">
								<h6 class="item-regi-category-name">카테고리</h6>
								<select class="item-regi-category-box" name="product_category" id="product_category"></select>
								<select class="item-regi-category-box" name="product_category1" id="product_category1"></select>
								<select class="item-regi-category-box" name="product_category2" id="product_category2"></select>
							</section>
							<section class="item-regi-price">
								<h6 class="item-regi-name">상품 가격 설정</h6>
								<div class="item-regi-price-box">
									<div class="item-regi-price-number">
										<input type="number" class="shipping-fee-price" id="shipping-fee-price" name="product_shipping_fee" placeholder="정가를 입력해주세요.">
										<div><input type="number" class="item-price" name="product_price" id="product_price" placeholder="판매가를 입력해주세요."></div>
										<input type="hidden" name="product_discount_status" value="0">
									</div>
								</div>
							</section>
							<section class="item-regi-trade-adr">
								<h6 class="item-regi-name">배송 설정</h6>
								<select class="item-regi-category-box" name="product_category" id="product_delivery"></select>
								<select class="item-regi-category-box" name="product_category1" id="product_delivery1"></select>
								<select class="item-regi-category-box" name="product_category2" id="product_delivery2"></select>	
							</section>
							<section class="item-regi-price">
								<h6 class="item-regi-name">재고 설정</h6>
								<div class="item-regi-price-box">
									<div class="item-regi-price-number">
										<select class="item-regi-category-box" name="product_category" id="product_category"></select>
										<input type="number" class="shipping-fee-price" id="shipping-fee-price" name="product_shipping_fee" placeholder="재고번호를 입력해주세요.">
									</div>
								</div>
							</section>
							<section class="item-regi-price">
								<h6 class="item-regi-name">색상 설정</h6>
								<div class="item-regi-price-box">
									<div class="item-regi-price-number">
									<select class="item-regi-category-box" name="product_category" id="product_category"></select>
									<input type="number" class="shipping-fee-price" id="shipping-fee-price" name="product_shipping_fee" placeholder="재고번호를 입력해주세요.">
									</div>
								</div>
							</section>
							<section class="item-regi-price">
								<h6 class="item-regi-name">사이즈 설정</h6>
								<div class="item-regi-price-box">
									<div class="item-regi-price-number">
										<select class="item-regi-category-box" name="product_category" id="product_category"></select>
										<input type="number" class="shipping-fee-price" id="shipping-fee-price" name="product_shipping_fee" placeholder="재고번호를 입력해주세요.">
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

<!-- 	<div><textarea class="item-regi-description-text" id="item-regi-description-text" name="product_intro"></textarea> -->
<!-- 								</div> -->

<!-- --------------------------------------------------------------- -->
<script type="text/javascript">
const { colorSyntax } = toastui.Editor.plugin;
const noteditor = new toastui.Editor({
	el : document.querySelector('#editor'),
	height : '300px',
	initialEditType : 'wysiwyg', // 최초로 보여줄 에디터 타입 (markdown || wysiwyg)
	initialValue : '', // 내용의 초기 값으로, 반드시 마크다운 문자열 형태여야 함
	previewStyle : 'tab', // 올바른 값과 콤마 추가
	plugins: [colorSyntax],
	toolbarItems : [
	    ['heading', 'bold', 'italic', 'strike'],
	    ['hr', 'quote'],
	    ['ul', 'ol', 'task'],
	    ['code', 'codeblock'],
	    ['image'],
	  ],
	  hooks: {
		    addImageBlobHook: async (blob, callback) => {
		        const formData = new FormData();
		        formData.append('image', blob);

		        try {
		            const response = await fetch('/upload', {  // 이미지 업로드 API 엔드포인트
		                method: 'POST',
		                body: formData
		            });

		            const result = await response.json();
		            callback(result.url, '이미지 설명');  // 업로드된 이미지 URL을 에디터에 삽입
		        } catch (error) {
		            console.error('이미지 업로드 실패:', error);
		            alert('이미지 업로드 중 오류가 발생했습니다.');
		        }
		    }
		}
	});
document.querySelector('.toastui-editor-defaultUI').style.width = '950px';
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