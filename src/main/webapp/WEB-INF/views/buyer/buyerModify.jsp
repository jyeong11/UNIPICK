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
<link href="${pageContext.request.contextPath }/resources/css/buyer/buyerModify.css" rel="stylesheet" type="text/css">

<!-- Favicon -->
<link rel="icon" href="${pageContext.request.contextPath }/resources/images/favicon.png">

<!-- script -->
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.1.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/buyer/buyerModify.js"></script>
</head>
<body>
	<div class="root">
		<div id="top">
			<div>
				<a href="javascript:history.back();" class="top-btn">
					<i class="fa-solid fa-reply"></i>
				</a>
			</div>
			<h2>회원정보 수정</h2>
			<div>
				<a href="main" class="top-btn">
					<i class="fa-solid fa-house"></i>
				</a>
			</div>
		</div>
		
		<div class="content">
			<div class="field">
				<p id="email"></p>
			</div>
			<div class="field">
				<div class="modi-title">
					<label for="name">이름</label><span id="nameError"></span>
				</div>
				<input type="text" id="name" class="input-value" maxlength="5" placeholder="이름을 입력해 주세요.">
				<p class="note">*최대 5글자</p>
			</div>
			<div class="field">
				<div class="modi-title">
					<label for="nickname">닉네임</label><span id="nickError"></span>
				</div>
				<input type="text" id="nickname" class="input-value" placeholder="이름을 입력해 주세요.">
				<p class="note">*최대 10글자</p>
			</div>
			<div class="field">
				<div class="modi-title">
					<label for="password">비밀번호</label><span id="passwdError"></span>
				</div>
				<input type="password" id="password" class="input-value" placeholder="비밀번호를 바꾸고 싶으면 입력 후 수정하기를 눌러주세요.">
				<p class="note">*비밀번호는 8자리 이상, 영문자(소문자,대문자) 및 특수문자를 포함해주세요.</p>
			</div>
			<div class="field">
				<div class="modi-title">
					<label for="phoneNumber">휴대폰 번호</label><span id="phoneError"></span>
				</div>
				<input type="text" id="phoneNumber" class="input-value" readonly>
			</div>
			<div class="field">
				<div class="modi-title">
					<label for="birthDate">생년월일</label><span id="birthError"></span>
				</div>
				<input type="text" id="birthDate" class="input-value">
				<p class="note">*YYMMDD</p>
			</div>
			<div class="field">
				<label for="gender">성별</label>
				<div class="gender-btn">
					<button class="female"><i class="fa-solid fa-venus"></i> 여자</button>
					<button class="male"><i class="fa-solid fa-mars"></i> 남자</button>
				</div>
			</div>
			<div class="field">
				<div class="modi-title">
					<label for="bodySize">신체 사이즈(선택)</label><span id="sizeError"></span>
				</div>
				<div class="size-div">
					<input type="number" id="heightSize" class="input-value" placeholder="키"><span>cm</span>
					<input type="number" id="weightSize" class="input-value" placeholder="몸무게"><span>kg</span>
				</div>
				<div class="body-div">
					<p class="note">*키 범위 : 100 ~ 250cm</p>
					<p class="note">*몸무게 범위 : 40 ~ 150kg</p>
				</div>
			</div>
			<div class="field">
				<div id="last-div">
					<button id="modify">수정하기</button>
					<button id="withdraw">탈퇴하기</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>