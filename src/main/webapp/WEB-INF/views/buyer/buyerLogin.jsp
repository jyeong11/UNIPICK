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
<link href="${pageContext.request.contextPath }/resources/css/index.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/buyer/buyerbest.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/recommendation.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/buyer/buyerLogin.css" rel="stylesheet" type="text/css">
<!-- Banner -->
<link href="${pageContext.request.contextPath }/resources/css/swiper-bundle.min.css" rel="stylesheet" type="text/css">
<!-- Favicon -->
<link rel="icon" href="${pageContext.request.contextPath }/resources/images/favicon.png">

<title>UNIPICK</title>
</head>
<body>
	<div class="login-container">
		 <form action="" method="post" class="memberform" onsubmit="return false">
		 	<a href=""><img src="${pageContext.request.contextPath}/resources/images/로고 가로.png" alt="로고" class="logo"></a>
		 	<div class="sec01">
		 	<div class="sec-span"><span>안녕하세요 유니픽입니다</span></div>
			<div class="member-info"><input type="text"  placeholder="아이디 입력"></div>
			<div class="member-info"><input type="password"  placeholder="비밀번호 입력"></div>
	        <button type="submit" class="memberbutton">로그인</button>
            </div>
        <div class="btn-wrap">
        <button class="btn-wrap-btn" type="button"><span>아이디 찾기</span></button>
        <button class="btn-wrap-btn" type="button"><span>비밀번호 찾기</span></button>
        <input class="btn-wrap-btn" type="button"  onclick="location.href ='buyerJoin'" value="회원가입">
        </div>
<!--         <div><button type="submit" class="nbutton">네이버 로그인</button></div> -->
<!--         <div><button type="submit" class="kbutton">카카오톡 로그인</button></div> -->
        </form>
    </div>
<div class="ft">
	<jsp:include page="../inc/footer.jsp"></jsp:include>
</div>
</body>
</html>