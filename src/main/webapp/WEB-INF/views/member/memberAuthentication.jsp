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
<link href="${pageContext.request.contextPath }/resources/css/member/memberJoin.css" rel="stylesheet" type="text/css">

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
			<div class="css-1bwfwm7">
				<div class="css-1ff3op5">
					<h1 class="HEAD_22">휴대폰 인증을 해주세요.</h1>
				</div>
			</div>
			<div class="css-1rmy86f">
				<div class="css-1wnzdoc">
					<label class="BODY_13">휴대폰 번호</label>
					<div class="css-1ycs6v8">
						<span class="BODY_15"> <input type="tel" maxlength="13"
							placeholder="010-1234-5678" class="css-1oi39wj">
						</span class="css-8lsbin">
						<div spacing="8" class="css-1fmcxh">
							<div></div>
						</div>
						</span> </span>
						<button type="button" class="BODY_153">인증받기</button>
					</div>
				</div>
				<div class="css-1wnzdoc">
					<label class="BODY_13">인증번호</label>
					<div class="css-1ycs6v8">
						<span class="BODY_15"><input type="tel"
							placeholder="인증번호 4자리" maxlength="4" class="css-1oi39wj">
							<span class="css-8lsbin">
								<div spacing="8" class="css-1746nmm">
									<div class="BODY_13">00:00</div>
								</div>
						</span> </span>
					</div>
				</div>
			</div>

		</main>
	</div>
	<input type="button" onclick="location.href='memberEmail'" value="이메일로 이동">
</body>
</html>