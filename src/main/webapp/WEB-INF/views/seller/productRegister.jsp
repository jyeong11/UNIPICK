<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>UNIPICK</title>
<!-- 기본 스크립트 및 스타일 -->
<script
	src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/public/fontawesome/all.min.css" />
<script
	src="${pageContext.request.contextPath}/resources/public/fontawesome/all.min.js"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&family=Nunito:wght@200..1000&display=swap"
	rel="stylesheet">
<!-- 페이지 전용 CSS -->
<link
	href="${pageContext.request.contextPath}/resources/public/css/sb-admin-2.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/resources/public/css/adm.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/resources/public/vendor/datatables/dataTables.bootstrap4.min.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/resources/public/vendor/datatables/datatables.min.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/resources/css/seller/productRegister.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/resources/css/seller/product.css"
	rel="stylesheet">
<!-- TOAST UI Editor -->
<link rel="stylesheet"
	href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />
<script
	src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
<link rel="stylesheet"
	href="https://uicdn.toast.com/tui-color-picker/latest/tui-color-picker.min.css" />
<link rel="stylesheet"
	href="https://uicdn.toast.com/editor-plugin-color-syntax/latest/toastui-editor-plugin-color-syntax.min.css" />
<script
	src="https://uicdn.toast.com/tui-color-picker/latest/tui-color-picker.min.js"></script>
<script
	src="https://uicdn.toast.com/editor-plugin-color-syntax/latest/toastui-editor-plugin-color-syntax.min.js"></script>

<script>
	var contextPath = '${pageContext.request.contextPath}';
</script>
<!-- 페이지 전용 JS (외부 파일로 분리) -->
<script
	src="${pageContext.request.contextPath}/resources/js/seller/productRegister.js"></script>

<link rel="icon"
	href="${pageContext.request.contextPath }/resources/images/favicon.png">
</head>
<body id="page-top">
	<div id="wrapper">
		<jsp:include page="../inc/sellerSidebar.jsp" />
		<div id="content-wrapper" class="d-flex flex-column">
			<!-- Main Content -->
			<div id="content">
				<div>
					<jsp:include page="../inc/sellerTopbar.jsp"></jsp:include>
				</div>
				<div class="container-fluid">
					<div class="row">
						<div class="col-lg-12">
							<div class="card shadow mb-4">
								<div class="card-header py-3">
									<h5 class="m-0 font-weight-bold" id="h5css">상품 등록</h5>
									<input type="hidden" id="sessionUserId"
										value="${session.getId() }">
								</div>
								<div class="card-body">
									<section class="item-regi">
										<form action="productInsert" id="productRegist" method="post"
											enctype="multipart/form-data">
											<!-- 상품 이미지 업로드 영역 -->
											<section class="item-regi-img">
												<div class="card_head">
													<h2 class="item-regi-name">상품이미지</h2>

													<!-- TODO -->
													<%--                           <img src="${pageContext.request.contextPath}/resources/images/banner1.jpg"> --%>

													<h2 class="item-thumb-description">첫번째 상품 이미지는 대표썸네일로
														등록됩니다.</h2>
												</div>
												<div class="item-thumb-group">
													<c:forEach var="i" begin="1" end="10">
														<div class="item-thumb">
															<button type="button" class="item-thumb-upload"
																data-index="${i}">
																<img src="/resources/img/product-thumb-no.jpg"
																	id="item-thumb-preview${i}">
															</button>
															<input type="file" class="item-thumb-upload-btn"
																id="item-thumb-upload-btn${i}" name="imageFiles"
																multiple>
														</div>
													</c:forEach>
												</div>
											</section>
											<!-- 상품 정보 입력 영역 -->
											<section class="item-regi-section">
												<h2 class="item-regi-name">상품명</h2>
												<div class="item-regi-box">
													<input type="text" name="product_title"
														class="item-regi-title-text" id="item-regi-title-text"
														maxlength="100">
												</div>
												<h6 class="item-regi-name-byte" id="item-regi-name-byte">(0
													/ 100)</h6>
											</section>
											<section class="item-regi-section">
												<h2 class="item-regi-name">상품코드</h2>
												<div class="item-regi-box">
													<input type="text" name="product_code"
														class="item-regi-title-text" id="item-regi-code-text"
														maxlength="20">
												</div>
												<h6 class="item-regi-name-byte" id="item-regi-code-byte">(0 / 20)</h6>
											</section>
											<section class="item-regi-section">
												<h2 class="item-regi-name">상품설명</h2>
												<div id="editor"></div>
												<input type="hidden" id="prd_ct" name="prd_ct" value="">
<!-- 												<h6 class="item-regi-description-byte" -->
<!-- 													id="item-regi-description-byte">(0 / 2000)</h6> -->
											</section>
											<!-- 카테고리 선택 영역 -->
											<section class="item-regi-category">
												<h6 class="item-regi-category-name">카테고리</h6>
												<select class="item-regi-category-box"
													name="product_category" id="product_category"></select> <select
													class="item-regi-category-box" name="product_category_sub"
													id="product_category_sub"></select>
											</section>
											<!-- 배송비 설정 영역 -->
											<section class="item-regi-price">
												<h6 class="item-regi-name">배송비 설정</h6>
												<div class="item-regi-price-box">
													<div class="item-regi-price-number">
														<input type="number" name="delivery_price"
															id="delivery_price" placeholder="배송비를 입력해주세요." required>
														<input type="hidden" name="delivery_status"
															id="dilivery_status" value="0">
													</div>
												</div>
											</section>
											<!-- 가격 설정 영역 -->
											<section class="item-regi-price">
												<h6 class="item-regi-name">상품 가격 설정</h6>
												<div class="item-regi-price-box">
													<div class="item-regi-price-number">
														<input type="number" id="list_price"
															name="product_shipping_fee" placeholder="정가를 입력해주세요."
															required>
														<div>
															<input type="number" id="sale_price" name="product_price"
																placeholder="판매가를 입력해주세요." required>
														</div>
														<input type="hidden" name="product_discount_status" id="discount_status" value="0">
													</div>
												</div>
											</section>
											<section class="item-regi-price">
											 <h6 class="item-regi-name">뱃지 설정</h6>
												<div class="item-regi-badge-box">
													<select class="item-regi-badge-box" name="product_badge[]" id="product_badge"></select>
												</div>
											</section>
											<section class="item-regi-stock">
											 <h6 class="item-regi-name">옵션 설정</h6>
												<div id="option-container">
													<div class="option-row"
														style="display: flex; align-items: center; gap: 10px; margin-bottom: 10px;">
														<input type="color" name="color_number[]" class="color-picker" required>
														<input type="text" name="color_name[]" class="color-name" id="color_name" required>
														<select name="size_option[]" class="size-select" id="product_size"></select>
														<input type="number" name="stock_number[]" class="stock-number" id="stock_number" placeholder="재고 수량을 입력해주세요." required>
													</div>
												</div>
												<button type="button" id="add-option" class="btn btn-sm btn-outline-primary">추가</button>
											</section>
											<div class="item-regi-submit-group">
												<input type="button" class="item-backpage" onclick="history.back()" value="뒤로 가기">
												<input type="submit" id="createProduct" class="item-submit" value="상품 등록">
											</div>
										</form>
									</section>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- Footer -->
				<jsp:include page="../inc/sellerfooter.jsp"></jsp:include>
			</div>
		</div>
	</div>
	<!-- Bootstrap 및 기타 플러그인 JS -->
	<script
		src="${pageContext.request.contextPath}/resources/public/vendor/jquery/jquery.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/public/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/public/vendor/jquery-easing/jquery.easing.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/public/js/sb-admin-2.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/public/vendor/chart.js/Chart.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/public/vendor/datepicker/moment.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/public/vendor/datatables/jquery.dataTables.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/public/vendor/datatables/dataTables.bootstrap4.min.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/public/js/index.js"></script>