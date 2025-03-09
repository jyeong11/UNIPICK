<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<div id="top_menu">
	<h4>
		<a href="./">HOME</a> | 
		<c:choose>
			<c:when test="${empty sessionScope.sId}"> <%-- 미 로그인 시 --%>
				<a href="MemberLogin">로그인</a> | 
				<a href="MemberJoin">회원가입</a>
			</c:when>
			<c:otherwise> <%-- 로그인 한 사용자일 경우 --%>
				<a href="MemberInfo">${sessionScope.sId}</a> 님 | 
				<a href="javascript:void(0)" onclick="logout()">로그아웃</a>
				
				<%-- 만약, 세션 아이디가 "admin" 일 경우 [관리자페이지] 링크 추가 --%>
				<c:if test="${sessionScope.sId eq 'admin'}">
					| <a href="">관리자페이지</a>
				</c:if>
			</c:otherwise>
		</c:choose>
	</h4>
</div>
<hr>
<script>
	function logout() {
		// confirm() 함수 활용하여 "로그아웃하시겠습니까?" 질문을 통해
		// 확인 버튼 클릭 시 "MemberLogout" 페이지로 이동 처리
		if(confirm("로그아웃하시겠습니까?")) {
			location.href = "MemberLogout";
		}
	}
</script>

















