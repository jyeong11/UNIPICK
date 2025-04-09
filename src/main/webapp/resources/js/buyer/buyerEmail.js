// 이메일 중복 검사 함수 정의
function checkEmail() {
    let email = $("#buy_em").val();
    let resultElement = $("#checkIdResult");

    // 이메일 유효성 검사 (정규식 사용)
    let emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
    
    if (email.length === 0) {
        resultElement.text("").css("color", "");
        return;
    }

    // 이메일 형식이 맞지 않으면 경고 메시지 표시
    if (!emailRegex.test(email)) {
        resultElement.text("올바른 이메일 형식이 아닙니다.").css("color", "red");
        return;
    }

    $.ajax({
        type: "POST",
        url: "checkEmail",
        data: { buy_em: email },
        success: function (response) {
            resultElement.text(response.exists ? "중복된 이메일입니다." : "사용 가능한 이메일입니다.")
                        .css("color", response.exists ? "red" : "green");
        },
        error: function () {
            resultElement.text("오류가 발생했습니다.").css("color", "red");
        }
    });
}

// 비밀번호 유효성 검사 함수 정의
function checkPass() {
    let passwd = $("#buy_pw").val();
    let resultElement = $("#checkPasswdResult");

    // 패스워드 조합 및 길이 규칙: 영문자, 숫자, 특수문자(!@#$%) 8 ~ 16자
    let lengthRegex = /^[A-Za-z0-9!@#$%]{8,16}$/;
    if (!lengthRegex.test(passwd)) {
        resultElement.text("영문자, 숫자, 특수문자(!@#$%) 8~16 필수!").css("color", "red");
        return;
    }

    let complexity = [
        /[a-z]/.test(passwd), // 소문자 포함 여부
        /\d/.test(passwd),    // 숫자 포함 여부
        /[!@#$%]/.test(passwd) // 특수문자 포함 여부
    ].filter(Boolean).length; // true인 값 개수 세기

    let complexityLevels = [
        { count: 3, msg: "안전", color: "green" },
        { count: 2, msg: "보통", color: "orange" },
        { count: 1, msg: "사용불가", color: "red" }
    ];

    let level = complexityLevels.find(level => level.count === complexity) || complexityLevels[2];
    resultElement.text(level.msg).css("color", level.color);
}

$(document).ready(function () {
    // 이메일 입력 시 중복 검사
    $("#buy_em").on("keyup", checkEmail);
    // 비밀번호 입력 시 유효성 검사
    $("#buy_pw").on("keyup", checkPass);

    // 완료 버튼 클릭 시 가입 처리
    $("#completeBtn").on("click", function() {
        let email = $("#buy_em").val();
        let password = $("#buy_pw").val();
        let userPhone = $("#userPhone").val(); // hidden 값 가져오기
        let check1 = $("#acc_ta").val();
        let check2 = $("#acc_pa").val();
        let check3 = $("#acc_ma").val();

console.log({
    buyer_em: email, 
    buyer_pw: password,
    phone: userPhone, 
    acc_ta: check1,
    acc_pa: check2,
    acc_ma: check3
});
        // 이메일 중복 검사 결과
        let emailValid = $("#checkIdResult").text() === "사용 가능한 이메일입니다."; // 텍스트 비교
        // 비밀번호 유효성 검사 결과
        let passwordValid = $("#checkPasswdResult").text() === "안전"; // 텍스트 비교

        // 이메일 및 비밀번호 유효성 검사
        if (!emailValid) {
            alert("이메일을 올바르게 입력하고 중복을 확인해주세요.");
            return;
        }

        if (!passwordValid) {
            alert("비밀번호를 올바르게 입력해주세요.");
            return;
        }
        // 이메일과 비밀번호가 모두 유효하다면 서버로 데이터 전송
        $.ajax({
    type: "POST",
    url: "buyerregister", // 정확한 경로로 수정
    data: { 
        buyer_em: email, 
        buyer_pw: password,
        phone: userPhone, // hidden 값 포함
        acc_ta: check1,
        acc_pa: check2,
        acc_ma: check3
    },

	dataType: "json",
    success: function(response) {

        if (response.success) {
	console.log("✅ 서버 응답:", response);
console.log("✅ response.success 타입:", typeof response.success);
             window.location.href = "main";
        } else {
	console.log("서버 응답 실패:", response); // 서버 응답 실패 시 콘솔 로그
            alert("가입에 실패했습니다. 다시 시도해주세요.");
        }
    },
    error: function(xhr, status, error) {
        console.error("Error:", error);
        console.log("Status:", status);
        console.log("Response Text:", xhr.responseText);
        alert("오류가 발생했습니다.");
    }
});
    });
});
