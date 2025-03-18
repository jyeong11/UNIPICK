<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<head>
<meta charset="UTF-8">
<!-- js -->
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.1.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/inc/top.js"></script>
</head>

<body>
	<header>
	    <div id="header-container">
	        <!-- 로고 -->
	        <a href="main">
	        	<img src="${pageContext.request.contextPath}/resources/images/로고 가로.png" alt="로고" id="logo">
	        </a>
	        <div><a href="seller" target="_blank">판매자 새탭</a></div>
		    <div><a href="admin" target="_blank">관리자 새탭</a></div>
	        <!-- 검색 아이콘 & 장바구니 아이콘 -->
	        <div id="icons-container">
		    <div>
		        <ul id="top_icon">
		            <li>
		                <div id="search">
		                    <input type="search" id="search_input">
		                    <button type="button" id="search_btn">
		                        <i class="fa fa-solid fa-magnifying-glass"></i>
		                    </button>
		                </div>
		            </li>
		            <li><a href="cart" class="cart_btn"><i class="fa fa-solid fa-cart-shopping"></i></a></li>
		            <li><a href="memberLogin" class="my_btn"><i class="fa-solid fa-user"></i></a></li>
		        </ul>
		    </div>
</div>
	    </div>
    </header>
</body>
