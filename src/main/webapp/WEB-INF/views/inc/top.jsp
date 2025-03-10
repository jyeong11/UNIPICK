<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<!-- Font Awesome 5 Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<!-- css 연결 -->
<link href="${pageContext.request.contextPath }/resources/css/top.css" rel="stylesheet" type="text/css">
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
	            <!-- 검색 아이콘 -->
	            <a href="search.jsp"><i class="fa fa-solid fa-magnifying-glass"></i></a>
	
	            <!-- 장바구니 아이콘 -->
	            <a href="cart.jsp"><i class="fa fa-solid fa-cart-shopping"></i></a>
	        </div>
	    </div>
    </header>
</body>
