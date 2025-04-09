<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link href="${pageContext.request.contextPath }/resources/css/seller/sellerLogin.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/footer.css" rel="stylesheet" type="text/css">

<!-- 구글 폰트 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
<!-- favicon -->
<link rel="icon" href="${pageContext.request.contextPath }/resources/images/favicon.png">
<!-- js -->
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.1.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/seller/sellerLogin.js"></script>

<title>유니픽 셀러</title>
</head>
<body>
	<div style="text-align: center;">
		<a href="">
       		<img src="${pageContext.request.contextPath}/resources/images/로고 가로.png" alt="로고" id="logo">
		</a>
	</div>
	<div id="login-container">
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
			 	<div><input type="text" id="sellerId" class="seller-info" value="${savedSellerId != null ? savedSellerId : ''}" 
					    placeholder="셀러 아이디"></div>
				<div><input type="password" id="sellerPw" class="seller-info" placeholder="셀러 비밀번호"></div>
	            <button type="submit">로그인</button>
	            <div>
		            <label class="seller-btn"><input type="checkbox" id="rememberId">아이디 기억하기</label>
		            <a href="sellerFindAcc" class="seller-btn">비밀번호 찾기 |</a>
		            <a href="sellerjoin" id="join" class="seller-btn">셀러 가입</a>
	            </div>
            </div>
        </form>
        <div class="css">
	       	<a href="sellerjoin"><img class ="sellerimg" alt="셀러가입" src="${pageContext.request.contextPath}/resources/images/셀러 로그인 .png"></a>
	       	<a href="main"><img class ="sellerimg" alt="셀러가입" src="${pageContext.request.contextPath}/resources/images/셀러로그인2.png"></a>
    	</div>
    </div>
	<div>
		<jsp:include page="../inc/footer.jsp"></jsp:include>
	</div>
</body>
</html>