<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>UNIPICK</title>
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
<link href="${pageContext.request.contextPath }/resources/css/buyer/buyerMenuBar.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/buyer/buyerReview.css" rel="stylesheet" type="text/css">

<!-- Favicon -->
<link rel="icon" href="${pageContext.request.contextPath }/resources/images/favicon.png">

<!-- script -->
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.1.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/buyer/buyerReview.js"></script>

</head>
<body>
	<div id="topNav">
		<jsp:include page="../inc/top.jsp"></jsp:include>
	</div>
	<div>
		<jsp:include page="../inc/buyerMenuBar.jsp"></jsp:include>
	</div>
	
	<div class="content">
		<div id="reviewTitle">이 상품 어떠셨나요?</div>
		<div id="content-top">
		</div>
		<div id="content-middle">
			<div><p class="content-title">리뷰상세</p></div>
			<div>
				<textarea rows="10" cols="63" id="reviewDetail" placeholder="다른 회원들이 도움을 받을 수 있게 상품에 대한 의견을 자세히 공유해 주세요."></textarea>
				<p id="checkChar">현재 글자 수: <span id="charCount">0</span><span>/500</span></p>
			</div>
		</div>
		<div id="content-bottom">
			<p class="content-title">사진</p>
			<div class="item-thumb-group">
				<form id="uploadForm" action="" method="post" enctype="multipart/form-data">
					<c:forEach var="i" begin="1" end="3">
						<div class="item-thumb">
							<button type="button" class="item-thumb-upload" data-index="${i}">
								<img src="/resources/img/product-thumb-no.jpg"  id="item-thumb-preview${i}">
							</button>
							<input type="file" class="item-thumb-upload-btn" id="item-thumb-upload-btn${i}" name="imageFiles" multiple>
						</div>
					</c:forEach>
				</form>
			</div>
		</div>
		<div id="last-btn">
			<button id="registerReview">등록하기</button>
			<button id="cancel">뒤로가기</button>
		</div>
	</div>
	
	<div id="footer">
		<jsp:include page="../inc/footer.jsp"></jsp:include>
	</div>
</body>
</html>