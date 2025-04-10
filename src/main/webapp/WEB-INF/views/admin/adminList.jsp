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
<link href="${pageContext.request.contextPath }/resources/css/admin/admProductList.css" rel="stylesheet" type="text/css">
<!-- Favicon -->
<link rel="icon" href="${pageContext.request.contextPath }/resources/images/favicon.png">



<script src="${pageContext.request.contextPath }/resources/js/admin/adminList.js"></script>

    <title>관리자 리스트</title>

     <style>
        .tag {
            display: inline-block;
            background-color: #f0f0f0;
            border-radius: 15px;
            padding: 3px 10px;
            margin: 2px;
            font-size: 0.9em;
        }
        .tag-container {
            margin-top: 5px;
        }
        .modal-dialog {
            max-width: 500px;
        }
    </style>
</head>
<body id="page-top">
    <!-- Page Wrapper -->
	<div id="wrapper">
		<div>
			<jsp:include page="../inc/adminSidebar.jsp"></jsp:include>
		</div>

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
					<div
						class="d-sm-flex align-items-center justify-content-center mb-4">
						<h5 class="mb-0 text-gray-800" id="todayText"></h5>
					</div>

					<!-- Content Row 메인 상단 -->
					<div class="row">
						<div class="container mt-5">
							<div class="row">
								<div class="col-md-8 offset-md-2">
									<div class="card">
										<div class="card-header py-3">
											<!-- <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">  -->
											<h3 class="mb-0">관리자 리스트</h3>
											<a href="adminRegister" class="btn btn-light">관리자 등록</a>
										</div>
										<div class="card-body"  id="body-card">
											<div class="table-responsive">
												<table class="table table-striped table-hover">
													<thead>
														<tr>
															<th>번호</th>
															<th>관리자 ID</th>
															<th>관리자명</th>
															<th>관리 스토어</th>
															<th>권한</th>
															<th>관리</th>
														</tr>
													</thead>
													<tbody id="adminListBody">
														<!-- 관리자 목록이 여기에 표시됩니다 -->
													</tbody>
												</table>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>

						<!-- 스토어 관리 모달 -->
						<div class="modal fade" id="manageStoresModal" tabindex="-1"
							aria-hidden="true">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
										<h5 class="modal-title">관리 스토어 수정</h5>
										<button type="button" class="close" data-dismiss="modal" aria-label="Close">
											<span aria-hidden="true">&times;</span>
										</button>
									</div>
									<div class="modal-body">
										<input type="hidden" id="modalAdminId">
										<div class="mb-3">
											<label class="form-label">현재 관리 스토어</label>
											<div id="currentStores" class="tag-container"></div>
										</div>
										<div class="mb-3">
											<label class="form-label">스토어 추가</label>
											<div class="input-group">
												<input type="text" class="form-control"
													id="storeSearchModal" placeholder="스토어명 검색">
												<button class="btn btn-outline-secondary" type="button"
													id="searchBtnModal">검색</button>
											</div>
											<div class="dropdown-menu w-100" id="storeDropdownModal"></div>
										</div>
									</div>
									<div class="modal-footer">
										<button type="button" class="btn btn-primary"
											id="saveStoresBtn">저장</button>
										<button type="button" class="btn btn-secondary"
											data-dismiss="modal">취소</button>
									</div>
								</div>
							</div>
						</div>

						<!-- 권한 변경 모달 -->
						<div class="modal fade" id="changeRoleModal" tabindex="-1"
							aria-hidden="true">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
										<h5 class="modal-title">관리자 권한 변경</h5>
										<button type="button" class="close" data-dismiss="modal" aria-label="Close">
											<span aria-hidden="true">&times;</span>
										</button>
									</div>
									<div class="modal-body">
										<input type="hidden" id="roleAdminId">
										<div class="mb-3">
											<label for="adminRole" class="form-label">권한 선택</label> <select
												class="form-select" id="adminRole">
												<option value="1">총괄관리자</option>
												<option value="2">스토어관리자</option>
											</select>
										</div>
									</div>
									<div class="modal-footer">
										<button type="button" class="btn btn-primary" id="saveRoleBtn">저장</button>
										<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>

			</div>
			<!-- /.row -->
	<!-- Footer -->
	<footer class="sticky-footer bg-white">
		<div class="container my-auto">
			<div class="copyright text-center my-auto">
				<span>Copyright &copy; UNIPICK Admin 2025</span>
			</div>
		</div>
	</footer>
		</div>
		<!-- /.container-fluid -->

	</div>
	<!-- End of Main Content -->


    
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