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
		        		<ul>
			        	<li><input type="search"><button type="submit" id="search_btn"></button><i class="fa fa-solid fa-magnifying-glass"></i></li>
			            <!-- 검색 아이콘 --> 
						 <li><a href="cart.jsp" class="cart_btn"><i class="fa fa-solid fa-cart-shopping" ></i></a></li>
	            		</ul>
					</div>
	            </form>
<!-- 					<div> -->
<!-- 					<button type="submit" id="search_btn"><i class="fa fa-solid fa-magnifying-glass"></i></button> -->
<!-- 					</div> -->
				
		            <!-- 장바구니 아이콘 -->
	           
	        </div>
	    </div>
    </header>
</body>
