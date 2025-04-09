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
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&family=Nunito:wght@200..1000&display=swap" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/public/css/sb-admin-2.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/public/css/adm.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/public/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/public/vendor/datatables/datatables.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath }/resources/css/admin/cmcd.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/public.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/admin/adminPublic.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/admin/adminPublic2.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/admin/myPage.css" rel="stylesheet" type="text/css">


<!-- script -->
<script src="${pageContext.request.contextPath }/resources/js/admin/myPage.js"></script>
<!-- Favicon -->
<link rel="icon" href="${pageContext.request.contextPath }/resources/images/favicon.png">

</head>
<body id="page-top">
	<!-- Page Wrapper -->
	<div id="wrapper">
		<div>
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
	            <div class="card shadow mb-4">
					<div class="card-header py-3">
						<h6 class="m-0 font-weight-bold">마이페이지</h6>
					</div>
                <!-- Begin Page Content -->
                	<table class="table table-bordered dataTable no-footer info-table" width="100%" cellspacing="0" role="grid" style="margin-left: 0px; width: 1591px;">
	                    	<tr role="row">
		                        <th class="sorting_disabled" rowspan="1" colspan="1">아이디</th>
		                        <td class="read-text" id="id"></td>
	                        </tr>
	                        <tr role="row">
		                        <th class="sorting_disabled" rowspan="1" colspan="1">비밀번호</th>
		                        <td>
		                        	<input type="password" id="pw" placeholder="비밀번호">
		                        	<br>
		                        	<span class="caution">※ 비밀번호에 제한은 없지만 보안을 위해 되도록 복잡하게 설정해 주세요.</span>
		                        </td>
	                        </tr>
	                        <tr role="row">
		                        <th class="sorting_disabled" rowspan="1" colspan="1">비밀번호 확인</th>
		                        <td><input type="password" id="pw-check" placeholder="비밀번호 확인"></td>
	                        </tr>
	                        <tr role="row">
		                        <th class="sorting_disabled" rowspan="1" colspan="1">관리자 등급</th>
		                        <td class="read-text" id="nm"></td>
	                        </tr>
                    </table>
					<div class="btn-div">
						<button id="edit-btn">수정</button>
						<button id="cancel-btn">취소</button>
					</div>
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