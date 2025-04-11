<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    String userPhone = (String) session.getAttribute("userPhone");

    
    // Integer로 값 가져오기 (null 처리)
    Integer check1 = (Integer) session.getAttribute("check1");
    Integer check2 = (Integer) session.getAttribute("check2");
    Integer check3 = (Integer) session.getAttribute("check3");

    // 값이 null인 경우 기본값 설정
    check1 = (check1 != null) ? check1 : 0;
    check2 = (check2 != null) ? check2 : 0;
    check3 = (check3 != null) ? check3 : 0;
    
    System.out.println("userPhone: " + userPhone);
    System.out.println("acc_ta: " + check1);
    System.out.println("acc_pa: " + check2);
    System.out.println("acc_ma: " + check3);
%>
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
<link href="${pageContext.request.contextPath }/resources/css/buyer/buyerEmail.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/buyer/buyerJoin.css" rel="stylesheet" type="text/css">
<link rel="icon" href="${pageContext.request.contextPath }/resources/images/favicon.png">

<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.1.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/buyer/buyerEmail.js"></script>
<title>UNIPICK</title>

<style>
.css-ds6z7l {
    padding: 9vh !important;
    width: 90vh;
    height: 67vh !important;
    box-sizing: border-box;
    margin-top: 10px;
    background: #fff;
    border-radius: 20px;
    box-shadow: 0 4px 31px 0 rgba(0, 0, 0, 0.1);
}

.joinNav {
    display: flex;
    justify-content: center;
    align-items: center;
    width: 100%;
    padding: 0;
    margin: 0 auto;
    padding-left: 102px;
}

.joinNav-inner2 {
    display: flex;
    justify-content: center;
    align-items: center;
    width: 100%;
    text-align: center;
}

.joinNav-inner2 a {
    display: flex;
    justify-content: center;
    width: 100%;
}

#logo {
    display: block;
    margin: 0 auto;
    width: 180px;
    position: relative;
    left: 0;
    right: 0;
}
</style>
</head>
<body>
	<div class="join" id="join1">
		<div class="nav">
		</div>
		<main class="css-ds6z7l">
			<form action="#" method="get" onsubmit="return false;">
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
						<h1 class="HEAD_22">이메일과 비밀번호를<br>입력해주세요.</h1>
					</div>
				</div>
				<div class="css-1rmy86f">
					<div class="css-1wnzdoc">
						<label class="BODY_13">이메일을 입력해주세요.</label>
						<div class="css-1ycs6v8">
							<input type="email" id="buy_em" class="css-1oi39wj" placeholder="로그인 시 필요" required>
						</div>
						<span id="checkIdResult"></span>
					</div>
					<div class="css-1wnzdoc">
						<label class="BODY_13">비밀번호</label>
						<div class="css-1ycs6v8">
							<input type="password" id="buy_pw" class="css-1oi39wj" placeholder="영문, 숫자, 특수문자 포함 8자 이상" maxlength="16" required>
						</div>
						<span id="checkPasswdResult"></span>
						<input type="hidden" id="userPhone" name="userPhone" value="${sessionScope.userPhone}" />
						<input type="hidden" id="acc_ta" name="acc_ta" value="${sessionScope.acc_ta}" />
						<input type="hidden" id="acc_pa" name="acc_pa" value="${sessionScope.acc_pa}" />
						<input type="hidden" id="acc_ma" name="acc_ma" value="${sessionScope.acc_ma}" />
					</div>
					<button class="css-1lhlb22" id="completeBtn">완료</button>
				</div>
			</form>
		</main>
	</div>
	<div class="ft">
		<jsp:include page="../inc/footer.jsp"></jsp:include>
	</div>
</body>
</html>