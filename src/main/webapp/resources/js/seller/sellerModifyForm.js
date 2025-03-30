$(function() {
	
	let effectiveness = true;
	
	// 초기 데이터
	$.ajax({
			url: "selModifyForm",
			method: "GET",
			success: function(res) {
				$('#storePw').append(res.sel_pw);
				$('#storeNm').val(res.sel_nm);
				$('#ceoNm').val(res.sel_rn);
				$('#brn').val(res.sel_br);
				$('#storead').val(res.sel_ad);
				$('#storeNumber').val(res.sel_cs);
				$('#phNm').val(res.sel_mn);
				$('#phNumber').val(res.sel_mp);
        	},
			error: function(xhr, status, error) {
	        	alert("서버 오류가 발생했습니다.");
	        }
		});
	

	// 유효성 검사
	// 비밀번호
	$('#storePw').on('input', function() {
		checkstorePw($(this));
	});
	// 상호명
	$('#storeNm').on('input', function() {
		checkstoreNm($(this));
	});
	// 대표자명
	$('#ceoNm').on('input', function() {
		checkceoNm($(this));
	});
	// 사업자등록번호
	$('#brn').on('input', function() {
		checkbrn($(this));
	});
	// 사업자 주소
	$('#storead').on('input', function() {
		checkstoread($(this));
	});
	// 고객센터 번호
	$('#storeNumber').on('input', function() {
		checkstoreNumber($(this));
	});
	// 담당자 이름
	$('#phNm').on('input', function() {
		checkphNm($(this));
	});
	// 담당자 번호
	$('#phNumber').on('input', function() {
		checkstorephNumber($(this));
	});
	// 수정하기 클릭시
	$('#sellermodify').on('click', function() {
		modify();
	});
	// 탈퇴하기 클릭시
	$('#sellerWithdraw').on('click', function(){
		window.location.href = 'sellerwithdraw';
	});
	
	// 수정
	function modify() {
		
		data = {
			sel_pw : $('#storePw').val(),
			sel_nm : $('#storeNm').val(),
			sel_rn : $('#ceoNm').val(),
			sel_br : $('#brn').val(),
			sel_ad : $('#storead').val(),
			sel_cs : $('#storeNumber').val(),
			sel_mn : $('#phNm').val(),
			sel_mp : $('#phNumber').val(),
		};
		debugger;
		
		if(!effectiveness){
			alert('정보를 올바르게 입력 후 수정하기를 눌러주세요.');
			return;
		}
		
		$.ajax({
			type: "POST",
	        url: "sellermodify",
			data: JSON.stringify(data),
			contentType: "application/json",
	        success: function() {
				alert('회원정보가 수정되었습니다.');
				window.location.href="main";
			},
			error: function(xhr, status, error) {
	        	alert("서버 오류가 발생했습니다.");
	        }
			
		});
	}
	
	// 유효성 검사
	// 패스워드
	function checkstorePw(pw) {
		let pwValue = pw.val().trim();
		let errorMsg = '';
		effectiveness = false;

		const passwordRegex = /^(?=.*[A-Z])(?=.*[\W_]).{6,}$/;
		if (!passwordRegex.test(pwValue)) {
			if(pwValue !== "") {
	        	errorMsg = "조건을 만족하는 비밀번호를 입력해주세요.";
			}
	    }

		if (errorMsg) {
	        $('#passwdError').text(errorMsg).css('color', 'red');
	    } else {
			effectiveness = true;
	        $('#passwdError').text('');
	    }
	}
	// 상호명
	function checkstoreNm(nick) {
		let nickValue = nick.val().trim();
		let errorMsg = '';
		effectiveness = false;
		
		if (nickValue.length > 10) {
	        nick.val(nickValue.substring(0, 10));
	    }
		
		if (!nickValue) {
	        errorMsg = '상호명을 입력해주세요.';
	    } else if (nickValue.length < 1 || nickValue.length > 10) {
	        errorMsg = '상호명은 1글자 이상 10글자 이하로 입력해주세요.';
	    }

	    if (errorMsg) {
	        $('#nickError').text(errorMsg).css('color', 'red');
	    } else {
			effectiveness = true;
	        $('#nickError').text('');
	    }
	}	
	
	// 대표자명
	function checkceoNm(name) {
		let nameValue = name.val().trim();
	    let errorMsg = '';
		effectiveness = false;
		
		if (nameValue.length > 5) {
	        name.val(nameValue.substring(0, 5));
	    }

	    if (!nameValue) {
	        errorMsg = '이름을 입력해주세요.';
	    } else if (nameValue.length < 2 || nameValue.length > 5) {
	        errorMsg = '이름은 2글자 이상 5글자 이하로 입력해주세요.';
	    } else if (!/^[가-힣]+$/.test(nameValue)) {
	        errorMsg = '이름은 한글만 입력 가능합니다.';
	    }
	
	    if (errorMsg) {
	        $('#nameError').text(errorMsg).css('color', 'red');
	    } else {
			effectiveness = true;
	        $('#nameError').text('');
	    }
	}
	//사업자번호
	function checkbrn(brn) {
    let brnValue = brn.val().trim();
    let errorMsg = '';
    effectiveness = false;

    const brnRegex = /^\d{3}-\d{2}-\d{5}$/;
    if (!brnRegex.test(brnValue)) {
        errorMsg = '올바른 사업자 등록번호(예: 123-45-67890)를 입력해주세요.';
    }

    if (errorMsg) {
        $('#brnError').text(errorMsg).css('color', 'red');
    } else {
        effectiveness = true;
        $('#brnError').text('');
    }
}
	
	// 고객센터 번호
	function checkstoreNumber(cs) {
	    let csValue = cs.val().trim();
	    let errorMsg = '';
		effectiveness = false;
		
		if (csValue.length > 13) {
	        cs.val(csValue.substring(0, 13));
	    }
	
	    if (!csValue) {
	        errorMsg = '고객센터 번호를 입력해주세요.';
	    } else {
	        const csRegex = /^(01[016789])-?(\d{3,4})-?(\d{4})$/;
	        if (!csRegex.test(csValue)) {
	            errorMsg = '유효한 고객센터 번호를 입력해주세요.';
	        }
	    }
	
	    if (errorMsg) {
	        $('#phoneError').text(errorMsg).css('color', 'red');
	    } else {
			effectiveness = true;
	        $('#phoneError').text('');
	    }
	}
	
	// 담당자 이름
	function checkphNm(name) {
		let nameValue = name.val().trim();
	    let errorMsg = '';
		effectiveness = false;
		
		if (nameValue.length > 5) {
	        name.val(nameValue.substring(0, 5));
	    }

	    if (!nameValue) {
	        errorMsg = '이름을 입력해주세요.';
	    } else if (nameValue.length < 2 || nameValue.length > 5) {
	        errorMsg = '이름은 2글자 이상 5글자 이하로 입력해주세요.';
	    } else if (!/^[가-힣]+$/.test(nameValue)) {
	        errorMsg = '이름은 한글만 입력 가능합니다.';
	    }
	
	    if (errorMsg) {
	        $('#nameError').text(errorMsg).css('color', 'red');
	    } else {
			effectiveness = true;
	        $('#nameError').text('');
	    }
	}
	

	// 담당자 핸드폰
	function checkstorephNumber(phone) {
	    let phoneValue = phone.val().trim();
	    let errorMsg = '';
		effectiveness = false;
		
		if (phoneValue.length > 13) {
	        phone.val(phoneValue.substring(0, 13));
	    }
	
	    if (!phoneValue) {
	        errorMsg = '휴대폰 번호를 입력해주세요.';
	    } else {
	        const phoneRegex = /^(01[016789])-?(\d{3,4})-?(\d{4})$/;
	        if (!phoneRegex.test(phoneValue)) {
	            errorMsg = '유효한 휴대폰 번호를 입력해주세요.';
	        }
	    }
	
	    if (errorMsg) {
	        $('#phoneError').text(errorMsg).css('color', 'red');
	    } else {
			effectiveness = true;
	        $('#phoneError').text('');
	    }
	}



	
});