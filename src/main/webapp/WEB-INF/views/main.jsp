<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%-- 외부 CSS 파일 (resources/css/default.css) 연결하기  --%>
<%-- 클라이언트가 요청할 외부 자원 접근을 위한 경로 지정 시 컨텍스트 루트 기준이 아닌 서버 상의 루트 기준으로 탐색 --%>
<link href="${pageContext.request.contextPath }/resources/css/default.css" rel="stylesheet" type="text/css">
</head>
<body>
	<header>
		<jsp:include page="/WEB-INF/views/inc/top.jsp"/>	
	</header>	
	
	<article>
		<h1>HRIS 인사관리 시스템</h1>
		
		
	</article>
	
	<footer>
		<jsp:include page="/WEB-INF/views/inc/bottom.jsp"/>	
	</footer>
	
	
	
	
</body>
</html>