$(function() {
	
	loadData();
	
	$("#cancel-btn").on("click", function () {
		if(confirm("취소하시겠습니까?")){
			window.location.href = "admin";
		}
	})
	
	$("#edit-btn").on("click", function () {
	    editPw();
	})
	
	function loadData() {
		$.ajax({
	        type: "GET",
	        url: "adminInfo",
	        success: function(res) {
					 let id = `<input type="text" id="id" readonly value="${res.adm_id }">`
					 let nm = `<input type="text" readonly value="${res.adm_nm }">`
				
				$('#id').append(id);
				$('#nm').append(nm);
	        },
	        error: function(xhr, status, error) {
            	alert("서버 오류가 발생했습니다.");
	        }
	    });
	}
	
	
	function editPw() {
		
		let admPw = document.getElementById("pw").value;
	    let admPwCheck = document.getElementById("pw-check").value;
		
		if (!admPw || !admPwCheck) {
        	alert("비밀번호를 입력한 후 수정을 눌러주세요.");
			return;
	    }
		let admId = $('#id').prop('value').trim();
		admPw = admPw.trim();
	    admPwCheck = admPwCheck.trim();
		
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