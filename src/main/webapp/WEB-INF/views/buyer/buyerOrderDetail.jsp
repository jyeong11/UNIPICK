<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<title>유니픽</title>
<!-- 구글 폰트 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">

<!-- Font Awesome 5 Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg==" crossorigin="anonymous" referrerpolicy="no-referrer" />

<!-- js -->
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.1.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/buyer/buyerOrderDetail.js"></script>

<!-- css -->
<link href="${pageContext.request.contextPath }/resources/css/public.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/buyer/buyerMenuBar.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/top.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/footer.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/buyer/buyerOrderDetail.css" rel="stylesheet" type="text/css">
<!-- favicon -->
<link rel="icon" href="${pageContext.request.contextPath }/resources/images/favicon.png">
</head>
<body>
	<div id="topNav">
		<jsp:include page="../inc/top.jsp"></jsp:include>
	</div>
	
	<div>
		 <jsp:include page="../inc/buyerMenuBar.jsp"></jsp:include>
	</div>
	<div>
		<div class="title"><h1>주문 상세 조회</h1></div>
	</div>
	
	<div id="order-container">
		<div><h2>주문 상품 정보</h2></div>
		<div id="product-info"></div>
	</div>
	<div id="deliInfo-container">
        <form id="delivery-form">
            <div id="del"><h2>배송지 정보</h2></div>
            <div class="del-nm"><span>수령인</span><input type="text" id="shipping_name" readonly></div>
            <div class="del-nm"><span>휴대폰</span><input type="text" id="shipping_telephone" readonly></div>
            <div class="del-nm"><span>배송주소</span><input type="text" id="shipping_zip" readonly></div>
            <div class="del-nm"><span>배송메모</span><input type="text" id="shipping_memo" readonly></div>
        </form>
    </div>
	<div id="delprice-container">
        <div id="total"><h2>최종 결제 금액</h2></div>
        <div class="price">
            <div id="total-pr"><span>총 상품금액</span><span id="totalPrice">원</span></div>
            <div id="total-dp"><span>총 배송비</span><span id="totalDelPrice">원</span></div>
            <div id="payment-pm"><span>결제수단</span><span id="payment"></span></div>
        </div>
        <div id="prpr"><span>결제 금액</span><span id="sum">원</span>         	
        </div>
    </div>
	<div id="button-container">
		<button id="home">홈으로 이동</button>
		<button id="orderList">배송 / 주문 조회로 이동</button>
	</div>
	
	<div id="footer">
		<jsp:include page="../inc/footer.jsp"></jsp:include>
	</div>
</body>
</html>