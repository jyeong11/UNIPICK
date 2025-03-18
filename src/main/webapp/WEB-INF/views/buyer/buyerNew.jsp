<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
<link href="${pageContext.request.contextPath }/resources/css/best.css" rel="stylesheet" type="text/css">
<!-- Favicon -->
<link rel="icon" href="${pageContext.request.contextPath }/resources/images/favicon.png">

</head>
<body>
	<div id="topNav">
		<jsp:include page="../inc/top.jsp"></jsp:include>
	</div>

	<div>
		<jsp:include page="../inc/buyerMenuBar.jsp"></jsp:include>
	</div>
	
	<div id="content">
		<div id = "new">
			<div class = "two">
				<h2>오늘의 신상</h2>
			</div>
			<div id = "img12">
				<!-- 1번 줄 -->
				<div class="first">
					<div class="top_view">
						<div class="product_posting">
							<a href="#">
								<img src="${pageContext.request.contextPath }/resources/images/favicon_b.png" alt="1">
								<div>
									<div>스토어명</div>
									<div>상품명</div>
									<div>가격</div>
									<div>뱃지 등등</div>
								</div>
							</a>
						</div>
						<div class="product_posting">
							<a href="#">
								<img src="${pageContext.request.contextPath }/resources/images/favicon.png" alt="2">
								<div>
									<div>스토어명</div>
									<div>상품명</div>
									<div>가격</div>
									<div>뱃지 등등</div>
								</div>
							</a>
						</div>
					</div>
					<div class="bottom_view">
						<div class="product_posting">
							<a href="#">
								<img src="${pageContext.request.contextPath }/resources/images/favicon_b.png" alt="3">
								<div>
									<div>스토어명</div>
									<div>상품명</div>
									<div>가격</div>
									<div>뱃지 등등</div>
								</div>
							</a>
						</div>
						<div class="product_posting">
							<a href="#">
								<img src="${pageContext.request.contextPath }/resources/images/favicon.png" alt="4">
								<div>
									<div>스토어명</div>
									<div>상품명</div>
									<div>가격</div>
									<div>뱃지 등등</div>
								</div>
							</a>
						</div>
					</div>
				</div>
				<!-- 2번 줄 -->
				<div class="second">
					<div class="top_view">
						<div class="product_posting">
							<a href="#">
								<img src="${pageContext.request.contextPath }/resources/images/favicon_b.png" alt="5">
								<div>
									<div>스토어명</div>
									<div>상품명</div>
									<div>가격</div>
									<div>뱃지 등등</div>
								</div>
							</a>
						</div>
						<div class="product_posting">
							<a href="#">
								<img src="${pageContext.request.contextPath }/resources/images/favicon.png" alt="6">
								<div>
									<div>스토어명</div>
									<div>상품명</div>
									<div>가격</div>
									<div>뱃지 등등</div>
								</div>
							</a>
						</div>
					</div>
					<div class="bottom_view">
						<div class="product_posting">
							<a href="#">
								<img src="${pageContext.request.contextPath }/resources/images/favicon_b.png" alt="7">
								<div>
									<div>스토어명</div>
									<div>상품명</div>
									<div>가격</div>
									<div>뱃지 등등</div>
								</div>
							</a>
						</div>
						<div class="product_posting">
							<a href="#">
								<img src="${pageContext.request.contextPath }/resources/images/favicon.png" alt="8">
								<div>
									<div>스토어명</div>
									<div>상품명</div>
									<div>가격</div>
									<div>뱃지 등등</div>
								</div>
							</a>
						</div>
					</div>
				</div>
				<!-- 3번 줄 -->
				<div class="third">
					<div class="top_view">
						<div class="product_posting">
							<a href="#">
								<img src="${pageContext.request.contextPath }/resources/images/favicon_b.png" alt="9">
								<div>
									<div>스토어명</div>
									<div>상품명</div>
									<div>가격</div>
									<div>뱃지 등등</div>
								</div>
							</a>
						</div>
						<div class="product_posting">
							<a href="#">
								<img src="${pageContext.request.contextPath }/resources/images/favicon.png" alt="10">
								<div>
									<div>스토어명</div>
									<div>상품명</div>
									<div>가격</div>
									<div>뱃지 등등</div>
								</div>
							</a>
						</div>
					</div>
					<div class="bottom_view">
						<div class="product_posting">
							<a href="#">
								<img src="${pageContext.request.contextPath }/resources/images/favicon_b.png" alt="11">
								<div>
									<div>스토어명</div>
									<div>상품명</div>
									<div>가격</div>
									<div>뱃지 등등</div>
								</div>
							</a>
						</div>
						<div class="product_posting">
							<a href="#">
								<img src="${pageContext.request.contextPath }/resources/images/favicon.png" alt="12">
								<div>
									<div>스토어명</div>
									<div>상품명</div>
									<div>가격</div>
									<div>뱃지 등등</div>
								</div>
							</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>


	<div id="footer">
		<jsp:include page="../inc/footer.jsp"></jsp:include>
	</div>
</body>
</html>