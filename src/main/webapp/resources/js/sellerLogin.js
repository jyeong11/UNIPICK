$(function () {
	
	$("button[type='submit']").on("click", function () {
	    login();
    });
	
	
	
});

// 로그인
function login() {
	    let sellerId = document.getElementById("sellerId").value.trim();
	    let sellerPw = document.getElementById("sellerPw").value.trim();
	
	    if (sellerId === "" || sellerPw === "") {
	        alert("아이디와 비밀번호를 입력해주세요.");
	        return;
	    }
	
	    let loginData = {
	        sellerId: sellerId,
	        sellerPw: sellerPw
	    };
		
	    $.ajax({
	        type: "POST",
	        url: seller/login,
	        data: JSON.stringify(loginData),
	        contentType: "application/json; charset=UTF-8",
	        dataType: "json",
	        success: function(res) {
	            if (res.success) {
	                window.location.href = "sellerMain.jsp";
	            } 
	            alert("로그인 실패: " + res.message);
	        },
	        error: function(xhr, status, error) {
	            console.error("로그인 요청 실패", error);
	            alert("서버 오류가 발생했습니다.");
	        }
	    });
	}