<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script src="${pageContext.request.contextPath}/resources/js/buyer/buyerRecommendation.js"></script>
<link href="${pageContext.request.contextPath }/resources/css/buyer/buyerRecommendation.css" rel="stylesheet" type="text/css">
<div id="recommendation">
	<div class = "two">
		<h2>추천 상품</h2>
	</div>
	<div class="slider-wrapper">
	    <div class="slider-container">
	        <div class="slider"></div>
	    </div>
	    <div class="recommendation_btn">
	        <button id="rec_btn_prev" class="rec_btn"><</button>
	        <button id="rec_btn_next" class="rec_btn">></button>
	    </div>
	</div>
</div>