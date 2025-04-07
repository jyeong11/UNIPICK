<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

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

<!-- js -->
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.1.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/index.js"></script>

<!-- Banner -->
<link href="${pageContext.request.contextPath }/resources/css/swiper-bundle.min.css" rel="stylesheet" type="text/css">
<!-- Favicon -->
<link rel="icon" href="${pageContext.request.contextPath }/resources/images/favicon.png">


<title>UNIPICK</title>
</head>
<body>
	<div id="topNav">
		<jsp:include page="./inc/top.jsp"></jsp:include>
	</div>
	<div>
		<jsp:include page="./inc/buyerMenuBar.jsp"></jsp:include>
	</div>
	<div>
		<jsp:include page="./inc/banner.jsp"></jsp:include>
	</div>
	
	<!-- 상품 추천 -->	
	<section>
		<div>
			<jsp:include page="./inc/recommendation.jsp"></jsp:include>
		</div>
	</section>
	
	<!-- 베스트 -->
	<section>
		<div>
			<jsp:include page="./inc/bestProudct.jsp"></jsp:include>
		</div>
	</section>
	
	<!-- 신상 -->
	<section>
		<div>
			<jsp:include page="./inc/newProduct.jsp"></jsp:include>
		</div>
	</section>
	<div>
		<jsp:include page="./inc/footer.jsp"></jsp:include>
	</div>
</body>
</html>