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
			<div>
				<div class="terms-wrap">
					<h1 class="terms-ttl">유니픽 이용약관</h1>
					<div class="terms-con">
						<h3>제 1조(목적)</h3>
						<div>본 약관은 "유니픽" 쇼핑몰 플랫폼(이하 "사이트")를 이용하는 모든 사용자(이하
							"이용자")의 권리, 의무 및 책임사항을 규정하는 것을 목적으로 합니다.</div>

						<h3>제 2조(이용 계약의 성립)</h3>
						<ul>
							<li>이용 계약은 이용자가 본 약관에 동의하고, 사이트에서 제공하는 절차에 따라 회원 가입을 완료함으로써
								성립됩니다.</li>
							<li>당사는 이용자의 가입 신청에 대해 승낙을 할 수 있으며, 승낙은 전자적으로 이루어집니다.</li>
						</ul>

						<h3>제 3조(서비스의 이용)</h3>
						<ul>
							<li>사이트는 이용자에게 중고거래, 상품 등록, 댓글 작성 등 다양한 서비스를 제공합니다.</li>
							<li>이용자는 본 약관을 준수하며 서비스를 이용해야 하며, 법령에 위반되지 않는 범위 내에서 서비스 이용이
								가능합니다.</li>
						</ul>

						<h3>제 4조(이용자의 의무)</h3>
						<ul>
							<li>이용자는 타인의 권리를 침해하거나 불법적인 내용을 게시할 수 없습니다.</li>
							<li>거래 및 게시물에서 발생한 분쟁에 대해 사이트는 책임을 지지 않으며, 당사자의 책임 하에 해결해야
								합니다.</li>
							<li>불법적이거나 부적절한 콘텐츠에 대해 사이트는 삭제 및 제재를 할 수 있습니다.</li>
						</ul>

						<h3>5조(회원의 탈퇴 및 서비스 이용 제한)</h3>
						<ul>
							<li>이용자는 언제든지 회원 탈퇴를 요청할 수 있으며, 탈퇴 시 모든 거래와 데이터는 삭제됩니다.</li>
							<li>이용자가 본 약관을 위반하거나 부정 이용할 경우, 사이트는 서비스 이용을 제한할 수 있습니다.</li>
						</ul>

						<h3>제 6조(책임의 한계)</h3>
						<div>사이트는 서비스 제공에 있어 최대한의 주의를 기울이지만, 제3자의 불법적인 행위나 시스템 장애로
							인한 피해에 대해서는 책임을 지지 않습니다.</div>
					</div>
				</div>
			</div>
		</section>
	</main>

	<div>
		<jsp:include page="footer.jsp"></jsp:include>
	</div>
</body>
</html>