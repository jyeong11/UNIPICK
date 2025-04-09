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
		<form action="" method="post" class="memberform" id="findEmpForm"
			onsubmit="return false">
			<a href=""><img src="${pageContext.request.contextPath}/resources/images/로고 가로.png"
				alt="로고" class="logo"></a>
			<div class="sec01">
				<div class="sec-span">
					<span>아이디 찾기</span>
				</div>
				<div class="member-info">
					<input type="text" id="buyNm" placeholder="이름 입력">
				</div>
				<div class="member-info">
					<input type="tel" id="buyPh" placeholder="휴대폰 입력">
				</div>
				<button type="submit" class="buyerbutton">아이디 찾기</button>
			</div>
			<div class="btn-wrap">
				<input class="btn-wrap-btn" type="button"
					onclick="history.back();" value="되돌아가기">
				<input class="btn-wrap-btn" type="button"
					onclick="location.href ='buyerPw'" value="비밀번호찾기">
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
$(document).ready(function(){
	  $("#findEmpForm").on("submit", function(e){
	    e.preventDefault(); // 폼 기본 제출 방지

	    // 입력값 가져오기
	    var buyNm = $("#buyNm").val();
	    var buyPh = $("#buyPh").val();

	    // Ajax 요청
	    $.ajax({
	      type: "POST",
	      url: "buyerId",
	      data: { buy_nm: buyNm, buy_ph: buyPh },
	      dataType: "json",
	      success: function(res){
	        if (res.message) {
	          $("#result").html("<div class='alert alert-success' style='background-color:#f2a900ff; color:black;'>" + res.message + "</div>");
	        } else if (res.error) {
	          $("#result").html("<div class='alert alert-warning'>" + res.error + "</div>");
	        }
	      },
	      error: function(xhr, status, error){
	        var errorMessage = xhr.responseJSON ? xhr.responseJSON.error : "요청 실패";
	        $("#result").html("<div class='alert alert-warning'>" + errorMessage + "</div>");
	      }
	    });
	  });
	});
</script>
</body>
</html>