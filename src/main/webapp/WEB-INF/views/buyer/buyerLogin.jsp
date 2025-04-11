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

<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.1.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/buyer/buyerLogin.js"></script>
<title>UNIPICK</title>
</head>
<body>
	<div class="login-container">
		 <form action="" method="post" class="memberform" onsubmit="return false">
			 
		 	<div class="joinNav-inner2">
				<a href="main"><img src="${pageContext.request.contextPath}/resources/images/로고 가로.png" alt="로고" id="logo"></a>
			</div>
		 		<div class="sec01">
		 			<div class="sec-span"><span>안녕하세요 유니픽입니다</span>
		 		</div>
				<div class="member-info">
					<input type="text" id="buyerId" placeholder="아이디 입력" value="${savedBuyerId != null ? savedBuyerId : ''}">
				</div>
				<div class="member-info">
					<input type="password" id="buyerPw" placeholder="비밀번호 입력">
				</div>
	        	<button type="submit" class="buyerbutton">로그인</button>
	        		<input type="hidden" id="contextPathHolder" value="${pageContext.request.contextPath}">
	        	<a href="${pageContext.request.contextPath}/naver/login" onclick="window.open(this.href, 'naverloginpop', 'titlebar=1, resizable=1, scrollbars=yes, width=600, height=550'); return false" id="naver_id_login_anchor">
	        	<img src="${pageContext.request.contextPath}/resources/images/btnG.png" style="width:463.5px; height:46px" border="0" title="네이버 아이디로 로그인"></a>	
            	</div>
      			<div class="btn-wrap">
		        	<label class="buyer-btn"><input type="checkbox" id="rememberId">아이디 기억하기</label>
		       		<input class="btn-wrap-btn" type="button" onclick="location.href ='buyerId'" value="아이디 찾기">
		        	<input class="btn-wrap-btn" type="button" onclick="location.href ='buyerPw'" value="비밀번호 찾기">
		        	<input class="btn-wrap-btn" type="button" onclick="location.href ='buyerJoin'" value="회원가입">
        		</div>
        </form>
        
    </div>
<div class="ft">
	<jsp:include page="../inc/footer.jsp"></jsp:include>
</div>

<!-- buyerLogin.jsp 파일 상단 script 태그 안에 추가 -->
<script>
    var contextPath = "${pageContext.request.contextPath}";
</script>
</body>
</html>