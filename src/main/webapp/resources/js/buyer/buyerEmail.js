$(document).ready(function () {
    // 이메일 입력 시 중복 검사
    $("#buy_em").on("keyup", checkEmail);
    // 비밀번호 입력 시 유효성 검사
    $("#buy_pw").on("keyup", checkPass);
});

// 이메일 중복 검사
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

// 비밀번호 유효성 검사
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
        /[A-Z]/.test(passwd), // 대문자 포함 여부
        /[a-z]/.test(passwd), // 소문자 포함 여부
        /\d/.test(passwd),    // 숫자 포함 여부
        /[!@#$%]/.test(passwd) // 특수문자 포함 여부
    ].filter(Boolean).length; // `true`인 값 개수 세기

    let complexityLevels = [
        { count: 4, msg: "안전", color: "blue" },
        { count: 3, msg: "보통", color: "green" },
        { count: 2, msg: "위험", color: "orange" },
        { count: 1, msg: "사용불가", color: "red" }
    ];

    let level = complexityLevels.find(level => level.count === complexity) || complexityLevels[3];
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

        // 이메일 중복 검사 결과
        let emailValid = $("#checkIdResult").css("color") === "rgb(0, 128, 0)"; // 초록색
        // 비밀번호 유효성 검사 결과
        let passwordValid = $("#checkPasswdResult").css("color") === "rgb(0, 0, 255)"; // 파란색 (안전)

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
            url: "${pageContext.request.contextPath}/register", // 서버의 등록 API URL
            data: { 
                buyer_em: email, 
                buyer_pw: password
            },
            success: function(response) {
                if (response.success) {
                    // 등록이 성공하면 홈으로 이동
                    window.location.href = "/"; // 홈 페이지로 이동
                } else {
                    alert("가입에 실패했습니다. 다시 시도해주세요.");
                }
            },
            error: function() {
                alert("오류가 발생했습니다.");
            }
        });
    });
});
