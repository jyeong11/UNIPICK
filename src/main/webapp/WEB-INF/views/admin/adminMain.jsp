<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<!-- css -->
<link href="${pageContext.request.contextPath }/resources/css/public.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/adminMain.css" rel="stylesheet" type="text/css">

<!-- js -->
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.1.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/adminMain.js"></script>

<link rel="icon" href="${pageContext.request.contextPath }/resources/images/favicon.png">
<title>유니픽 관리자</title>
</head>
<body>
	<div id="admin-container">
		<div>
			<a href="">
		       	<img src="${pageContext.request.contextPath}/resources/images/로고 가로.png" alt="로고" id="logo">
			</a>
		 </div>
		 <div class="login_div">
		 	<ul class="login_ul">
		 		<li><a href="javascript:void(0);" id="admin_id">admin</a></li>
		 		<li class="logout_btn"><a href="#" id="logout">로그아웃</a></li>
		 	</ul>
		 </div>
	</div>
	
	
	<div class="main_container">
		<div id="left_bar">
			<jsp:include page="../inc/adminSidebar.jsp"></jsp:include>
		</div>
		
		<div class="content">
			<div class="container">
				<h6>방문자수</h6>
				<ul>
					<li>방문자수 출력 << 어떤값이 필요한가??<li>
				</ul>
			</div>
			<div class="container">
				<h6>최근 회원가입</h6>
				<ul>
					<li>이름, 아이디, (구매자,판매자), 이메일, 가입일시 등<li>
				</ul>
			</div>
			<div class="container">
				<h6>1:1 문의</h6>
				<ul>
					<li>리스트!!!!!!<li>
				</ul>
			</div>
			<div class="container">
				<h6>신고</h6>
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
	
</body>
</html>