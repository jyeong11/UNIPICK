$(function() {
	
	loadData();
	
	$("#cancel-btn").on("click", function () {
	    window.history.back();
	})
	
	$("#edit-btn").on("click", function () {
	    editPw();
	})
	
	function loadData() {
		$.ajax({
	        type: "GET",
	        url: "adminInfo",
	        success: function(res) {
				$(".my-data").empty();
				let row = $(
					`<input type="text" id="id" disabled value="${res.adm_id }">
					 <input type="password" id="pw" placeholder="비밀번호">
					 <input type="password" id="pw-check" placeholder="비밀번호 확인">
					 <input type="text" disabled value="${res.adm_nm }">`
				);
				$('.my-data').append(row);
	        },
	        error: function(xhr, status, error) {
            	alert("서버 오류가 발생했습니다.");
	        }
	    });
	}
	
	
	function editPw() {
		let admId = document.getElementById("id").value.trim();
		let admPw = document.getElementById("pw").value.trim();
	    let admPwCheck = document.getElementById("pw-check").value.trim();
		
		if(admPw === "" && admPwCheck === ""){
			alert("비밀번호를 입력해주세요.");
			return;
		} else if(admPw !==  admPwCheck) {
	        alert("비밀번호가 일치하지 않습니다.");
			return;
	    }
		let data = {};
		data.admId = admId;
		data.admPw = admPw;
		
		$.ajax({
	        type: "POST",
	        url: "adminMyPageEdit",
	        data: JSON.stringify(data),
	        contentType: "application/json; charset=UTF-8",
	        dataType: "json",
	        success: function(res) {
				alert(res.msg)
				window.location.href = "admin";
	        },
	        error: function(xhr, status, error) {
            	alert("서버 오류가 발생했습니다.");
	        }
	    });
		
	}
	
});