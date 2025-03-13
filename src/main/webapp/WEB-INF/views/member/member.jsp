<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>UNIPICK</title>
</head>
<body class="d-flex align-items-center py-4 bg-body-tertiary">
<main class="form-signin w-100 m-auto">
		<form action="EmployeeLogin" method="post" id="loginForm">
			<img class="mb-4" src="./resources/images/logo.png" alt="" id="logo">
			<div class="form-floating">
				<input type="text" class="form-control" name="emp_id"
					id="floatingInput" value="${cookie.rememberId.value}"
					placeholder="사원번호" required> <label for="floatingInput">사원번호</label>
			</div>
			<div class="form-floating">
				<input type="password" class="form-control" name="emp_pw"
					id="floatingPassword" placeholder="비밀번호" required> <label
					for="floatingPassword">비밀번호</label>
			</div>
			<div class="form-check text-start my-3">
				<input class="form-check-input" type="checkbox" name="rememberId"
					id="flexCheckDefault"
					<c:if test="${not empty cookie.rememberId.value}">checked</c:if>>

				<label class="form-check-label" for="flexCheckDefault"> 사원번호
					기억하기 </label>
			</div>
			<button class="btn btn_main_color w-100 py-2" type="submit">로그인</button>
			<br> <br>
			<div>
				<a href="empInfo" class="text-body-tertiary">사원번호 찾기</a>
				<a href="empPass" class="text-body-tertiary">비밀번호 찾기</a>
			</div>
			<p class="mt-1 mb-3 text-body-secondary" align="center">TEAM
				ASCEND 1ST PROJECT 2025</p>
		</form>
	</main>
</body>
</html>