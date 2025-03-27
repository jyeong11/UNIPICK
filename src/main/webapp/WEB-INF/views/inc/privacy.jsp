<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
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
<link href="${pageContext.request.contextPath }/resources/css/buyer/buyerbest.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/recommendation.css" rel="stylesheet" type="text/css">

<!-- js -->
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.1.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/index.js"></script>

<!-- Banner -->
<link href="${pageContext.request.contextPath }/resources/css/swiper-bundle.min.css" rel="stylesheet" type="text/css">
<!-- Favicon -->
<link rel="icon" href="${pageContext.request.contextPath }/resources/images/favicon.png">

<title>UNIPICK</title>
<body>
	<div id="topNav">
		<jsp:include page="top.jsp"></jsp:include>
	</div>
	<div>
		<jsp:include page="buyerMenuBar.jsp"></jsp:include>
	</div>
<main>
		<section class="wrapper">
			<!-- *********** 여기 안에 작업하세요. section.wrapper 건들지말기 ******** -->
			<div><div class="terms-wrap">
	<h1 class="terms-ttl">유니픽 개인정보처리방침</h1>
	<div class="terms-con">
		<h3>1. 개인정보의 수집 항목</h3>
		<div>"유니픽"는 서비스 제공을 위해 아래와 같은 개인정보를 수집합니다.</div>
		<ul>
		  <li>필수 항목: 이름, 이메일 주소, 연락처, 거래 내역</li>
		  <li>선택 항목: 주소, 결제 정보, 프로필 사진</li>
		</ul>
	
		<h3>2. 개인정보 이용 목적</h3>
		<ul>
		  <li>서비스 제공 및 이용자의 인증, 거래 이력 관리</li>
		  <li>거래 안전성 확보 및 분쟁 해결</li>
		  <li>고객 지원 및 공지사항 전달</li>
		  <li>서비스 개선 및 맞춤형 서비스 제공</li>
		</ul>
	
		<h3>3. 개인정보 보관 기간</h3>
		<div>이용자의 개인정보는 서비스 제공 기간 동안 보유되며, 탈퇴 시 즉시 삭제됩니다. 단, 법령에 의해 일정 기간 보존해야 하는 경우에는 법정 기간 동안 보유합니다.</div>
		
		<h3>4. 개인정보의 제3자 제공</h3>
		<ul>
		  <li>원칙적으로 이용자의 개인정보를 제3자에게 제공하지 않습니다.</li>
		  <li>단, 법적 의무가 있는 경우, 이용자의 동의를 받은 경우에는 예외적으로 제공할 수 있습니다.</li>
		</ul>
		
		<h3>5. 개인정보의 안전성 확보</h3>
		<ul>
		  <li>"굿바이"는 이용자의 개인정보를 안전하게 보호하기 위해 최신 보안 기술을 적용합니다.</li>
		  <li>개인정보에 대한 접근은 최소화되며, 이를 처리하는 직원은 엄격히 제한됩니다.</li>
		</ul>
		
		<h3>6. 이용자의 권리와 행사 방법</h3>
		<div>이용자는 언제든지 자신의 개인정보에 대한 열람, 수정, 삭제 요청을 할 수 있습니다. 이를 위해 고객센터를 통해 요청하면, 신속하게 처리해 드립니다.</div>
		
		<h3>7. 개인정보 보호 책임자</h3>
		<div>개인정보 처리와 관련된 문의나 불만은 개인정보 보호 책임자에게 연락하시면 됩니다.</div>
		<ul>
		  <li>개인정보 보호 책임자: [이름]</li>
		  <li>이메일: [이메일 주소]</li>
		  <li>전화번호: [전화번호]</li>
		</ul>
	</div>		
</div></div>
			<!-- *********** // 여기 안에 작업하세요. section.wrapper 건들지말기 ******** -->
		</section>
	</main>

	<div>
		<jsp:include page="footer.jsp"></jsp:include>
	</div>
</body>
</html>