$(document).ready(function(){
    var timerInterval; // 타이머 간격
    var timeLeft = 600; // 10분 (600초)

    // 휴대폰 번호 인증 요청
    $("#sendOtpBtn").click(function(){
        var phone = $("#phoneInput").val().trim().replace(/[^0-9]/g, ''); // 전화번호에서 숫자만 남기기
        if(phone === ""){
            alert("휴대폰 번호를 입력해주세요.");
            return;
        }
        $.ajax({
            url: "/UNIPICK/api/otp/send",
            method: "POST",
            data: { phone: phone },
            success: function(response){
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
    
    var phone = $("#phoneInput").val().trim().replace(/[^0-9]/g, ''); // 전화번호에서 숫자만 남기기
    var otp = $("#otpInput").val().trim();
    if(phone === "" || otp === ""){
        alert("휴대폰 번호와 인증번호를 모두 입력해주세요.");
        // 입력 오류 발생 시 버튼 다시 활성화
        $("#verifyOtpBtn").prop("disabled", false);
        return;
    }
    $.ajax({
        url: "/UNIPICK/api/otp/verify",
        method: "POST",
        data: { phone: phone, otp: otp },
        success: function(response){
            alert("인증완료");
            // 인증 완료 후 세션에 휴대폰 번호 저장
            $.ajax({
                url: "buyerAuthentication",
                method: "POST",
                data: { phone: phone }, // 서버로 전화번호 전송
                success: function(response){
                    // 인증 완료 후 buyerEmail.jsp 페이지로 이동
                    window.location.href = "buyerEmail";
                },
                error: function(xhr){
                    alert("전화번호 세션 저장 실패: " + xhr.responseText);
                    // 실패 시 버튼 다시 활성화할 수 있음
                    $("#verifyOtpBtn").prop("disabled", false);
                }
            });
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
        timeLeft = 600; // 10분으로 초기화
        $("#timer").text("10:00"); // 타이머 UI 리셋

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
