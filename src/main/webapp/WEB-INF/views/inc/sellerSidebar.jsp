<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>UNIPICK</title>

    <!-- Page Wrapper -->
    <div id="wrapper">

		<!-- Sidebar -->
       	
<!-- Sidebar -->
<ul class="navbar-nav bg-gradient-dark sidebar sidebar-dark accordion" id="accordionSidebar">
    <a class="sidebar-brand d-flex align-items-center justify-content-center" href="AdmMain">UNIPICK ADMIN</a>
    <hr class="sidebar-divider my-0">
    <li class="nav-item">
        <a class="nav-link" href="AdmMain"><i class="fa-solid fa-house"></i> <span>Main</span></a>
    </li>
    <hr class="sidebar-divider">
    <div class="sidebar-heading">상품관리</div>
    <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#menu01" aria-expanded="true" aria-controls="menu01">
            <i class="fas fa-fw fa-cog"></i> <span>상품관리</span>
        </a>
        <div id="menu01" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
            <div class="bg-white py-2 collapse-inner rounded">
            	<h6 class="collapse-header">상품관리</h6>
            	<a class="collapse-item" href="prdRegister">상품등록</a>
                <a class="collapse-item" href="prdList">상품조회</a>
            </div>
        </div>
    </li>
    <hr class="sidebar-divider">
    <div class="sidebar-heading">Site Setting</div>
    <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#menu02" aria-expanded="true" aria-controls="menu02">
        	<i class="fa-solid fa-user"></i> <span>주문관리</span>
        </a>
        <div id="menu02" class="collapse" aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
            <div class="bg-white py-2 collapse-inner rounded">
            	<h6 class="collapse-header">주문관리</h6>
                <a class="collapse-item" href="#" data-sub-page="#">구매자회원</a>
                <a class="collapse-item" href="#" data-sub-page="#">판매자회원</a>
                <a class="collapse-item" href="#" data-sub-page="#">관리자</a>
            </div>
        </div>
    </li>
    <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#menu03" aria-expanded="true" aria-controls="menu03">
        	<i class="fa-solid fa-credit-card"></i> <span>쿠폰관리</span>
        </a>
        <div id="menu03" class="collapse" aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
            <div class="bg-white py-2 collapse-inner rounded">
            	<h6 class="collapse-header">쿠폰관리</h6>
                <a class="collapse-item" href="AdmProductList">상품</a>
            </div>
        </div>
    </li>
    <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#menu04" aria-expanded="true" aria-controls="menu04">
        	<i class="fa-solid fa-land-mine-on"></i> <span>통계관리</span>
        </a>
        <div id="menu04" class="collapse" aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
            <div class="bg-white py-2 collapse-inner rounded">
            	<h6 class="collapse-header">통계관리</h6>
                <a class="collapse-item" href="#">방문자</a>
                <a class="collapse-item" href="#">기간별 분석</a>
            </div>
        </div>
    </li>
    <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#menu05" aria-expanded="true" aria-controls="menu05">
        	<i class="fa-solid fa-newspaper"></i> <span>고객지원관리</span>
        </a>
        <div id="menu05" class="collapse" aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
            <div class="bg-white py-2 collapse-inner rounded">
            	<h6 class="collapse-header">고객지원관리</h6>
                <a class="collapse-item" href="#" data-sub-page="AdmNoticeModify" data-sub-page2="AdmNoticeRegist">가이드리스트</a>
                <a class="collapse-item" href="#">공지사항리스트</a>
                <a class="collapse-item" href="#">관리자문의</a>
            </div>
        </div>
    </li>
    <li class="nav-item">
        <a class="nav-link" href="#" data-toggle="collapse" data-target="#menu06" aria-expanded="true" aria-controls="menu06">
            <i class="fas fa-fw fa-chart-area"></i>
            <span>채팅</span>
        </a>
        <div id="menu06" class="collapse" aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
            <div class="bg-white py-2 collapse-inner rounded">
            	<h6 class="collapse-header">채팅</h6>
                <a class="collapse-item" href="#">실시간채팅</a>
                <a class="collapse-item" href="#">채팅신고</a>
            </div>
        </div>
    </li>
    <hr class="sidebar-divider d-none d-md-block">
    <div class="text-center d-none d-md-inline">
        <button class="rounded-circle border-0" id="sidebarToggle"></button>
    </div>
</ul>
<!-- End of Sidebar -->
<script>
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

               <!-- Topbar -->
               
<!-- Topbar -->
<nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">
    <!-- Sidebar Toggle (Topbar) -->
   <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
       <i class="fa fa-bars"></i>
   </button>
   
   <!-- Title -->
	<h4 class="m-0 text-gray-900">UNIPICK 판매자 대시보드</h4>
	
   <!-- Topbar Navbar -->
   <ul class="navbar-nav ml-auto">
       <li class="nav-item dropdown no-arrow">
           <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
               <span class="mr-2 d-none d-lg-inline text-gray-600 small">관리자</span>
               <img class="img-profile rounded-circle" src="../../resources/adm/img/admin_profile.png">
<!--                <img class="img-profile rounded-circle" src="../../resources/adm/img/undraw_profile.svg"> -->
           </a>
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