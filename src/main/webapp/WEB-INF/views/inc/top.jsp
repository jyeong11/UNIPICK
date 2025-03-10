<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<!-- Font Awesome 5 Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg==" crossorigin="anonymous" referrerpolicy="no-referrer" />

<header style="width: 100%; background: #fff; border-bottom: 1px solid #ddd; position: fixed; top: 0; left: 0; z-index: 1000;">
    <div style="max-width: 1200px; margin: 0 auto; display: flex; justify-content: space-between; align-items: center; padding: 15px;">
        
        <!-- 로고 -->
        <a href="index.jsp">
        	<img src="${pageContext.request.contextPath}/resources/images/로고 가로.png" alt="로고" style="width: 10%">
        </a>

        <!-- 검색 아이콘 & 장바구니 아이콘 -->
        <div style="display: flex; align-items: center; gap: 15px;">
            <!-- 검색 아이콘 -->
            <a href="search.jsp"><i class="fa fa-solid fa-magnifying-glass"></i></a>

            <!-- 장바구니 아이콘 -->
            <a href="cart.jsp"><i class="fa fa-solid fa-cart-shopping"></i></a>
        </div>
    </div>
</header>