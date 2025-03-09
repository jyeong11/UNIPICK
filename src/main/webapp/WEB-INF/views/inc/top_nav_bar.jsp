<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- 모바일 nav -->
<nav class="navbar navbar-expand-lg navbar-light navbar-custom" id="mnav">
    <div class="d-flex align-items-center w-100 px-3" id="mdiv">
        <a class="text-center text-white" href="/HRIS" id="mnavn">Team Ascend</a>
           <!-- 햄버거 버튼 -->
      <button class="navbar-toggler ms-auto" type="button" id="toggleButton">
      <span class="navbar-toggler-icon" id="mnavi"></span>
    </button>
    </div>
</nav>


<nav class="navbar navbar-expand-lg navbar-light bg-light">
	<div class="container-fluid justify-content-center" id="topmain">
		<div class="dropdown col-md-auto d-inline-block">
			<a href="employeelist" class="nav-link px-2  fs-6 fw-bold project_font_color">인사관리</a>
		</div>
		<div class="dropdown col-md-auto d-inline-block">
			<a href="salarylist" class="nav-link px-2  fs-6 fw-bold project_font_color">급여관리</a>
		</div>
		<div class="dropdown col-md-auto d-inline-block">
			<a href="CommuteList" class="nav-link px-2  fs-6 fw-bold project_font_color">근태관리</a>
		</div>
		<div class="dropdown col-md-auto d-inline-block">
			<a href="DocumentsList" class="nav-link px-2  fs-6 fw-bold project_font_color">전자결재</a>
		</div>
		<div>
			<a href="noticelist" class="nav-link px-2  fs-6 fw-bold project_font_color">그룹웨어</a>
		</div>
		
			<div class="col-md-4 d-flex align-items-center gap-2" id="test">
<!-- 		<button type="button" class="btn btn-primary me-2 mx-2" -->
<!-- 			onclick="location.href='loginform'">로그인</button> -->
		<c:choose>
			<c:when test="${empty sessionScope.sId}"> <%-- 미 로그인 시 --%>
			<button type="button" class="btn me-2 mx-2 btn_main_color"
				onclick="location.href='loginform'">로그인</button>
			</c:when>
			<c:otherwise> <%-- 로그인 한 사용자일 경우 --%>
<!-- 				<a href="javascript:void(0)" onclick="logout()">로그아웃</a> -->
				<button type="button" class="btn  me-2 mx-2 btn_main_color"
				onclick="logout()">로그아웃</button>
			</c:otherwise>
		</c:choose>
	</div>
	</div>


</nav>
<script>
document.addEventListener('DOMContentLoaded', function() {
  const toggleButton = document.getElementById('toggleButton');
  const navMenu = document.getElementById('topmain');

  toggleButton.addEventListener('click', function() {
	  topmain.classList.toggle('show');
  });
});
</script>

<script>
	function logout() {
		if(confirm("로그아웃하시겠습니까?")) {
			location.href = "EmployeeLogout";
		}
	}
</script>