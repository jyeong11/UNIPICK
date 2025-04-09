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
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" 
        integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg==" 
        crossorigin="anonymous" referrerpolicy="no-referrer" />

  <!-- CSS 연결 -->
  <link href="${pageContext.request.contextPath}/resources/css/public.css" rel="stylesheet" type="text/css">
  <link href="${pageContext.request.contextPath}/resources/css/top.css" rel="stylesheet" type="text/css">
  <link href="${pageContext.request.contextPath}/resources/css/footer.css" rel="stylesheet" type="text/css">
  <link href="${pageContext.request.contextPath}/resources/css/index.css" rel="stylesheet" type="text/css">
  <link href="${pageContext.request.contextPath}/resources/css/buyer/buyerJoin.css" rel="stylesheet" type="text/css">

  <link rel="icon" href="${pageContext.request.contextPath}/resources/images/favicon.png">
  <title>UNIPICK</title>
  
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/buyer/buyerAuthentication.js"></script>
</head>
<body>
  <div class="join" id="join1">
    <div class="nav">

    </div>
    <main class="css-ds6z7l">
          <nav class="joinNav">
        <div class="joinNav-inner2">
          <a href="buyerlogin">
            <img src="${pageContext.request.contextPath}/resources/images/로고 가로.png" alt="로고" id="logo">
          </a>
        </div>
        <div class="joinNav-inner3"></div>
      </nav>
      <div class="css-1bwfwm7">
        <div class="css-1ff3op5">
          <h1 class="HEAD_22">휴대폰 인증을 해주세요.</h1>
        </div>
      </div>
      <div class="css-1rmy86f">
        <!-- 휴대폰 번호 입력 -->
        <div class="css-1wnzdoc">
          <label class="BODY_13">휴대폰 번호</label>
          <div class="css-1ycs6v8">
            <input id="phoneInput" type="tel" maxlength="13" placeholder="01012345678" class="css-1oi39wj">
            <button id="sendOtpBtn" type="button" class="BODY_153">인증받기</button>
          </div>
        </div>
        <!-- OTP 입력 -->
        <div class="css-1wnzdoc">
          <label class="BODY_13">인증번호</label>
          <div class="css-1ycs6v8">
            <input id="otpInput" type="tel" placeholder="인증번호 6자리" maxlength="6" class="css-1oi39wj">
            <!-- 타이머 영역 (추가 구현 가능) -->
            <div class="css-8lsbin">
              <div spacing="8" class="css-1746nmm">
                <div class="BODY_13" id="timer">10:00</div>
              </div>
            </div>
          </div>
          <button id="verifyOtpBtn" type="button" class="BODY_153">인증번호 확인</button>
        </div>
<!--                 <div class="joinNav-inner"> -->
<!--           <button class="backBtn"> -->
<!--             <i class="fa-solid fa-arrow-left"></i> -->
<!--           </button> -->
<!--         </div> -->
      </div>
    </main>
  </div>
  	<div class="ft">
		<jsp:include page="../inc/footer.jsp"></jsp:include>
	</div>
</body>
</html>