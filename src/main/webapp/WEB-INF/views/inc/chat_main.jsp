<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
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
<link href="${pageContext.request.contextPath }/resources/css/buyer/buyerbest.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/recommendation.css" rel="stylesheet" type="text/css">

<!-- js -->
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.1.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/index.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/inc/chat.js"></script>
<!-- Banner -->
<link href="${pageContext.request.contextPath }/resources/css/swiper-bundle.min.css" rel="stylesheet" type="text/css">
<!-- Favicon -->
<link rel="icon" href="${pageContext.request.contextPath }/resources/images/favicon.png">

<title>UNIPICK</title>

<style type="text/css">

article{
	padding-top: 200px;
}

h1{
	align: center;
	margin: auto;
}

#chatArea {
	width: 400px;
	height: 300px;
	border: 1px solid black;
	overflow: auto;
	margin: auto;
}

#commandArea {
	width: 400px;
	height: 300px;
	margin: auto;
}

#chatMessage {
width: 300px;

}

#btnSend{
	widows: 80px;
}

.message {
	font-size: 15px;
}

.message.center{
	text-align: center;
	font-size: 10px;
	
}

.message.left{
	text-align: left;
	background-color: #cccccc88;
}

.message.right {
	text-align: right;
	background-color: #FFFF0088
}


</style>

</head>
<body>
	<header id="topNav">
		<jsp:include page="top.jsp"></jsp:include>
	</header>

	<article>
		<h1>통합 채팅방 메인페이지</h1>
		<div id="chatArea">
			<span id="chatMessageArea"></span>
		</div>
		<div id="commandArea">
			<input type="text" id="chatMessage">
			<input type="button" value="전송" id="btnSend">
		</div>
	</article>
	
	<footer>
		<jsp:include page="footer.jsp"></jsp:include>
	</footer>

</body>
</html>