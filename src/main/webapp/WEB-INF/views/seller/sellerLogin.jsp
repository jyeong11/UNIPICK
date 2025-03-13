<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link href="${pageContext.request.contextPath }/resources/css/sellerLogin.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/footer.css" rel="stylesheet" type="text/css">

<!-- 구글 폰트 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
<!-- favicon -->
<link rel="icon" href="${pageContext.request.contextPath }/resources/images/favicon.png">
<!-- js -->
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.1.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/sellerLogin.js"></script>

<title>유니픽 셀러</title>
</head>
<body>
	<div id="login-container">
		<a href="">
	       	<img src="${pageContext.request.contextPath}/resources/images/로고 가로.png" alt="로고" id="logo">
		</a>
		 <form action="" method="post" onsubmit="return false">
		 	<div id="login-form">
			 	<h2>유니픽 셀러 로그인</h2>
			 	<div class="greet">
        			유니픽 파트너센터에 오신것을 환영합니다!
        		</div>
        		<div id="greet-talk" class="greet">
        			셀러페이지는 셀러만 이용하실 수 있습니다
        			<br>
        			먼저 로그인 해주세요 :)
        		</div>
			 	<div><input type="text" id="sellerId" class="seller-info" placeholder="셀러 아이디"></div>
				<div><input type="password" id="sellerPw" class="seller-info" placeholder="셀러 비밀번호"></div>
	            <button type="submit">로그인</button>
	            <div>
		            <label class="seller-btn"><input type="checkbox">아이디 기억하기</label>
		            <a href="#" class="seller-btn">비밀번호 찾기 |</a>
		            <a href="#" id="join" class="seller-btn">셀러 가입</a>
	            </div>
            </div>
        </form>
    </div>
	<div>
		<jsp:include page="../inc/footer.jsp"></jsp:include>
	</div>
</body>
</html>