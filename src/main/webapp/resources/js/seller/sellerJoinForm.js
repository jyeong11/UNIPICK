// 전역 변수 (중복체크 완료 여부)
var isIdChecked = false;

document.addEventListener("DOMContentLoaded", function () {
    // 비밀번호 유효성 검사
    document.getElementById("storePw").addEventListener("keyup", validatePassword);
    document.getElementById("storePwCheck").addEventListener("keyup", validatePasswordCheck);
    
    // 아이디 중복체크 버튼 클릭
    document.getElementById("DuplicationCk").addEventListener("click", idChecked);
    
    // storeId 입력 변경 시 중복체크 플래그 초기화
    document.getElementById("storeId").addEventListener("keyup", function () {
        isIdChecked = false;
    });

    // 폼 제출 시 전체 유효성 검사 후 AJAX로 데이터 전송
    document.getElementById("storeSignupForm").addEventListener("submit", function (event) {
        event.preventDefault();
        if (!validateForm()) {
            // validateForm()에서 alert 처리되었음.
            return;
        }
        
        let formData = new FormData(this); 
        $.ajax({
            type: "POST",
            url: "joinSucess",
            processData: false,
            contentType: false,
            data: formData,
            success: function (res) {
                alert("입점 신청이 완료되었습니다.");
                document.getElementById("storeSignupForm").reset();
            },
            error: function (xhr, textStatus, errorThrown) {
                alert("다시 접속해주세요.");
            }
        });
    });
});

// 비밀번호 유효성 검사
function validatePassword() {
    var storePw = document.getElementById("storePw").value.trim();
    var passwordRegex = /^(?=.*[A-Z])(?=.*[\W_]).{6,}$/;

    if (storePw === "") {
        showErrorMessage("storePw", "비밀번호를 입력해주세요.");
    } else if (!passwordRegex.test(storePw)) {
        showErrorMessage("storePw", "비밀번호는 6자리 이상, 영문자 및 특수문자를 포함해주세요.");
    } else {
        clearErrorMessage("storePw");
    }
    // 비밀번호 확인도 재검사
    validatePasswordCheck();
}

// 비밀번호 확인 유효성 검사
function validatePasswordCheck() {
    var storePw = document.getElementById("storePw").value.trim();
    var storePwCheck = document.getElementById("storePwCheck").value.trim();

    if (storePwCheck === "") {
        showErrorMessage("storePwCheck", "비밀번호 확인을 입력해주세요.");
    } else if (storePw !== storePwCheck) {
        showErrorMessage("storePwCheck", "비밀번호가 일치하지 않습니다.");
    } else {
        clearErrorMessage("storePwCheck");
    }
}

// 에러 메시지 출력
function showErrorMessage(elementId, message) {
    var element = document.getElementById(elementId);
    var parent = element.parentNode;
    var errorSpan = parent.querySelector(".error-message");

    if (!errorSpan) {
        errorSpan = document.createElement("span");
        errorSpan.classList.add("error-message");
        errorSpan.style.color = "red";
        errorSpan.style.display = "block"; 
        parent.appendChild(errorSpan);
    }
    errorSpan.innerText = message;
}

// 에러 메시지 제거
function clearErrorMessage(elementId) {
    var element = document.getElementById(elementId);
    var parent = element.parentNode;
    var errorSpan = parent.querySelector(".error-message");
    if (errorSpan) {
        errorSpan.innerText = "";
    }
}

// 전체 폼 유효성 검사
function validateForm() {
    var storeId = document.getElementById("storeId").value.trim();
    var storeNm = document.getElementById("storeNm").value.trim();
    var ceoNm = document.getElementById("ceoNm").value.trim();
    var brn = document.getElementById("brn").value.trim();
    var storead = document.getElementById("storead").value.trim();
    var businessLicense = document.getElementById("businessLicense").value;  // 파일은 value로 확인
    var storeNumber = document.getElementById("storeNumber").value.trim();
    var phNm = document.getElementById("phNm").value.trim();
    var phNumber = document.getElementById("phNumber").value.trim();

    // 아이디 길이 체크
    if (storeId.length < 6) {
        alert("아이디는 6자리 이상 입력해주세요.");
        return false;
    }

    // 필수 입력란 체크
    if (
        storeId === "" || storeNm === "" || ceoNm === "" || brn === "" ||
        storead === "" || businessLicense === "" || storeNumber === "" ||
        phNm === "" || phNumber === ""
    ) {
        alert("모든 필수 입력란을 입력해주세요.");
        return false;
    }
    
    // 아이디 중복체크 여부 확인
    if (!isIdChecked) {
        alert("아이디 중복체크를 해주세요.");
        return false;
    }
    
    return true;
}

// 폼 데이터를 AJAX로 전송 (추가적인 별도 전송 함수)
function submitForm() {
    var formData = new FormData(document.getElementById("storeSignupForm"));
    $.ajax({
        type: "POST",
        url: "joinSucess",
        data: formData,
        processData: false,
        contentType: false,
        success: function(res) {
            alert("입점 신청이 완료되었습니다.");
        },
        error: function (xhr, textStatus, errorThrown) {
            alert("다시 접속해주세요.");
        }
    });
}

// 아이디 중복체크 AJAX 요청
function idChecked() {
    var storeId = document.getElementById("storeId").value.trim();
    if (storeId.length < 6) {
        alert("아이디는 6자리 이상 입력해주세요.");
        return;
    }
    
    var data = {
        storeId : storeId
    };
    
    $.ajax({
        type: "POST",
        url: "selinfo",
        contentType: "application/json",
        data: JSON.stringify(data),
        success: function(res) {
            alert(res.msg);
            // 중복이 없고 사용 가능한 경우 플래그 true 설정 (res.msg에 따른 조건 추가 가능)
            if (res.success) {
                isIdChecked = true;
            } else {
                isIdChecked = false;
            }
        },
        error: function (xhr, textStatus, errorThrown) {
            alert("다시 접속해주세요.");
        }
    });
}
