<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<!-- css -->
<link href="${pageContext.request.contextPath }/resources/css/public.css" rel="stylesheet" type="text/css">
<!-- 구글 폰트 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">

<!-- favicon -->
<link rel="icon" href="${pageContext.request.contextPath }/resources/images/favicon.png">
<!--  js -->
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.1.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/commoncodedetail.js"></script>
<title>팀어센드 : 상세공통코드</title>

	
</head>
<body>
	<div class="container-fluid">
		<section class="section">
			<div class="card shadow mb-4">
				<div class="card-header py-3">
					<h6 class="m-0 font-weight-bold">상세공통코드</h6>
				</div>
				<div class="card-body">
					<div class="d-flex align-items-start gap-4">
							<div class="col-1">
								<input class="btn btn_main_color"
	                                     data-bs-toggle="modal" data-bs-target="#exampleModal"
	                                     id="btnModal" type="button" class="btn btn_main_color" value="등록">
							</div>
							<div class="col-1" style="margin-left: 750px">
										<select class="form-select" id="searchKind">
											<option value="option1">공통코드</option>
											<option value="option2">상세공통코드</option>
											<option value="option3">상세코드명</option>
										</select>
									</div>
									<div class="col-3">
										<input type="text" id="codeDetailSearchWord" class="form-control"
											placeholder="검색어로 조회">
									</div>
									<div class="col-1">
										<button id="codeDetailSearch"
											class="btn btn-primary mb-3 btn_main_color" type="button">조회</button>
									</div>
								</div>
								<div class="table-responsive">
									<div id="commonTable">
										<table id="dataTable" class="table table-bordered">
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
								</div>
						</div>
			</div>
			</section>
		</div>
</body>
</html>