<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script>
<!-- 구글 폰트 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">

<!-- css -->
<link href="${pageContext.request.contextPath }/resources/css/public.css" rel="stylesheet" type="text/css">
<%-- <link href="${pageContext.request.contextPath }/resources/css/commonCode.css" rel="stylesheet" type="text/css"> --%>
<link href="${pageContext.request.contextPath }/resources/css/admin/adminMain.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/admin/cmcd.css" rel="stylesheet" type="text/css">

<!-- favicon -->
<link rel="icon"
	href="${pageContext.request.contextPath }/resources/images/favicon.png">
<!--  js -->
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.1.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/admin/commonCodeLevel.js"></script>
<title>유니픽 관리자</title>
</head>
<body>
	<div id="admin-container">
		<div>
			<a href="admin">
		       	<img src="${pageContext.request.contextPath}/resources/images/로고 가로.png" alt="로고" id="logo">
			</a>
		 </div>
		 <div class="login_div">
		 	<ul class="login_ul">
		 		<li><a href="javascript:void(0);" id="admin_id">admin</a></li>
		 		<li class="logout_btn"><a href="#" id="logout">로그아웃</a></li>
		 	</ul>
		 </div>
	</div>
	<!-- Sidebar -->
	<div class="d-flex">
		<jsp:include page="../inc/adminSidebar.jsp"></jsp:include>

			<div class="container-fluid">
				<section class="section">
					<div class="card shadow mb-4">
						<div class="card-header py-3">
							<h6 class="m-0 font-weight-bold">계층공통코드</h6>
						</div>
						<div class="card-body">
								<div class="common-top-div">
									<div class="top-btn">
										<input class="btn btn_main_color"
                                        data-bs-toggle="modal" data-bs-target="#exampleModal"
                                        id="btnModal" type="button"value="등록">
									</div>
									<div class="search-div">
										<div>
											<select id="searchKind">
												<option value="option1">공통코드</option>
												<option value="option2">코드명</option>
											</select>
										</div>
										<div>
											<input type="text" id="codeSearchWord" placeholder="검색어로 조회">
										</div>
										<div>
											<button id="codeSearch" class="btn btn-primary mb-3 btn_main_color" type="button">조회</button>
										</div>
									</div>
								</div>
								<div class="table-responsive">
									<div id="commonTable">
										<table id="dataTable" class="table table-bordered">
											<thead>
												<tr class="project_table_tr">
													<th>순번</th>
													<th>공통코드</th>
													<th>코드명</th>
													<th>정렬순번</th>
													<th>사용여부</th>
												</tr>
											</thead>
											<tbody id="commonTableBody"></tbody>
										</table>
									</div>
								</div>
							</div>
							<!-- 						조회버튼 클릭시 모달창 뜸 -->
							<div class="modal fade" id="exampleModal" tabindex="-1"
								role="dialog" aria-labelledby="exampleModalLabel"
								aria-hidden="true">
								<div id="modal" class="modal-dialog modal-xl"
									role="document">
									<div class="modal-content">
										<div class="modal-header">공통코드 등록</div>
										<div class="modal-body">
											<div id="modal-con"></div>
										</div>
									</div>
								</div>
							</div>
						</div>
				</section>
			</div>
		</div>
</body>
</html>