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
<link href="${pageContext.request.contextPath }/resources/css/member/memberEmail.css" rel="stylesheet" type="text/css">

<link rel="icon" href="${pageContext.request.contextPath }/resources/images/favicon.png">
<title>UNIPICK</title>
</head>
<body>
	<div class="join">
		<div class="nav">
			<nav class="joinNav">
				<div class="joinNav-inner">
					<button class="backBtn">
						<i class="fa-solid fa-arrow-left"></i>
					</button>
				</div>
				<div class="joinNav-inner2">
					<a href="index.jsp"><img
						src="${pageContext.request.contextPath}/resources/images/로고 가로.png"
						alt="로고" id="logo"></a>
				</div>
				<div class="joinNav-inner3"></div>
			</nav>
		</div>
		<main class="css-ds6z7l">
		<h1 class="">이메일과 비밀번호를<br>입력해주세요.</h1>
		<form>
		<div class="css-138pfvh">
		<label class="BODY_13">이메일을 입력해주세요.</label>
		<span class="BODY_15"><input type="email" placeholder="로그인 시 필요" required class="css-1wr8iut">
		</span>
		</div>
		<div class="css-138pfvh">
		<label class="BODY_13">비밀번호</label>
		<span class="BODY_15">
		<input placeholder="영문, 숫자, 특수문자 포함 8자 이상" required type="password" class="css-1wr8iut">
		</span>
		</div>
		</form>
		<button class="css-1lhlb22">완료</button>
		</main>
	</div>
</body>
</html>