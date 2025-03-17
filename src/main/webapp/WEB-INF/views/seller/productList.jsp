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
<link href="${pageContext.request.contextPath }/resources/css/seller/prdList.css" rel="stylesheet" type="text/css">

<link href="${pageContext.request.contextPath }/resources/js/seller/prdList.js" rel="stylesheet">

<link rel="icon" href="${pageContext.request.contextPath }/resources/images/favicon.png">
<title>UNIPICK</title>
</head>
<body>
<h1>상품리스트</h1>
	<div class="container-wrapper">
		<div class="container">
			<div class="row align-items-start justify-content-end">
				<div class="col-2">
					<select class="form-select" id="noticeSearchKind">
						<option value="option1">제목</option>
						<option value="option2">부서명</option>
						<option value="option3">이름</option>
					</select>
				</div>
				<div class="col-3">
					<input type="text" id="noticeSearchWord" class="form-control"
						placeholder="제목, 부서명, 이름 (으)로 검색">
				</div>
				<div class="col-1">
					<button id="noticeSearch" class="btn btn_main_color mb-3"
						type="button">조회</button>
				</div>
			</div>
		</div>
	</div>
	<div>
	<input type="button" onclick="location.href='prdRegister'" value="이메일로 이동">
	</div>
</body>
</html>