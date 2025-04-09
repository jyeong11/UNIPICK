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
<title>UNIPICK</title>
</head>
<body>
	<div class="login-container">
		<form action="rest" method="post" class="memberform" id="rest-password-form"
			onsubmit="return false">
			<a href=""><img src="${pageContext.request.contextPath}/resources/images/로고 가로.png"
				alt="로고" class="logo"></a>
			<div class="sec01">
				<div class="sec-span">
					<span>비밀번호 찾기</span>
				</div>
				<div class="member-info">
					<input type="text" id="buyNm" placeholder="이름 입력">
				</div>
				<div class="member-info">
					<input type="email" id="buyEm" placeholder="이메일 입력">
				</div>
				<button type="submit" class="buyerbutton">비밀번호 찾기</button>
			</div>
			<div class="btn-wrap">
				<input class="btn-wrap-btn" type="button"
					onclick="history.back()'" value="되돌아가기">
				<input class="btn-wrap-btn" type="button"
					onclick="location.href ='buyerId'" value="아이디 찾기">
				<input class="btn-wrap-btn" type="button"
					onclick="location.href ='buyerJoin'" value="회원가입">
			</div>
			<div id="result"></div>
		</form>
			
	</div>

	<div class="ft">
	<jsp:include page="../inc/footer.jsp"></jsp:include>
</div>
<script>
function isValidEmail(email) {
    const regex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
    return regex.test(email);
}

$("#rest-password-form").submit(function(event) {
    event.preventDefault(); 
    var buyNm = $("#buyNm").val();
    var buyEm = $("#buyEm").val();

    if (!isValidEmail(buyEm)) {
        $("#result").html("<div class='alert alert-warning'>이메일 형식이 올바르지 않습니다.</div>");
        return;
    }

    $.ajax({
        url: "reset",
        method: "POST",
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        dataType: "json",
        data: {
            buyNm: buyNm,
            buyEm: buyEm
        },
        success: function(res) {
            $("#result").html("<div class='alert alert-success'style='background-color:#f2a900ff; color:black;'>" + res.message + "</div>");
        },
        error: function(xhr) {
            var errorMessage = xhr.responseJSON ? xhr.responseJSON.error : "정보 불일치";
            $("#result").html("<div class='alert alert-warning'>" + errorMessage + "</div>");
        }
    });
});
</script>
</body>
</html>