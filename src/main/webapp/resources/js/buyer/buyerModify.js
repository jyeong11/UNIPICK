$(function() {
	
	let gen = '';
	let effectiveness = true;
	
	// 성별 클릭시
	$('.female').on('click', function(){
		$(this).removeClass("gray");
    	$('.male').addClass("gray");
		gen = "여";
	});
	$('.male').on('click', function(){
		$(this).removeClass("gray");
    	$('.female').addClass("gray");
		gen = "남";
	});
	
	// 유효성 검사
	// 이름
	$('#name').on('input', function() {
    	checkName($(this));
	});
	// 닉네임
	$('#nickname').on('input', function() {
    	checkNick($(this));
	});
	// 비밀번호
	$('#password').on('input', function() {
		checkPasswd($(this));
	})
	// 휴대폰번호
//	$('#phoneNumber').on('input', function() {
//		checkPhone($(this));
//	})
	// 생년월일
	$('#birthDate').on('input', function() {
		checkBirth($(this));
	})
	// 키
	$('#heightSize').on('input', function() {
		checkHeight($(this));
	})
	// 몸무게
	$('#weightSize').on('input', function() {
		checkWeight($(this));
	})
	
	// 수정하기 클릭시
	$('#modify').on('click', function() {
		modify();
	})
	
	// 탈퇴하기 클릭시
	$('#withdraw').on('click', function(){
		window.location.href = 'withdraw';
	});
	
	// 초기 데이터
	$.ajax({
			url: "buyerInfo",
			method: "GET",
			success: function(res) {
				gen = res.buy_gn
				gender = gen === "남" ? '.female' : '.male';
				$('#email').append(res.buy_em);
				$('#name').val(res.buy_nm);
				$('#nickname').val(res.buy_nn);
				$('#phoneNumber').val(res.buy_ph);
				$('#birthDate').val(res.buy_bd);
				$(gender).addClass('gray');
				
				if(res.buy_ht){
					$('#heightSize').val(res.buy_ht);
				}
				if(res.buy_wt){
					$('#weightSize').val(res.buy_wt);
				}
				
				
        	},
			error: function(xhr, status, error) {
	        	alert("서버 오류가 발생했습니다.");
	        }
		});
		
	// 수정
	function modify() {
		
		data = {
			buy_em : $('#email').text(),
			buy_nm : $('#name').val(),
			buy_nn : $('#nickname').val(),
			buy_pw : $('#password').val(),
			buy_ph : $('#phoneNumber').val(),
			buy_bd : $('#birthDate').val(),
			buy_gn : gen,
			buy_ht : $('#heightSize').val(),
			buy_wt : $('#weightSize').val(),
			acc_pa : $('#agreement').prop('checked')
		};
		
		if(!effectiveness){
			alert('정보를 올바르게 입력 후 수정하기를 눌러주세요.');
			return;
		}
		
		$.ajax({
			type: "POST",
	        url: "buyermodify",
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
	// 이름
	function checkName(name) {
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
	
	// 닉네임
	function checkNick(nick) {
		let nickValue = nick.val().trim();
		let errorMsg = '';
		effectiveness = false;
		
		if (nickValue.length > 10) {
	        nick.val(nickValue.substring(0, 10));
	    }
		
		if (!nickValue) {
	        errorMsg = '닉네임을 입력해주세요.';
	    } else if (nickValue.length < 2 || nickValue.length > 10) {
	        errorMsg = '닉네임은 2글자 이상 10글자 이하로 입력해주세요.';
	    }

	    if (errorMsg) {
	        $('#nickError').text(errorMsg).css('color', 'red');
	    } else {
			effectiveness = true;
	        $('#nickError').text('');
	    }
	}
	
	// 패스워드
	function checkPasswd(pw) {
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
	
	// 핸드폰
//	function checkPhone(phone) {
//	    let phoneValue = phone.val().trim();
//	    let errorMsg = '';
//	    effectiveness = false;
//	
//	    phoneValue = phoneValue.replace(/[^0-9]/g, '');
//	
//	    if (phoneValue.length > 11) {
//	        phoneValue = phoneValue.substring(0, 11);
//	        phone.val(phoneValue);
//	    } else {
//	        phone.val(phoneValue);
//	    }
//	
//	    if (!phoneValue) {
//	        errorMsg = '휴대폰 번호를 입력해주세요.';
//	    } else {
//	        const phoneRegex = /^01[016789][0-9]{7,8}$/;
//	        if (!phoneRegex.test(phoneValue)) {
//	            errorMsg = '유효한 휴대폰 번호를 입력해주세요.';
//	        }
//	    }
//	
//	    if (errorMsg) {
//	        $('#phoneError').text(errorMsg).css('color', 'red');
//	    } else {
//	        effectiveness = true;
//	        $('#phoneError').text('');
//	    }
//	}
	
	// 생년월일	
	function checkBirth(birthDate) {
	    let birthDateValue = birthDate.val().trim();
	    let errorMsg = '';
		effectiveness = false;
		
		if (birthDateValue.length > 6) {
	        birthDate.val(birthDateValue.substring(0, 6));
	    }
	
	    if (!birthDateValue) {
	        errorMsg = '생년월일을 입력해주세요.';
	    } else {
	        const birthDateRegex = /^[0-9]{6}$/;
	        if (!birthDateRegex.test(birthDateValue)) {
	            errorMsg = '유효한 생년월일(YYMMDD)을 입력해주세요.';
	        } else {
	            const year = parseInt(birthDateValue.substr(0, 2), 10);
	            const month = parseInt(birthDateValue.substr(2, 2), 10);
	            const day = parseInt(birthDateValue.substr(4, 2), 10);
	
	            const fullYear = (year < 30 ? year + 2000 : year + 1900);
	
	            const date = new Date(fullYear, month - 1, day);
	            if (date.getFullYear() !== fullYear || date.getMonth() + 1 !== month || date.getDate() !== day) {
	                errorMsg = '유효한 날짜가 아닙니다.';
	            }
	        }
	    }
	
	    if (errorMsg) {
	        $('#birthError').text(errorMsg).css('color', 'red');
	    } else {
			effectiveness = true;
	        $('#birthError').text('');
	    }
	}

	// 키
	function checkHeight(height) {
	    let heightValue = height.val().trim();
	    let errorMsg = '';
	    effectiveness = false;

		if (heightValue.length > 3) {
	        height.val(heightValue.substring(0, 3));
	    }
	
	    const numberRegex = /^[0-9]{3}$/;

        const number = parseInt(heightValue, 10);
        if (!numberRegex.test(heightValue) || number < 100 || number > 250) {
            errorMsg = '키 또는 몸무게의 범위가 벗어났습니다.';
        }

	    if (errorMsg) {
	        $('#sizeError').text(errorMsg).css('color', 'red');
	    } else {
			effectiveness = true;
	        $('#sizeError').text('');
	    }
	}

	// 몸무게
	function checkWeight(weight) {
	    let weightValue = weight.val().trim();
	    let errorMsg = '';
	    effectiveness = false;

		if (weightValue.length > 3) {
	        weight.val(weightValue.substring(0, 3));
	    }
	
	    const numberRegex = /^[0-9]{2,3}$/;  

        const number = parseInt(weightValue, 10);
        if (!numberRegex.test(weightValue) || number < 40 || number > 150) {
            errorMsg = '키 또는 몸무게의 범위가 벗어났습니다.';
        }
	    
	    if (errorMsg) {
	        $('#sizeError').text(errorMsg).css('color', 'red');
	    } else {
	        effectiveness = true;
	        $('#sizeError').text('');
	    }
	}
	
});