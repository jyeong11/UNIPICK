document.addEventListener("DOMContentLoaded", function () {
    document.getElementById("storePw").addEventListener("keyup", validatePassword);
    document.getElementById("storePwCheck").addEventListener("keyup", validatePasswordCheck);
	document.getElementById("DuplicationCk").addEventListener("click", idChecked);

    // 폼 제출 시 AJAX로 데이터 전송
    document.getElementById("storeSignupForm").addEventListener("submit", function (event) {
	 	event.preventDefault();
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
    var passwordRegex = /^(?=.*[A-Z])(?=.*[\W_]).{8,}$/;

    if (storePw === "") {
        showErrorMessage("storePw", "비밀번호를 입력해주세요.");
    } else if (!passwordRegex.test(storePw)) {
        showErrorMessage("storePw", "비밀번호는 8자리 이상, 영문자 및 특수문자를 포함해주세요.");
    } else {
        clearErrorMessage("storePw");
    }

    validatePasswordCheck(); // 비밀번호 확인도 다시 검사
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

// 폼 유효성 검사 (전체 폼)
function validateForm() {
    // 추가적으로 다른 입력 필드에 대한 유효성 검사도 이곳에서 할 수 있습니다.
    return !document.querySelectorAll(".error-message").length; // 에러가 없으면 true 반환
}

// 폼 데이터를 AJAX로 전송
function submitForm() {
    var formData = new FormData(document.getElementById("storeSignupForm"));

    $.ajax({
        type: "POST",
        url: "joinSucess",
        data: formData,
        processData: false,  // FormData는 자동으로 처리되므로 processData는 false
        contentType: false,  // multipart/form-data로 전송
        success: function(res) {
            alert("입점 신청이 완료되었습니다.");
            window.location.href = "successPage.html"; // 성공 페이지로 이동
        },
        error: function (xhr, textStatus, errorThrown) {
            alert("다시 접속해주세요.");
        }
    });
}
function idChecked() {
	var storeId = document.getElementById("storeId").value
	var data = {
		storeId : storeId
	}
	
	$.ajax({
		type: "POST",
		url: "selinfo",
		contentType: "application/json",
		data: JSON.stringify(data),
		success: function(res) {
			alert(res.msg);
		},
		error: function (xhr, textStatus, errorThrown) {
            alert("다시 접속해주세요.");
        }
	});
}
