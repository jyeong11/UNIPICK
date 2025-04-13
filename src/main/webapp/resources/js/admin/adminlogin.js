$(function() {
	
	// 페이지 로드 시 쿠키에서 저장된 아이디 불러오기
    let savedAdminId = getCookie("rememberedAdminId");
    if (savedAdminId) {
        $("#admId").val(savedAdminId);
        $("#rememberId").prop("checked", true); // 체크박스도 체크 상태로 유지
    }
	$("button[type='submit']").on("click", function () {
	    login();
	})
	
	// 로그인
	function login() {
	    let admId = document.getElementById("admId").value.trim();
	    let admPw = document.getElementById("admPw").value.trim();
		let rememberMe = $("#rememberId").prop("checked");
	
	    if (admId === "" || admPw === "") {
	        alert("아이디와 비밀번호를 입력해주세요.");
	        return;
	    }
	    let loginData = {
	        admId: admId,
	        admPw: admPw,
			rememberMe: rememberMe
	    };
		// 아이디 기억하기 체크 시 쿠키 저장
	    if (rememberMe) {
	        setCookie("rememberedAdminId", admId, 30); // 30일 유지
	    } else {
	        deleteCookie("rememberedAdminId");
	    }
			
	    $.ajax({
	        type: "POST",
	        url: "adminlogin",
	        data: JSON.stringify(loginData),
	        contentType: "application/json; charset=UTF-8",
	        dataType: "json",
	        success: function(res) {
				if(res.success){
					window.location.href = "admin";
				} else {
					alert(res.msg);
				}
	        },
	        error: function(xhr, status, error) {
            	alert("서버 오류가 발생했습니다.");
	        }
	    });
	}

	// 쿠키 설정 함수
	function setCookie(name, value, days) {
	    let expires = "";
	    if (days) {
	        let date = new Date();
	        date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
	        expires = "; expires=" + date.toUTCString();
	    }
	    document.cookie = name + "=" + value + "; path=/" + expires;
	}
	
	// 쿠키 가져오는 함수
	function getCookie(name) {
	    let nameEQ = name + "=";
	    let ca = document.cookie.split(';');
	    for (let i = 0; i < ca.length; i++) {
	        let c = ca[i];
	        while (c.charAt(0) === ' ') c = c.substring(1, c.length);
	        if (c.indexOf(nameEQ) === 0) return c.substring(nameEQ.length, c.length);
	    }
	    return null;
	}
	
	// 쿠키 삭제 함수
	function deleteCookie(name) {
		// 쿠키는 만료 날짜를 과거로 하면 삭제됨!
	    document.cookie = name + "=; path=/; expires=Thu, 01 Jan 1970 00:00:00 UTC"; 
	}
	
});

