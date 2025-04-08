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
<link href="${pageContext.request.contextPath }/resources/css/buyer/buyerJoin.css" rel="stylesheet" type="text/css">

<link rel="icon" href="${pageContext.request.contextPath }/resources/images/favicon.png">

<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.1.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/buyer/buyerJoin.js"></script>
<title>UNIPICK</title>
</head>
<body>
<div class="join">
		<form method="post" action="buyerJoin" class="memberform">
			<div class="nav">
	 			<div class="joinNav-inner2">
					<a href="buyerlogin"><img src="${pageContext.request.contextPath}/resources/images/로고 가로.png" alt="로고" id="logo"></a>
				</div>
			</div>
		<h1 class="HEAD_24 BOLD css-17sedfb e1pr4wto0">서비스 이용약관에 동의해주세요.</h1>
		<div class="form8">
			<label class="lb1">
				<input type="checkbox" id="terms_all" class="terms">
				<span class="formspan">네, 모두 동의합니다.</span>
			</label></div>
		<div class="css-19tsq9r"></div>
		
		<div class="form8">
			<label class="lb1">
				<input type="checkbox" id="terms_ta" name="terms" class="terms">
				<span>(필수) 이용 약관 동의</span>
			</label><a href="policy" class="cssjoin">보기</a></div>
		
		<div class="form8">
		<label class="lb1">
		<input type="checkbox" id="terms_pa" name="terms" class="terms">
		<span>(필수) 개인 정보 처리 방침</span>
		</label><a href="privacy" class="cssjoin">보기</a></div>
		
		<div class="form8">
		<label class="lb1">
		<input type="checkbox" id="terms_ma" name="terms" class="terms">
		<span>(필수) 마케팅 동의</span>
		</label><a href="#" class="cssjoin">보기</a></div>
		
		<button class="joinBtn" id="completeBtn">다음</button>
			<div class="joinAgree">"‘선택' 항목에 동의하지 않아도 서비스 이용이 가능합니다."<br>
								   "개인정보 수집 및 이용에 대한 동의를 거부할 권리가 있으며,"<br>
								"동의 거부시 회원제 서비스 이용이 제한됩니다."</div>
			<div class="joinNav-inner">
				<button class="backBtn" onclick="location.href='buyerlogin'"><i class="fa-solid fa-arrow-left"></i></button></div>
		</form>
</div>
	<div class="ft">
		<jsp:include page="../inc/footer.jsp"></jsp:include>
	</div>
</body>
</html>