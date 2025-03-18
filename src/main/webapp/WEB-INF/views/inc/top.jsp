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
	        <a href="main">
	        	<img src="${pageContext.request.contextPath}/resources/images/로고 가로.png" alt="로고" id="logo">
	        </a>
	        <div><a href="seller" target="_blank">판매자 새탭</a></div>
		    <div><a href="admin" target="_blank">관리자 새탭</a></div>
	        <!-- 검색 아이콘 & 장바구니 아이콘 -->
	        <div id="icons-container">
		        <form action="/search">
		        	<div>
		        		<ul id="top_icon">
			        	<li><div id="search"><input type="search"><button type="submit" id="search_btn"><i class="fa fa-solid fa-magnifying-glass"></i></button></div></li>
			            <!-- 검색 아이콘 --> 
						 <li><a href="cart" class="cart_btn"><i class="fa fa-solid fa-cart-shopping"></i></a></li>
						 <li><a href="memberLogin" class="my_btn"><i class="fa-solid fa-user"></i></a></li>
	            		</ul>
					</div>
	            </form>
	        </div>
	    </div>
    </header>
</body>
