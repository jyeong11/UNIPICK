<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<!-- css -->
<link href="${pageContext.request.contextPath }/resources/css/public.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/sellerMain.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/footer.css" rel="stylesheet" type="text/css">

<!-- 구글 폰트 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">

<!-- favicon -->
<link rel="icon" href="${pageContext.request.contextPath }/resources/images/favicon.png">
<!--  js -->
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.1.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/seller.js"></script>
<title>유니픽 셀러</title>
</head>
<body>
	<div id="seller-container">
		<div>
			<a href="">
		       	<img src="${pageContext.request.contextPath}/resources/images/로고 가로.png" alt="로고" id="logo">
			</a>
		 </div>
		 <div>
		 	<ul>
		 		<li><a href="javascript:void(0)" id ="selMypage">XXX 스토어</a></li>
		 	</ul>
		 </div>
	</div>	
	<div class="container-wrapper"> 
		<div id="left_bar">
			<jsp:include page="../inc/sellerSidebar.jsp"></jsp:include>
		</div>
		<div class="containers">	
		<div class="container">
			<h6>오늘의 할일</h6>
			<ul>
				<li><a href ="">신규주문 1</a><li>
				<li><a href ="">취소관리 2</a><li>
				<li><a href ="">반품관리 3</a><li>
				<li><a href ="">교환괸리 10</a><li>
				<li><a href ="">답변대기 15</a><li>
			</ul>
		</div>
		<div class="container">
			<h6>방문자</h6>
			<ul>
				<li>통계~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~<li>
			</ul>
		</div>
		<div class="container">
			<h6>기간별 분석</h6>
			<ul>
				<li>분석~~~~~~~~~~~~<li>
			</ul>
		</div>
		<div class="container">
			<h6>가이드 리스트</h6>
			<ul>
				<li>리스트!!!!!!<li>
			</ul>
		</div>
		<div class="container">
			<h6>공지사항</h6>
			<ul>
				<li>리스트~~~!!~!<li>
				<li>리스트~~~!!~!<li>
				<li>리스트~~~!!~!<li>
				<li>리스트~~~!!~!<li>
				<li>리스트~~~!!~!<li>
				<li>리스트~~~!!~!<li>
				<li>리스트~~~!!~!<li>
				<li>리스트~~~!!~!<li>
				<li>리스트~~~!!~!<li>
				<li>리스트~~~!!~!<li>
				<li>리스트~~~!!~!<li>
				<li>리스트~~~!!~!<li>
				<li>리스트~~~!!~!<li>
				<li>리스트~~~!!~!<li>
			</ul>
		</div>
		</div>
	</div>
	<div>
		<jsp:include page="../inc/footer.jsp"></jsp:include>
	</div>
</body>
</html>