<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>유니픽</title>
<!-- 구글 폰트 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap"
	rel="stylesheet">

<!-- Font Awesome 5 Icons -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css"
	integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<!-- js -->
<script
	src="${pageContext.request.contextPath }/resources/js/jquery-3.7.1.js"></script>
<script
	src="${pageContext.request.contextPath }/resources/js/buyer/sellerShopDetail.js"></script>

<!-- css -->
<link
	href="${pageContext.request.contextPath }/resources/css/public.css"
	rel="stylesheet" type="text/css">
<link
	href="${pageContext.request.contextPath }/resources/css/buyer/buyerMenuBar.css"
	rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath }/resources/css/top.css"
	rel="stylesheet" type="text/css">
<link
	href="${pageContext.request.contextPath }/resources/css/footer.css"
	rel="stylesheet" type="text/css">
<link
	href="${pageContext.request.contextPath }/resources/css/buyer/sellerShopDetail.css"
	rel="stylesheet" type="text/css">

<!-- favicon -->
<link rel="icon"
	href="${pageContext.request.contextPath }/resources/images/favicon.png">
</head>
<body>
	<%
	String query = request.getParameter("query");
	%>
	<div id="topNav">
		<jsp:include page="../inc/top.jsp"></jsp:include>
	</div>

	<div>
		<jsp:include page="../inc/buyerMenuBar.jsp"></jsp:include>
	</div>
	<!-- 	내용삽입 -->
	<div id="content">
		<div class="content-container">
<!-- 			배경사진 -->
			<div class="background">
				<img src="${pageContext.request.contextPath }${selList[0].sel_bp}">
			</div>
<!-- 			프로필사진 -->
			<div class="store-img">
				<img src="${pageContext.request.contextPath }${selList[0].sel_pp}">
			</div>
		</div>
		<div class="selIfo">
			<div class="sel_nm">${selList[0].sel_nm }</div>
			<div class="sel_if">${selList[0].sel_if }</div>
			<div class="sel-search">
				<input type="text" id="searchInput" placeholder="검색어 입력">
				<i class="fa fa-solid fa-magnifying-glass" id="searchBtn"></i>
			</div>
		</div>
		<div class="content">
			<div class="category-menu">
				<h2>CATEGORIES</h2>
			    <ul>
			    	<li class="categories">
			                <a href="#" class="category" data-category="All">전체</a>
			            </li>
			        <c:forEach var="code" items="${cateList}">
			            <li class="categories">
			                <a href="#" class="category" data-category="${code.lev_cd}">
			                    ${code.lev_nm}
			                </a>
			            </li>
			        </c:forEach>
			    </ul>
			</div>
			<div id="imageGallery" class="image-gallery">
			    <c:forEach var="sel" items="${selList}">
			        <div class="image-item" data-id="${sel['prd_cd']}" data-sel="${sel['sel_nm']}">
			        	<div class="prd-img">
			            	<img src="${pageContext.request.contextPath}${sel['fil_pt']}" alt="${sel['prd_nm']}"/>
			            	<c:choose>
			            		<c:when test="${sel['buy_em'] == null}">
			            			<i class="fa-regular fa-heart heart" data-value="${sel['prd_cd']}"></i>
			            		</c:when>
			            		<c:otherwise>
							        <i class="fa-solid yellow fa-heart heart" data-value="${sel['prd_cd']}"></i>
							    </c:otherwise>
			            	</c:choose>
			            </div>
			            <div class="sel-nm">${sel['sel_nm']}</div>
			            <div class="prd-nm">${sel['prd_nm']}</div>
			            <div class="pr">
			            	<div class="dc">${sel['dc']}</div>
			            	<div class="prd-sp">${sel['prd_sp']}원</div>
			        	</div>
			        </div>
			    </c:forEach>
			</div>
		</div>
	</div>
	<div id="footer">
		<jsp:include page="../inc/footer.jsp"></jsp:include>
	</div>
	<script>
    	let contextPath = "${pageContext.request.contextPath}";
	</script>
</body>
</html>