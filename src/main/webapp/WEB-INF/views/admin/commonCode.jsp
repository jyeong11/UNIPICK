<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>UNIPICK</title>


<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script>

<!-- default -->
<script
	src="${pageContext.request.contextPath }/resources/js/jquery-3.7.1.js"></script>

<!-- font-awesome -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath }/resources/public/fontawesome/all.min.css" />
<script
	src="${pageContext.request.contextPath }/resources/public/fontawesome/all.min.js"></script>

<!-- CSS for Page -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&family=Nunito:wght@200..1000&display=swap"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath }/resources/public/css/sb-admin-2.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath }/resources/public/css/adm.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath }/resources/public/vendor/datatables/dataTables.bootstrap4.min.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath }/resources/public/vendor/datatables/datatables.min.css"
	rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/css/admin/cmcd.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/public.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/admin/adminPublic.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/admin/adminPublic2.css" rel="stylesheet" type="text/css">

<!-- script -->
<script src="${pageContext.request.contextPath }/resources/js/admin/commonCode.js"></script>
<!-- Favicon -->
<link rel="icon" href="${pageContext.request.contextPath }/resources/images/favicon.png">


</head>
<body id="page-top">
	<!-- Page Wrapper -->
	<div id="wrapper">
		<div>
			<jsp:include page="../inc/adminSidebar.jsp"></jsp:include>
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
            <div>
            	<jsp:include page="../inc/adminTopbar.jsp"></jsp:include>
            </div>
                <!-- Begin Page Content -->
				<section class="section" id="left-session">
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold" id="subTitle">공통코드</h6>
						</div>
						<div class="card-body"  id="body-card">
								<div class="common-top-div">
									<div class="top-btn">
										<input class="btn btn_main_color"
                                        data-bs-toggle="modal" data-bs-target="#exampleModal"
                                        id="btnModal" type="button"value="등록">
									</div>
									<div class="search-div">
										<div>
											<select id="searchKind">
												<option value="option1">공통코드</option>
												<option value="option2">코드명</option>
											</select>
										</div>
										<div>
											<input type="text" id="codeSearchWord" placeholder="검색어로 조회">
										</div>
										<div>
											<button id="codeSearch" class="btn btn-primary mb-3 btn_main_color" type="button">조회</button>
										</div>
									</div>
								</div>
								<div class="table-responsive">
									<div id="commonTable">
										<table id="dataTable" class="table table-bordered">
											<thead>
												<tr class="project_table_tr">
													<th>순번</th>
													<th>공통코드</th>
													<th>코드명</th>
													<th>사용여부</th>
												</tr>
											</thead>
											<tbody id="commonTableBody"></tbody>
										</table>
									</div>
								</div>
							</div>
							<!-- 						조회버튼 클릭시 모달창 뜸 -->
							<div class="modal fade" id="exampleModal" tabindex="-1"
								role="dialog" aria-labelledby="exampleModalLabel"
								aria-hidden="true">
								<div id="modal" class="modal-dialog modal-xl"
									role="document">
									<div class="modal-content">
										<div class="modal-header">공통코드 등록</div>
										<div class="modal-body">
											<div id="modal-con"></div>
										</div>
									</div>
								</div>
							</div>
						</div>
				</section>
                <!-- /.container-fluid -->
            </div>
            <!-- End of Main Content -->
            <!-- Footer -->
            <footer class="sticky-footer bg-white">
                <div class="container my-auto">
    <div class="copyright text-center my-auto">
        <span>Copyright © UNIPICK Admin 2025</span>
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
        <svg class="svg-inline--fa fa-angle-up" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="angle-up" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" data-fa-i2svg=""><path fill="currentColor" d="M201.4 137.4c12.5-12.5 32.8-12.5 45.3 0l160 160c12.5 12.5 12.5 32.8 0 45.3s-32.8 12.5-45.3 0L224 205.3 86.6 342.6c-12.5 12.5-32.8 12.5-45.3 0s-12.5-32.8 0-45.3l160-160z"></path></svg><!-- <i class="fas fa-angle-up"></i> Font Awesome fontawesome.com -->
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

</body>


</html>