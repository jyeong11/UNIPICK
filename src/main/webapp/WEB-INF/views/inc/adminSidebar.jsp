<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%-- <script src="${pageContext.request.contextPath }/resources/js/adminSidebar.js"></script> --%>
<nav class="sidebar" id="sidebar">
    <h2>메뉴</h2>
    <ul class="menu">
        <li class="menu-item">
            <a href="#" class="menu-title">공통코드</a>
            <ul class="submenu">
                <li><a href="commonCode">공통코드</a></li>
                <li><a href="commonCodeDetail">상세공통코드</a></li>
                <li><a href="commonCodeLevel">계층공통코드</a></li>
            </ul>
        </li>
        <li class="menu-item">
            <a href="#" class="menu-title">회원관리</a>
            <ul class="submenu">
                <li><a href="#">구매자회원</a></li>
                <li><a href="#">판매자회원</a></li>
                <li><a href="#">관리자</a></li>
            </ul>
        </li>
        <li class="menu-item">
            <a href="#" class="menu-title">상품관리</a>
            <ul class="submenu">
                <li><a href="#">상품</a></li>
            </ul>
        </li>
        <li class="menu-item">
            <a href="#" class="menu-title">배너관리</a>
            <ul class="submenu">
                <li><a href="#">배너</a></li>
            </ul>
        </li>
        <li class="menu-item">
            <a href="#" class="menu-title">판매지원</a>
            <ul class="submenu">
                <li><a href="#">공지사항</a></li>
                <li><a href="#">가이드리스트</a></li>
                <li><a href="#">1:1문의</a></li>
            </ul>
        </li>
        <li class="menu-item">
            <a href="#" class="menu-title">신고관리</a>
            <ul class="submenu">
                <li><a href="#">신고</a></li>
            </ul>
        </li>
    </ul>
</nav>

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