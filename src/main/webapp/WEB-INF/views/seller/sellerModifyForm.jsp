<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>UNIPICK</title>
<!-- default -->
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.1.js"></script>

<!-- contextPath 변수 추가 -->
<script>
    const contextPath = "${pageContext.request.contextPath}";
</script>

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
<link href="${pageContext.request.contextPath }/resources/css/seller/sellerModifyForm.css" rel="stylesheet">

<script src="${pageContext.request.contextPath }/resources/js/seller/sellerModifyForm.js"></script>

<link rel="icon" href="${pageContext.request.contextPath }/resources/images/favicon.png">

<style>
#input-group1{
	 display: flex;
	 justify-content: flex-end;
}

</style>

</head>
<body id="page-top">
	<div id="wrapper">
		<div><jsp:include page="../inc/sellerSidebar.jsp"></jsp:include></div>
		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">
			<!-- Main Content -->
			<div id="content">
			      	<div>
					<jsp:include page="../inc/sellerTopbar.jsp"></jsp:include>
				</div>
				<!-- Topbar -->
<!-- 				<nav -->
<!-- 					class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow"> -->
<!-- 					Sidebar Toggle (Mobile Topbar) -->
<!-- 					<button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3"> -->
<!-- 						<i class="fa fa-bars"></i> -->
<!-- 					</button> -->
<!-- 					Title -->
<!-- 					<h4 class="m-0 text-gray-900">마이페이지</h4> -->
<!-- 					Topbar Navbar -->
<!-- 					<ul class="navbar-nav ml-auto"> -->
<!-- 						<li class="nav-item dropdown no-arrow"> -->
<!-- 							<a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> -->
<!-- 							<span class="mr-2 d-none d-lg-inline text-gray-600 small">관리자</span> -->
<!-- 								<img class="img-profile rounded-circle" src="../../resources/adm/img/admin_profile.png"></a> -->
<!-- 								Dropdown - User Information -->
<!-- 							<div class="dropdown-menu dropdown-menu-right shadow animated--grow-in" aria-labelledby="userDropdown"> -->
<!-- 								<a class="dropdown-item" href="/." target="_blank"> <i class="fas fa-list fa-sm fa-fw mr-2 text-gray-400"></i>사용자 화면</a> -->
<!-- 								<a class="dropdown-item" href="AdmLogList"> <i class="fas fa-list fa-sm fa-fw mr-2 text-gray-400"></i>로그 기록</a> -->
<!-- 								<div class="dropdown-divider"></div> -->
<!-- 								<a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal"> <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>로그아웃</a> -->
<!-- 							</div> -->
<!-- 						</li> -->
<!-- 					</ul> -->
<!-- 				</nav> -->
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
			</div>
			<!-- End of Topbar -->
			<!-- Begin Page Content -->
			<div class="container-fluid">
				<div class="row">
					<div class="col-lg-12">
						<div class="card shadow mb-4">
							<div class="card-header py-3">
								<h5 class="m-0 font-weight-bold text-primary">마이페이지</h5>
							</div>
							<div class="card-body">
								<section class="item-regi">
									<form id="storeSignupForm" action="joinSucess" method="post" enctype="multipart/form-data">
									<div class="content-tilte">비밀번호 수정</div>
									<div class="input-group">
										<label for="storeId">아이디</label>
											<input type="text" id="storeId" name="storeId" placeholder="6자리 이상 입력해주세요" readonly>
									</div>
									<div class="input-group">
										<label for="storePw">비밀번호</label>
											<input type="password" id="storePw" name="storePw" placeholder="대문자, 특수문자 포함 6자리 이상 입력해주세요">
									</div>
									<hr>
									<div class="content-tilte">쇼핑몰 정보 입력</div>
									<div class="input-group">
									    <label for="storePp">스토어 프로필</label>
									    <input type="file" id="storePp" name="storePp" accept="image/*">
									    <div class="image-preview">
									        <img id="previewStorePp" src="" alt="프로필 이미지 미리보기" style="max-width: 150px; display: none;">
									    </div>
									    <input type="hidden" id="existingStorePp" value="${storePpPath}">
									    <button type="button" id="removeStorePp">삭제</button>
									</div>
									
									<div class="input-group">
									    <label for="storeBp">스토어 배경</label>
									    <input type="file" id="storeBp" name="storeBp" accept="image/*">
									    <div class="image-preview">
									        <img id="previewStoreBp" src="" alt="배경 이미지 미리보기" style="max-width: 150px; display: none;">
									    </div>
									    <input type="hidden" id="existingStoreBp" value="${storeBpPath}">
									    <button type="button" id="removeStoreBp">삭제</button>
									</div>
									<div class="input-group">
										<label for="storeNm">쇼핑몰 이름</label>
										<input type="text" id="storeNm" name="storeNm">
									</div>

									<div class="input-group">
										<label for="ceoNm">대표자명</label>
										<input type="text" id="ceoNm" name="ceoNm">
									</div>

									<div class="input-group">
										<label for="brn">사업자등록번호</label>
										<input type="text" id="brn" name="brn" readOnly>
									</div>
									
									<div class="input-group">
										<label for="storead">사업장주소</label>
										<input type="text" id="storead" name="storead">
									</div>
									
<!-- 									<div class="input-group"> -->
<!-- 										<label for="businessLicense">사업자 등록증</label> -->
<!-- 										<input type="file" id="businessLicense" name="businessLicense"> -->
<!-- 									</div> -->

									<div class="input-group">
										<label for="storeNumber">고객센터 번호</label>
										<input type="text" id="storeNumber" name="storeNumber">
									</div>
									
									<hr>
									<div class="content-tilte">쇼핑몰 담당자 정보 입력</div>
									<div class="input-group">
										<label for="phNm">이름</label>
										<input type="text" id="phNm" name="phNm">
									</div>

									<div class="input-group">
										<label for="phNumber">휴대전화</label>
										<input type="text" id="phNumber" name="phNumber" placeholder="010-xxxx-xxxx">
									</div>
									<div class="input-group" id="input-group1">
										<button type=button id="sellermodify">수정하기</button>
										<button type=submit id="sellerWithdraw">탈퇴하기</button>
									</div>
								</form>
								</section>
							</div>
						</div>
					</div>
				</div>
				<!-- Footer -->
				<jsp:include page="../inc/sellerfooter.jsp"></jsp:include>
				<!-- End of Footer -->
			</div>
			<!-- End of Page Wrapper -->
		</div>
	</div>
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

    
    </body>
    </html>