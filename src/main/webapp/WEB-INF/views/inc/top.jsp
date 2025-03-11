<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
</head>

<body>
	<header>
	    <div id="header-container">
	        <!-- 로고 -->
	        <a href="index.jsp">
	        	<img src="${pageContext.request.contextPath}/resources/images/로고 가로.png" alt="로고" id="logo">
	        </a>
	        <!-- 검색 아이콘 & 장바구니 아이콘 -->
	        <div id="icons-container">
		        <form action="/search">
		        	<div id="search">
			        	<input type="search">
			            <!-- 검색 아이콘 -->
			            <button type="submit" id="search_btn"><i class="fa fa-solid fa-magnifying-glass"></i></button>
					</div>
				</form>
		            <!-- 장바구니 아이콘 -->
	            <a href="cart.jsp" class="cart_btn"><i class="fa fa-solid fa-cart-shopping"></i></a>
	        </div>
	    </div>
    </header>
</body>
