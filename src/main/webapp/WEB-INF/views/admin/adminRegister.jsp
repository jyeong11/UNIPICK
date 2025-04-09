<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<!-- font-awesome -->
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/public/fontawesome/all.min.css" />
<script src="${pageContext.request.contextPath }/resources/public/fontawesome/all.min.js"></script>

<!-- default -->
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.1.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/admin/adminMain.js"></script>


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

<!-- jQuery는 한 번만 로드 -->
<script src="${pageContext.request.contextPath }/resources/js/admin/adminRegister.js"></script>

<title>관리자 등록</title>

<style>
    .tag-container {
        display: flex;
        flex-wrap: wrap;
        padding: 5px;
        border: 1px solid #ced4da;
        border-radius: 5px;
        min-height: 38px;
        background-color: #fff;
        margin-top: 5px;
    }
    .tag {
        display: inline-flex;
        align-items: center;
        background-color: #e9ecef;
        border-radius: 15px;
        padding: 5px 10px;
        margin: 3px;
        font-size: 14px;
        color: #495057;
    }
    .tag-close {
        margin-left: 5px;
        cursor: pointer;
        color: #6c757d;
    }
    .tag-close:hover {
        color: #dc3545;
    }
    .dropdown-results {
        position: absolute;
        z-index: 1050;
        background-color: #fff;
        border: 1px solid #ced4da;
        border-radius: 4px;
        box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        max-height: 200px;
        overflow-y: auto;
        width: 100%;
        margin-top: 2px;
        display: none;
    }
    .store-item {
        cursor: pointer;
        padding: 8px 12px;
        display: block;
        width: 100%;
        text-align: left;
        border: none;
        background: none;
        color: #212529;
    }
    .store-item:hover {
        background-color: #f8f9fa;
    }
    .dropdown-item {
        cursor: pointer;
        padding: 8px 12px;
    }
    .input-group {
        position: relative;
        margin-bottom: 0;
    }
    
    footer.sticky-footer {
    top: 2rem !important;
    position: relative !important;
    padding: 2.4rem 0;
}
</style>
</head>
<body id="page-top">

	<div id="wrapper">
		<div>
			<jsp:include page="../inc/adminSidebar.jsp"></jsp:include>
		</div>
	<!-- Page Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">
		<div id="content">
			<div>
				<jsp:include page="../inc/adminTopbar.jsp"></jsp:include>
			</div>
			<!-- Begin Page Content -->
			<section class="section">
				<!-- Content Wrapper -->
				<div id="content-wrapper" class="d-flex flex-column">
					<!-- Main Content -->
					<div id="content">
						<!-- Begin Page Content -->
						<div class="container-fluid">
							<!-- Page Heading -->
							<div
								class="d-sm-flex align-items-center justify-content-center mb-4">
								<h5 class="mb-0 text-gray-800" id="todayText"></h5>
							</div>

							<!-- Content Row 메인 상단 -->
							<div class="row">
								<div class="container mt-5">
									<div class="col-md-8 offset-md-2">
										<div class="card">
											<div class="card-header py-3">
												<h3 class="mb-0">관리자 등록</h3>
											</div>
											<div class="card-body">
												<form id="adminRegisterForm">
													<div class="mb-3">
														<label for="adm_id" class="form-label">관리자 ID</label> <input
															type="text" class="form-control" id="adm_id"
															name="adm_id" autocomplete="username" required>
													</div>
													<div class="mb-3">
														<label for="adm_pw" class="form-label">비밀번호</label> <input
															type="password" class="form-control" id="adm_pw"
															name="adm_pw" autocomplete="new-password" required>
													</div>
													<div class="mb-3">
														<label for="adm_nm" class="form-label">관리자명</label> <input
															type="text" class="form-control" id="adm_nm"
															name="adm_nm" autocomplete="name" required>
													</div>
													<div class="mb-3">
														<label for="adm_sl" class="form-label">보안등급</label> <select
															class="form-select" id="adm_sl" name="adm_sl" required>
															<option value="1">총괄관리자</option>
															<option value="2">스토어관리자</option>
														</select>
													</div>
													<div class="mb-3">
														<label class="form-label">관리 스토어</label>
														<div class="input-group">
															<input type="text" class="form-control" id="storeSearch"
																placeholder="스토어명 검색">
															<button class="btn btn-outline-secondary" type="button"
																id="searchBtn">검색</button>
														</div>
														<div id="storeDropdown" class="dropdown-results"></div>
														<div class="tag-container mt-2" id="selectedStores"></div>
													</div>
													<div class="text-center">
														<button type="submit" class="btn btn-primary">등록하기</button>
														<a href="adminList" class="btn btn-secondary">목록으로</a>
													</div>
												</form>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- /.row -->
				</div>
				<!-- /.container-fluid -->
	
			</section>
		</div>
		<!-- End of Main Content -->
							<footer class="sticky-footer bg-white">
			<div class="container my-auto">
				<div class="copyright text-center my-auto">
					<span>Copyright &copy; UNIPICK Admin 2025</span>
				</div>
			</div>
		</footer>
</div>
		<!-- End of Footer -->
	</div>
	<!-- End of Content Wrapper -->
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