<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link href="${pageContext.request.contextPath }/resources/css/admin/adminlogin.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/footer.css" rel="stylesheet" type="text/css">

<!-- 구글 폰트 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
<!-- favicon -->
<link rel="icon" href="${pageContext.request.contextPath }/resources/images/favicon.png">
<!-- js -->
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.1.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/admin/adminlogin.js"></script>
<!-- Favicon -->
<link rel="icon" href="${pageContext.request.contextPath }/resources/images/favicon.png">

<title>유니픽 관리자</title>
</head>
<body>
	<div id="login-container">
		<a href="">
	       	<img src="${pageContext.request.contextPath}/resources/images/로고 가로.png" alt="로고" id="logo">
		</a>
		 <form action="admin" method="post" onsubmit="return false">
		 	<div id="login-form">
			 	<h2>유니픽 관리자 로그인</h2>
			 	<div><input type="text" id="admId" class="admin-info" value="${savedadminId != null ? savedadminId : ''}" 
					    placeholder="관리자 아이디"></div>
				<div><input type="password" id="admPw" class="admin-info" placeholder="관리자 비밀번호"></div>
	            <button type="submit" id="login-btn">로그인</button>
	            <div>
		            <label class="admin-btn"><input type="checkbox" id="rememberId">아이디 기억하기</label>
	            </div>
	            <div id="greet-talk" class="greet">
        			※ 관리자 아이디 및 비밀번호 찾기는 아래 이메일로 문의 부탁드립니다.
        		</div>
            </div>
        </form>
    </div>
	<div>
		<jsp:include page="../inc/footer.jsp"></jsp:include>
	</div>
</body>
</html>