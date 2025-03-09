<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.1.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/left_menu_bar.js"></script> 
<nav class="navbar navbar-expand-lg navbar-dark flex-column" id="navsize">
	<div class="nav flex-column col-6">
	<div class="col-md-auto d-inline-block" style="width: 300px">
	<a class="text-center text-white" href="/HRIS" id="nav_a">Team Ascend</a>
	</div>
		<hr class="border border-white border-2 opacity-90" style="width: 170px">
		<div class="dropdown col-md-auto d-inline-block dropend">
			<a href="employeelist" class="nav-link px-2 text-white fs-6 fw-bold" data-bs-toggle="dropdown" aria-expanded="false" id="nav">
			<i class="fa-solid fa-address-card text-white" id="iconleft"></i>
			인사관리<i class="fa fa-solid fa-caret-right" id="iconright"></i></a>
			<ul class="dropdown-menu">
				<li><a class="dropdown-item" href="employeelist">인사현황</a></li>
				<li><a class="dropdown-item" href="employeeregist">인사등록</a></li>
				<li><a class="dropdown-item" href="employeechart">조직도</a></li>
			</ul>
		</div>
		<hr class="border border-white border-1 opacity-80" style="width: 150px">
		<div class="dropdown col-md-auto d-inline-block dropend">
			<a href="salarylist" class="nav-link px-2 text-white fs-6 fw-bold" data-bs-toggle="dropdown" aria-expanded="false" id="nav">
			<i class="fa-solid fa-money-check-dollar text-white" id="iconleft"></i>급여관리<i class="fa fa-solid fa-caret-right" id="iconright"></i></a>
			<ul id="SalMenuList" class="dropdown-menu"></ul>
		</div>
		<hr class="border border-white border-1 opacity-80" style="width: 150px">
		<div class="dropdown col-md-auto d-inline-block dropend">
			<a href="CommuteRegist" class="nav-link px-2 text-white fs-6 fw-bold" data-bs-toggle="dropdown" aria-expanded="false" id="nav">
			<i class="fa fa-regular fa-calendar-check" id="iconleft"></i>근태관리<i class="fa fa-solid fa-caret-right" id="iconright"></i></a></a>
			<ul id="ComMenuList" class="dropdown-menu">
			</ul>
		</div>
		<hr class="border border-white border-1 opacity-80" style="width: 150px">
		<div class="dropdown col-md-auto d-inline-block dropend">
			<a href="DocumentsList" class="nav-link px-2 text-white fs-6 fw-bold" data-bs-toggle="dropdown" aria-expanded="false" id="nav">
			<i class="fa fa-solid fa-file-signature text-white" id="iconleft"></i>전자결재<i class="fa fa-solid fa-caret-right" id="iconright"></i></a>
			<ul class="dropdown-menu" id="DocmenuList">
			</ul>
		</div>
		<hr class="border border-white border-1 opacity-80" style="width: 150px">
		<div class="dropdown col-md-auto d-inline-block dropend">
			<a href="notice" class="nav-link px-2 text-white fs-6 fw-bold" data-bs-toggle="dropdown" aria-expanded="false" id="nav">
			<i class="fa-solid fa-briefcase text-white" id="iconleft"></i>그룹웨어<i class="fa fa-solid fa-caret-right" id="iconright"></i></a>
			<ul class="dropdown-menu">
				<li><a class="dropdown-item" href="noticelist">공지사항</a></li>
			</ul>
		</div>
		<!-- 보안등급 4만 조회 가능 -->
		<c:choose>
			<c:when test="${sessionScope.sLv eq 4}">
				<hr class="border border-white border-1 opacity-80" style="width: 150px">
				<div class="dropdown col-md-auto d-inline-block dropend">
					<a href="commoncode" class="nav-link px-2 text-white fs-6 fw-bold" data-bs-toggle="dropdown" aria-expanded="false" id="nav">
					<i class=" fa fa-brands fa-codepen text-white" id="iconleft"></i>공통코드<i class="fa fa-solid fa-caret-right" id="iconright"></i></a>
					<ul class="dropdown-menu">
						<li><a class="dropdown-item" href="commonCode">공통코드관리</a></li>
						<li><a class="dropdown-item" href="commonCodeDetail">상세공통코드관리</a></li>
					</ul>
				</div>
			</c:when>
		</c:choose>
		
		<hr class="border border-white border-1 opacity-80" style="width: 150px">
		<div class="dropdown col-md-auto d-inline-block dropend">
			<a href="https://w1736239213-tt4445536.slack.com/" class="nav-link px-2 text-white fs-6 fw-bold" data-bs-toggle="dropdown" aria-expanded="false" id="nav">
			<i class="fa fa-solid fa-file text-white" id="iconleft"></i>팀프로젝트<i class="fa fa-solid fa-caret-right" id="iconright"></i></a>
			<ul class="dropdown-menu">
				<li><a class="dropdown-item" href="https://w1736239213-tt4445536.slack.com/">슬랙 바로가기</a></li>
				<li><a class="dropdown-item" href="https://docs.google.com/spreadsheets/d/1uG6Buc1c8-BZqCR_UgGVecBvl7h9BtEhK5sNx3tFmzA/edit?usp=sharing">엑셀 바로가기</a></li>
				<li><a class="dropdown-item" href="noticetest">테스트</a></li>
			</ul>
		</div>
		
	</div>
</nav>
	