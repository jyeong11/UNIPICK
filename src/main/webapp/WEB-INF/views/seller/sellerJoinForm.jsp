<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- css -->
<link href="${pageContext.request.contextPath }/resources/css/seller/sellerJoinForm.css" rel="stylesheet" type="text/css">

<!-- 구글 폰트 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">

<!-- favicon -->
<link rel="icon" href="${pageContext.request.contextPath }/resources/images/favicon.png">

<!-- js -->
<script src="${pageContext.request.contextPath }/resources/js/jquery-3.7.1.js"></script>
<script src="${pageContext.request.contextPath }/resources/js/seller/sellerJoinForm.js"></script>

<title>유니픽 셀러</title>
</head>
<body>
	<div id="seller-join">
	<img src="${pageContext.request.contextPath}/resources/images/로고 가로.png" alt="로고" id="logo">
		<h3>입점 신청하기</h3>
	</div>
    <div id="signup-container">
        <form id="storeSignupForm" action="joinSucess" method="post" enctype="multipart/form-data" >
            <div id="join-title" class="input-group"><h2>유니픽 입점 정책</h2></div>
            <div class="content-tilte">계정 정보 입력</div>
            <div class="input-group">
                <label for="storeId">아이디 *</label>
                <input type="text" id="storeId" name="storeId" placeholder="6자리 이상 입력해주세요" >
                <button id="DuplicationCk" type="button">중복체크</button>
            </div>

            <div class="input-group">
                <label for="storePw">비밀번호  *</label>
                <input type="password" id="storePw" name="storePw" 
                placeholder="대문자, 특수문자 포함 6자리 이상 입력해주세요">
                <div><span id="pwMessage" class="message"></span></div> 
            </div>
            
            <div class="input-group">
                <label for="storePwCheck">비밀번호 확인  *</label>
                <input type="password" id="storePwCheck" name="storePwCheck">
                <div><span id="pwCheckMessage" class="message"></span></div>
            </div>
			
			<div class="content-tilte">쇼핑몰 정보 입력</div>
			<div class="input-group">
                <label for="storeNm">쇼핑몰 이름  *</label>
                <input type="text" id="storeNm" name="storeNm">
            </div>
            
            <div class="input-group">
                <label for="ceoNm">대표자 명  *</label>
                <input type="text" id="ceoNm" name="ceoNm">
            </div>
            
            <div class="input-group">
                <label for="brn">사업자등록번호  *</label>
                <input type="text" id="brn" name="brn">
            </div>
             <div class="input-group">
                <label for="storead">사업장주소  *</label>
                <input type="text" id="storead" name="storead">
            </div>
            <div class="input-group">
                <label for="businessLicense">사업자 등록증  *</label>
                <input type="file" id="businessLicense" name="businessLicense">
            </div>
            
            <div class="input-group">
                <label for="storeNumber">고객센터 번호  *</label>
                <input type="text" id="storeNumber" name="storeNumber">
            </div>
			
			<div class="content-tilte">쇼핑몰 담당자 정보 입력</div>
            <div class="input-group">
                <label for="phNm">이름  *</label>
                <input type="text" id="phNm" name="phNm">
            </div>

            <div class="input-group">
                <label for="phNumber">휴대전화  *</label>
                <input type="text" id="phNumber" name="phNumber" placeholder="010xxxxxxxx">
            </div>
            <div class="join-message">
            	"입점 신청 후 10일 내에 입점 가능 여부를 입력하신 번호로 안내드립니다."
            	<br>
            	"문의: 051) 803-0909, 평일 10:00-18:00(토/일 공휴일 휴무, 점심 13:00-14:00)"
            </div>
            <div class="input-group"><button type=submit>회원가입</button></div>
        </form>
    </div>
    <script>
		let btnSearchAddress = document.querySelector('#btnSearchAddress');
		btnSearchAddress.onclick = function(){
			
			new daum.Postcode({
				
				// 주소 검색 창에서 주소 검색 후 검색된 주소를 사용자가 클릭 시
				// oncomplete 이벤트에 의해 이벤트 뒤의 익명함수가 자동으로 호출됨
				// 사용자가 클릭한 주소 정보가 익명함수 파라미터 data 로 전달됨
				// => 주의! 이 익명함수는 개발자가 호출하는 것이 아니라
				//    API에 의해 자동으로 호출됨
				//    (어떤 동작 수행 후 자동으로 호출되는 함수를 콜백(callback) 함수라고 함)
				
		        oncomplete: function(data) {
					document.querySelector('#post_code').value = data.zonecode
					
					let addr = data.address;
					if (data.buildingName != "") {
						addr += " (" + data.buildingName + ")";
					}
					document.querySelector('#storead').value = addr;
		        }
		    }).open();
		}
	
	   
	</script>
</body>
</html>