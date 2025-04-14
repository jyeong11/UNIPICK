<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- Font Awesome CDN 추가 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<!-- Sidebar -->
<ul class="navbar-nav bg-gradient-dark sidebar sidebar-dark accordion" id="accordionSidebar">
    <a class="sidebar-brand d-flex align-items-center justify-content-center" href="seller">
		<img src="${pageContext.request.contextPath}/resources/images/로고 가로.png" alt="로고" id="logo">
	</a>
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
                <a class="collapse-item" href="selProductList">상품조회</a>
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
                <a class="collapse-item" href="selOrderList" data-sub-page="#">주문조회</a>
                <a class="collapse-item" href="account" data-sub-page="#">정산관리</a>
<!--                 <a class="collapse-item" href="#" data-sub-page="#">관리자</a> -->
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
                <a class="collapse-item" href="sellerVisit">통계</a>
            </div>
        </div>
    </li>
    <li class="nav-item">
        <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#menu06" aria-expanded="true" aria-controls="menu06">
            <i class="fas fa-fw fa-chart-area"></i>
            <span>채팅</span><span id="chatNotificationBadge" class="notification-badge" style="display: none;">0</span>
        </a>
        <div id="menu06" class="collapse" aria-labelledby="headingUtilities" data-parent="#accordionSidebar">
            <div class="bg-white py-2 collapse-inner rounded">
            	<h6 class="collapse-header">채팅</h6>
                <a class="collapse-item" href="${pageContext.request.contextPath}/chat/seller/list">실시간채팅</a>
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

<!-- 채팅 알림 스타일 -->
<style>
.notification-badge {
    display: inline-block;
    background-color: #f2a900;
    color: white;
/*     border-radius: 50%; */
    width: 20px !important;
    height: 20px !important;
    text-align: center;
    line-height: 20px !important;
    font-size: 11px;
    font-weight: bold;
    margin-left: 8px;
    position: relative;
    top: -1px;
    vertical-align: middle;
}

#chatNotificationBadge {
    min-width: 20px !important;
    min-height: 20px !important;
    padding: 5px !important;
}

.nav-link span:last-child {
    margin-left: 8px;
}

/* 사이드바 메뉴 화살표 스타일 */
.sidebar .nav-item .nav-link[data-toggle="collapse"] {
    position: relative;
}

.sidebar .nav-item .nav-link[data-toggle="collapse"]::after {
/*     content: '\f104'; */
    font-family: 'Font Awesome 5 Free';
    font-weight: 900;
    position: absolute;
    right: 1rem;
    top: 50%;
    transform: translateY(-50%);
    transition: transform 0.3s;
    color: rgba(255, 255, 255, 0.8);
}

.sidebar .nav-item .nav-link[data-toggle="collapse"].collapsed::after {
    transform: translateY(-50%) rotate(0deg);
}

.sidebar .nav-item .nav-link[data-toggle="collapse"]:not(.collapsed)::after {
/*     transform: translateY(-50%) rotate(270deg); */
}
</style>

<!-- 채팅 알림 스크립트 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
    // 새 메시지 개수 확인 함수
    function checkNewMessages() {
        $.ajax({
            url: "${pageContext.request.contextPath}/chat/seller/new-messages/count",
            type: "GET",
            dataType: "json",
            success: function(response) {
                if (response.success && response.count > 0) {
                    // 새 메시지가 있으면 배지 표시
                    $("#chatNotificationBadge").text(response.count).show();
                } else {
                    // 새 메시지가 없으면 배지 숨김
                    $("#chatNotificationBadge").hide();
                }
            },
            error: function() {
                console.error("메시지 알림 확인 중 오류가 발생했습니다.");
            }
        });
    }
    
    // 채팅 링크 클릭 시 확인 시간 업데이트
    $(".collapse-item").click(function() {
        if($(this).attr("href").includes("/chat/seller/list")) {
            $.ajax({
                url: "${pageContext.request.contextPath}/chat/seller/update-last-checked",
                type: "POST",
                dataType: "json"
            });
        }
    });
    
    // 페이지 로드 시 최초 확인
    checkNewMessages();
    
    // 30초마다 새 메시지 확인
    setInterval(checkNewMessages, 30000);
});
</script>

