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
<link href="${pageContext.request.contextPath }/resources/css/buyer/buyerWithdraw.css" rel="stylesheet" type="text/css">

<!-- Favicon -->
<link rel="icon" href="${pageContext.request.contextPath }/resources/images/favicon.png">

<!-- script -->
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.1.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/buyer/buyerWithdraw.js"></script>
</head>
<body>
	<div class="root">
		<div id="top">
			<div>
				<a href="javascript:history.back();" class="top-btn">
					<i class="fa-solid fa-reply"></i>
				</a>
			</div>
			<h2>회원탈퇴</h2>
			<div>
				<a href="main" class="top-btn">
					<i class="fa-solid fa-house"></i>
				</a>
			</div>
		</div>
		
		<div class="content">
			<div>
				<input type="radio" name="reason" value="option1" class="radio-btn" checked>
				<span class="reason">원하는 스토어가 없어요.</span>
			</div>
			<div>
				<input type="radio" name="reason" value="option2" class="radio-btn">
				<span class="reason">오류가 자주 생겨요.</span>
			</div>
			<div>
				<input type="radio" name="reason" value="option3" class="radio-btn">
				<span class="reason">과도한 쇼핑을 자제하고 싶어요.</span>
			</div>
			<div>
				<input type="radio" name="reason" value="option4" class="radio-btn">
				<span class="reason">다른 계정으로 다시 가입하고 싶어요.</span>
			</div>
			<div class="bottom-div">
				<div>
					<input type="radio" name="reason" value="option5" class="radio-btn" id="custom-reason">
					<span class="reason">직접 입력</span>
				</div>
				<div class="last-div none">
					<textarea rows="4" cols="55" id="input-reason" maxlength="200" placeholder="더 나은 서비스를 제공해드릴 수 있도록 소중한 의견을 들려주세요."></textarea>
					<p>현재 글자 수: <span id="charCount">0</span><span>/200</span></p>
				</div>
			</div>
			<div>
				<button id="submit">회원탈퇴하고 계정 삭제하기</button>
			</div>
		</div>
	</div>
</body>
</html>