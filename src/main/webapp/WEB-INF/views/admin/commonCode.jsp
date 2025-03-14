<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 구글 폰트 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">

<!-- css -->
<link href="${pageContext.request.contextPath }/resources/css/public.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/commonCode.css" rel="stylesheet" type="text/css">

<!-- favicon -->
<link rel="icon"
	href="${pageContext.request.contextPath }/resources/images/favicon.png">
<!--  js -->
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.1.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/commondcode.js"></script>
<title>유니픽 관리자</title>
</head>
<body>
	<div id="admin-container">
		<div>
			<a href="">
		       	<img src="${pageContext.request.contextPath}/resources/images/로고 가로.png" alt="로고" id="logo">
			</a>
		 </div>
		 <div class="login_div">
		 	<ul class="login_ul">
		 		<li><a href="javascript:void(0);" id="admin_id">admin</a></li>
		 		<li class="logout_btn"><a href="#" id="logout">| 로그아웃</a></li>
		 	</ul>
		 </div>
	</div>
	<div class="main_container">
		<div id="left_bar">
			<jsp:include page="../inc/adminSidebar.jsp"></jsp:include>
		</div>
		<div class="container">
			<section class="section">
				<div>
					<h1>공통코드</h1>
				</div>
				<div class="commonCd-register">
					<div class="col-1">
						<input id="cdRegister" type="button" value="등록">
					</div>
					<div class="col-1">
						<select id="searchKind">
							<option value="option1">공통코드</option>
							<option value="option2">상세공통코드</option>
							<option value="option3">상세코드명</option>
						</select>
					</div>
					<div class="col-3">
						<input type="text" id="codeDetailSearchWord" placeholder="검색어로 조회">
					</div>
					<div class="col-1">
						<button id="codeDetailSearch" type="button">조회</button>
					</div>
				</div>
					<div id="commonTable">
						<table id="dataTable">
							<thead>
								<tr class="project_table_tr">
									<th>순번</th>
									<th>공통코드</th>
									<th>공통코드명</th>
									<th>상세공통코드</th>
									<th>상세코드명</th>
									<th>사용여부</th>
									<th>정렬순번</th>
								</tr>
							</thead>
							<tbody id="commonDetailTableBody">
								<tr>
									<td></td>
									<td></td>
									<td></td>
								</tr>
							</tbody>
						</table>
					</div>
			</section>
		</div>
	</div>
</body>
</html>