<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- css -->
<link
	href="${pageContext.request.contextPath }/resources/css/seller/sellerFindAcc.css"
	rel="stylesheet" type="text/css">


<!-- 구글 폰트 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap"
	rel="stylesheet">

<!-- favicon -->
<link rel="icon"
	href="${pageContext.request.contextPath }/resources/images/favicon.png">

<!-- js -->
<script
	src="${pageContext.request.contextPath }/resources/js/jquery-3.7.1.js"></script>
<script
	src="${pageContext.request.contextPath }/resources/js/seller/sellerFindAcc.js"></script>

<title>유니픽 셀러</title>
</head>
<body>
	<div class="FindAcc-container">
		<div id="seller-join">
			<img
				src="${pageContext.request.contextPath}/resources/images/로고 가로.png"
				alt="로고" id="logo">
		</div>
		<div id="signup-container">
			<form id="storeSignupForm" action="sellerlogin" >
				<main class="css-ds6z7l">
					<div class="css-1bwfwm7">
						<div class="css-1ff3op5">
							<h2>유니픽 셀러 계정찾기</h2>
						</div>
					</div>
					<div class="css-1rmy86f">
						<div class="css-1wnzdoc">
							<label>셀러 아이디</label>
							<div class="css-1ycs6v8 input-container">
								<input type="tel" id="sel_id" class="css-1oi39wj">
							</div>
						</div>
						<div class="css-1wnzdoc">
							<label class="BODY_13">휴대폰 번호</label>
							<div class="css-1ycs6v8">
								<input id="phoneInput" type="tel" maxlength="13"
									placeholder="01012345678" class="css-1oi39wj">
								<button id="sendOtpBtn" type="button" class="BODY_153">인증받기</button>
							</div>
						</div>
						<!-- OTP 입력 -->
						<div class="css-1wnzdoc">
							<label class="BODY_13">인증번호</label>
							<div class="css-1ycs6v8 input-container">
								<input id="otpInput" type="tel" placeholder="인증번호 6자리"
									maxlength="6" class="css-1oi39wj">
								<div class="timer-box">
									<span id="timer">3:00</span>
								</div>
							</div>
							<button id="verifyOtpBtn" type="button">인증번호 확인</button>
						</div>
						<div>* 휴대폰 번호는 담당자 번호로 인증해주세요 *</div>
						<div id="resultContainer"></div>
					</div>
				</main>
			</form>
		</div>
	</div>
</body>
</html>