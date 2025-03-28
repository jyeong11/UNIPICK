<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>UNIPICK</title>
<!-- 구글 폰트 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">

<!-- Font Awesome 5 Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg==" crossorigin="anonymous" referrerpolicy="no-referrer" />

<!-- CSS 연결 -->
<link href="${pageContext.request.contextPath }/resources/css/public.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/top.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/footer.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/buyer/buyerMenuBar.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/buyer/buyerOrderList.css" rel="stylesheet" type="text/css">

<!-- Favicon -->
<link rel="icon" href="${pageContext.request.contextPath }/resources/images/favicon.png">

<!-- script -->
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.1.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/buyer/buyerOrderList.js"></script>

</head>
<body>
	<div id="topNav">
		<jsp:include page="../inc/top.jsp"></jsp:include>
	</div>
	<div>
		<jsp:include page="../inc/buyerMenuBar.jsp"></jsp:include>
	</div>
	
	<div class="content">
		<div class = "two">
			<h2>나의 주문/배송 현황</h2>
		</div>
		<div id="radio-search">	<!-- 검색, 정렬기준 -->
			<div id="ord-radio">
				<label class="search-radio"><input type="radio" name="choice" value="option1" checked> 최근 3개월</label>
			    <label class="search-radio"><input type="radio" name="choice" value="option2"> 최근 1년</label>
			    <label class="search-radio"><input type="radio" name="choice" value="option3"> 전체</label>
		    </div>
		    <div id="ord-search">
			    <input type="text" id="searchData" placeholder="상품명 / 스토어명으로 검색">
				<button id="ordSearch">검색</button>
			</div>
		</div>
		<div id="cards"></div>
	</div>
	
	<div id="footer">
		<jsp:include page="../inc/footer.jsp"></jsp:include>
	</div>
</body>
</html>