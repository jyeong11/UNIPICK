$(document).ready(function(){
    var timerInterval; // 타이머 간격
    var timeLeft = 600; // 10분 (600초)

    // 휴대폰 번호 인증 요청
    $("#sendOtpBtn").click(function(){
        var phone = $("#phoneInput").val().trim().replace(/[^0-9]/g, '');
		var sel_id = $("#sel_id").val().trim();
		
        if(phone === "" || sel_id === "") {
            alert("아이디와 휴대폰 번호를 입력해주세요.");
            return;
        }
        $.ajax({
            url: "/UNIPICK/api/otp/send",
            method: "POST",
            data: { phone: phone },
            success: function(){
                alert("인증번호 전송");
                // OTP 입력란 활성화
                $("#otpInput").prop("disabled", false);  // OTP 입력란 활성화
                $("#verifyOtpBtn").prop("disabled", false); // 인증번호 확인 버튼 활성화
                startTimer(); // 타이머 시작
            },
            error: function(xhr){
                alert("인증번호 전송 실패: " + xhr.responseText);
            }
        });
    });

    $("#verifyOtpBtn").click(function(){
	    // 버튼 비활성화: 중복 클릭 방지
	    $("#verifyOtpBtn").prop("disabled", true);
	    
	    var phone = $("#phoneInput").val().trim().replace(/[^0-9]/g, '');
		var sel_id = $("#sel_id").val().trim();
	    var otp = $("#otpInput").val().trim();

	    if(phone === "" || otp === "" || sel_id === ""){
	        alert("입력칸을 모두 입력해주세요.");
	        // 입력 오류 발생 시 버튼 다시 활성화
	        $("#verifyOtpBtn").prop("disabled", false);
	        return;
    	}
	    $.ajax({
	        url: "/UNIPICK/api/otp/seller",
	        method: "POST",
	        data: { 
				phone: phone, 
				otp: otp,
				sel_id: sel_id
			},
	        success: function(res){
				$("#resultContainer").html(`
	                <div class="result-box">
	                    <p><strong>아이디:</strong>  ${res.sel_id}</p>
	                    <p><strong>비밀번호:</strong>  ${res.sel_pw}</p>
	                    <button id="homeBtn" class="home-button">로그인페이지로 이동</button>
	                </div>
	            `);
	             alert("인증이 완료되었습니다.");
	            
	        },
	        error: function(xhr){
	            alert("OTP 검증 실패: " + xhr.responseText);
	            // AJAX 에러 발생 시 버튼 다시 활성화
	            $("#verifyOtpBtn").prop("disabled", false);
	        }
	    });
	});


    // 타이머 시작 함수
    function startTimer(){
        // 타이머 초기화
        timeLeft = 180; // 10분으로 초기화
        $("#timer").text("3:00"); // 타이머 UI 리셋

        // 타이머 시작
        timerInterval = setInterval(function(){
            if(timeLeft <= 0){
                clearInterval(timerInterval);
                alert("인증 시간이 만료되었습니다.");
                // OTP 입력란 비활성화
                $("#otpInput").prop("disabled", true);
                $("#verifyOtpBtn").prop("disabled", true); // 인증번호 확인 버튼 비활성화
            } else {
                var minutes = Math.floor(timeLeft / 60);
                var seconds = timeLeft % 60;
                $("#timer").text(formatTime(minutes) + ":" + formatTime(seconds));
                timeLeft--;
            }
        }, 1000);
    }

    // 시간 포맷팅 함수 (2자리로 표시)
    function formatTime(time){
        return time < 10 ? "0" + time : time;
    }
});
