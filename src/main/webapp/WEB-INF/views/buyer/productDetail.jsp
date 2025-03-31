<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<title>${prd.prd_nm}</title>
<!-- 구글 폰트 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">

<!-- Font Awesome 5 Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg==" crossorigin="anonymous" referrerpolicy="no-referrer" />

<!-- js -->
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.1.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/buyer/productDetail.js"></script>

<!-- css -->
<link href="${pageContext.request.contextPath }/resources/css/public.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/buyer/buyerMenuBar.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/top.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/footer.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/buyer/productDetail.css" rel="stylesheet" type="text/css">
<!-- favicon -->
<link rel="icon" href="${pageContext.request.contextPath }/resources/images/favicon.png">
</head>
<body>
	<div id="topNav">
		<jsp:include page="../inc/top.jsp"></jsp:include>
	</div>
	
	<div>
		 <jsp:include page="../inc/buyerMenuBar.jsp"></jsp:include>
	</div>
	 <div class="product-container">
    <!-- 왼쪽 상품 이미지 -->
	    <div class="product-image">
			<c:forEach var="image" items="${prdImg}">
				<img src="${pageContext.request.contextPath}/resources/${image}" class="product-img">
			</c:forEach>
		</div>
		<div id="product">
		    <div class="product-info">
		        <div><a href="sellerShopDetail?sel_nm=${prd.sel_nm}"><i class="fa-solid fa-house"></i>${prd.sel_nm}</a></div>
		        <h2>${prd.prd_nm}</h2>
		        <div id="price">
		        	<p><span class="dc">${prd.dc}</span></p>
			        <p><span class="discount">${prd.prd_sp}원</span></p>
			        <p><span class="original-price">${prd.prd_op}원</span></p>
				</div>
		        <select id="color" onchange="loadSize()">
					<option>[색상]을 선택하세요.</option>
					<c:forEach var="option" items="${optionList}">
						<option value="${option.clr_nm}">${option.clr_nm}</option>
					</c:forEach>
				</select>
		
		        <select id="size" disabled>
				    <option>[사이즈]를 선택하세요.</option>
				</select>
				<div id="selected-option" class="option-box" style="display: none;">
				    <span id="option-text"></span>
				</div>
				<div id="total-price" class="option-box" style="display: none;">
				    <span class="buy-total">결제 예상 금액:</span>
				    <span id="price-text"></span>
				</div>
		        <div class="button-container">
		           <button id="buyButton">구매하기</button>
		           <button class="cart-btn">
					    <i class="cart fa fa-solid fa-cart-shopping"></i>
					</button>
					<button class="wishlist-btn">
					    <i class="fa-regular fa-heart"></i>
					</button>
		        </div>
					<button id="scrollToTop">↑</button>
					<button id="scrollToBottom">↓</button>
		    	</div>
		    </div>
		 </div>
		    <div id="prdDetailBar">
		    	<ul>
				    <li><a href="#detailEp">상품정보</a></li>
				</ul>
				<ul>
				    <li><a href="#reviews">리뷰</a></li>
				</ul>
				<ul>
				    <li><a href="#qa">문의</a></li>
				</ul>
		 	</div>
		 	<div id="detailEp">
		 		<c:forEach begin="1" end="5">
		    		<img src="${pageContext.request.contextPath }/resources/images/favicon_b.png" alt="1">
				</c:forEach>
			</div>
			<div id="moreItems" style="display: none;">
		        <c:forEach begin="6" end="10">
		            <img src="${pageContext.request.contextPath }/resources/images/favicon_b.png" alt="1">
		        </c:forEach>
    		</div>
	    	<button id="loadMoreBtn">상품 더보기 ↓</button>
	    	<section>
	    		<div id="selAnthor">
	    			<div id="selAnthorTitle">
	    				<p>${prd.sel_nm}의 다른 상품</p>
	    				<a href=""><span class="small-text">더보기 ></span></a>
	    			</div>
		    		<div id="selAnthorprd">
		    			<c:forEach begin="6" end="10">
			            	<img src="${pageContext.request.contextPath }/resources/images/favicon_b.png" alt="1">
			        	</c:forEach>
		    		</div>
		    		<div id="picks">
		    			<div id="pickTitle">
		    				<p>당신을 위한 추천상품</p>
		    				<a href=""><span class="small-text">더보기 ></span></a>
		    			</div>
		    			<div id="pickPrd">
			    			<c:forEach begin="6" end="10">
				            	<img src="${pageContext.request.contextPath }/resources/images/favicon_b.png" alt="1">
				        	</c:forEach>
		    			</div>
		    		</div>
		    		<div id="reviews">
		    			<div id="reviewsTitle">
							<p>리뷰</p>
							<a href=""><span class="small-text">전체보기 ></span></a>		    			
		    			</div>
		    		</div>
		    		<div id="qa">
		    			<div id="qaTitle">
							<p>문의</p>
		    			</div>
		    			<div id="qaLogo">
		    				<i class="fa-solid fa-tags"></i>
		    			</div>
		    			<div id="qaConment">
			    			<p class="cmTitle">상품에 대해 궁금한 것이 있으신가요?</p>
			    			<p class="cmcomend"> 상품 관련 문의는
			    				<strong>판매자가 상세히 답변</strong>
			    				드립니다.
			    				<br>
			    				답변은 앱의 마이페이지 > 문의 내역 에서 확인하실 수 있습니다.
			    			</p>
			    			<button class="qaBtn">
			    				<span>상품 문의하기</span>
			    			</button>
		    			</div>
		    		</div>
		    		<div id="selCs">
		    			<div id="selCsTitle">
		    				<p>판매자 고객센터</p>
		    			</div>
		    			<div>
			    			<div>
			    				<span class="tie">운영시간</span>
			    				<span>10~12</span>
			    			</div>
			    			<div>
			    				<span class="tie">고객센터번호</span>
			    				<span>10</span>
			    			</div>
		    			</div>
	    			</div>
	    		</div>
	    	</section>
	    	
	
	<div id="footer">
		<jsp:include page="../inc/footer.jsp"></jsp:include>
	</div>
	<script>
    	var prdCd = "${prd.prd_cd}";
        var contextPath = "${pageContext.request.contextPath}";
	</script>
</body>
</html>