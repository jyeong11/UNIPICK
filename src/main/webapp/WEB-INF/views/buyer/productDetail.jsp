<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${prd.prd_nm}</title>
<!-- 구글 폰트 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">

<!-- Font Awesome 5 Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg==" crossorigin="anonymous" referrerpolicy="no-referrer" />

<!-- js -->
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.1.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/buyer/productDetail.js"></script>

<!-- css -->
<link href="${pageContext.request.contextPath }/resources/css/public.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/buyer/buyerMenuBar.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/top.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/footer.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/buyer/productDetail.css" rel="stylesheet" type="text/css">
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
	 <div class="product-container">
    <!-- 왼쪽 상품 이미지 -->
	    <div>
			<c:forEach var="image" items="${prdImg}">
				<img src="${image}" class="product-img" />
			</c:forEach>
		</div>
	
	    <div class="product-info">
	        <div><a href=""><i class="fa-solid fa-house"></i>${prd.sel_id}</a></div>
	        <h2>${prd.prd_nm}</h2>
	        <div id="price">
	        	<p><span class="dc">${prd.dc}</span></p>
		        <p><span class="discount">${prd.prd_sp}원</span></p>
		        <p><span class="original-price">${prd.prd_op}원</span></p>
			</div>
	        <select id="color" onchange="loadSize()">
				<option>[color]를 선택하세요.</option>
				<c:forEach var="option" items="${optionList}">
					<option value="${option.clr_nm}">${option.clr_nm}</option>
				</c:forEach>
			</select>
	
	        <select id="size" disabled>
			    <option selected>[size]를 선택하세요.</option>
			</select>
			<div id="selected-option" class="option-box" style="display: none;">
			    <span id="option-text">옵션을 선택하세요</span>
			    <span id="option-price"></span>
			</div>
	        <div class="button-container">
	            <button class="buy-now">바로 구매</button>
	            <button class="npay">UNI Pay 구매</button>
	        </div>
			<button id="scrollToTop">↑</button>
			<button id="scrollToBottom">↓</button>
	    </div>
	    <div id="prdDetailBar">
	    	<ul><li>상품정보</li></ul>
	    	<ul><li>리뷰</li></ul>
	    	<ul><li>문의</li></ul>
	    </div>
	</div>
	
	<div id="footer">
		<jsp:include page="../inc/footer.jsp"></jsp:include>
	</div>
	<script>
    	var prdCd = "${prd.prd_cd}";
	</script>
</body>
</html>