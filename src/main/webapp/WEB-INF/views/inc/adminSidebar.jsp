<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<!-- Sidebar -->
<ul class="navbar-nav bg-gradient-dark sidebar sidebar-dark accordion" id="accordionSidebar">
    <a class="sidebar-brand d-flex align-items-center justify-content-center" href="admin">
		<img src="${pageContext.request.contextPath}/resources/images/로고 가로.png" alt="로고" id="logo">
	</a>
	<c:if test="${admId == 'admin'}">
	    <hr class="sidebar-divider">
	    <div class="sidebar-heading">CommonCode</div>
	    <li class="nav-item">
	        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#menu01" aria-expanded="true" aria-controls="menu01">
	            <i class="fas fa-fw fa-cog"></i> <span>공통코드</span>
	        </a>
	        <div id="menu01" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
	            <div class="bg-white py-2 collapse-inner rounded">
	            	<h6 class="collapse-header">공통코드</h6>
	            	<a class="collapse-item" href="commonCode">공통코드</a>
	                <a class="collapse-item" href="commonCodeDetail">상세공통코드</a>
	                <a class="collapse-item" href="commonCodeLevel">계층공통코드</a>
	            </div>
	        </div>
	    </li>
    </c:if>
    <hr class="sidebar-divider">
    <div class="sidebar-heading">Site Setting</div>
    <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#menu02" aria-expanded="true" aria-controls="menu02">
        	<i class="fa-solid fa-user"></i> <span>회원 관리</span>
        </a>
        <div id="menu02" class="collapse" aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
            <div class="bg-white py-2 collapse-inner rounded">
            	<h6 class="collapse-header">회원관리</h6>
            	<c:if test="${admId == 'admin'}">
                	<a class="collapse-item" href="adminBuyerList" data-sub-page="AdmMemberDetailForm">구매자회원</a>
                </c:if>
                <a class="collapse-item" href="adminSellerList" >판매자회원</a>
<!--                 <a class="collapse-item" href="adminRegister" data-sub-page="AdmMemberDetailForm">관리자 등록(임시)</a> -->
				<c:if test="${admId == 'admin'}">
                	<a class="collapse-item" href="adminList" data-sub-page="AdmMemberDetailForm">관리자</a>
                </c:if>
            </div>
        </div>
    </li>
    <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#menu03" aria-expanded="true" aria-controls="menu03">
        	<i class="fa-solid fa-credit-card"></i> <span>상품관리</span>
        </a>
        <div id="menu03" class="collapse" aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
            <div class="bg-white py-2 collapse-inner rounded">
            	<h6 class="collapse-header">상품관리</h6>
                <a class="collapse-item" href="admProductList">상품 목록</a>
            </div>
        </div>
    </li>
    <c:if test="${admId == 'admin'}">
	    <li class="nav-item">
		    <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#menu06" aria-expanded="true" aria-controls="menu06">
		        <i class="fas fa-solid fa-land-mine-on"></i>
		        <span>신고관리</span>
		    </a>
		    <div id="menu06" class="collapse" aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
		        <div class="bg-white py-2 collapse-inner rounded">
		        	<h6 class="collapse-header">신고관리</h6>
		            <a class="collapse-item" href="adminReportList">신고</a>
		        </div>
		    </div>
	    </li>
	</c:if>
<!--     <hr class="sidebar-divider">
    <div class="sidebar-heading">신고관리</div>
 -->
    <hr class="sidebar-divider d-none d-md-block">
    <div class="text-center d-none d-md-inline">
        <button class="rounded-circle border-0" id="sidebarToggle"></button>
    </div>
</ul>
<!-- End of Sidebar -->
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