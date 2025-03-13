<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<nav class="sidebar" id="sidebar">
    <h2>메뉴</h2>
    <ul class="menu">
        <li class="menu-item">
            <a href="#" class="menu-title">상품관리</a>
            <ul class="submenu">
                <li><a href="prdRegister">상품등록</a></li>
                <li><a href="">상품조회</a></li>
            </ul>
        </li>
        <li class="menu-item">
            <a href="#" class="menu-title">주문관리</a>
            <ul class="submenu">
                <li><a href="#">구매자회원</a></li>
                <li><a href="#">판매자회원</a></li>
                <li><a href="#">관리자</a></li>
            </ul>
        </li>
        <li class="menu-item">
            <a href="#" class="menu-title">쿠폰관리</a>
            <ul class="submenu">
                <li><a href="#">상품</a></li>
            </ul>
        </li>
        <li class="menu-item">
            <a href="#" class="menu-title">통계</a>
            <ul class="submenu">
                <li><a href="#">방문자</a></li>
                <li><a href="#">기간별 분석</a></li>
            </ul>
        </li>
        <li class="menu-item">
            <a href="#" class="menu-title">고객지원관리</a>
            <ul class="submenu">
                <li><a href="#">가이드리스트</a></li>
                <li><a href="#">공지사항리스트</a></li>
                <li><a href="#">관리자문의</a></li>
            </ul>
        </li>
        <li class="menu-item">
            <a href="#" class="menu-title">채팅</a>
            <ul class="submenu">
                <li><a href="#">실시간채팅</a></li>
                <li><a href="#">채팅신고</a></li>
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