$(function() {
    
    let effectiveness = true;
    
    // 기존 파일 경로 값을 히든 필드에서 가져오거나 기본값 설정
    let existingStorePp = $('#existingStorePp').val() || "";
    let existingStoreBp = $('#existingStoreBp').val() || "";
    
    // 카카오 주소창 띄우기 
    $(document).on("click", "#search-address", function(e) {
        e.preventDefault();
        new daum.Postcode({
            oncomplete: function(data) {
                $("#shipping_zipcode").val(data.zonecode);
                $("#shipping_address").val(data.address);
            }
        }).open();
    });    
    
    // 초기 데이터
    $.ajax({
        url: "selModifyForm",
        method: "POST",
        success: function(res) {
            console.log(res); // 🔍 확인용 콘솔 출력
            $('#storeId').val(res.sel_id);
            $('#storePw').val(res.sel_pw);
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
    
    // 스토어 프로필 미리보기
    $('#storePp').on('change', function(){
        const file = this.files[0];
        if(file){
            const reader = new FileReader();
            reader.onload = function(e) {
                $('#previewStorePp').attr('src', e.target.result).show();
            }
            reader.readAsDataURL(file);
        } else {
            $('#previewStorePp').hide();
        }
    });
    
    // 스토어 배경 미리보기
    $('#storeBp').on('change', function(){
        const file = this.files[0];
        if(file){
            const reader = new FileReader();
            reader.onload = function(e) {
                $('#previewStoreBp').attr('src', e.target.result).show();
            }
            reader.readAsDataURL(file);
        } else {
            $('#previewStoreBp').hide();
        }
    });
    
    // 스토어 프로필 삭제
    $('#removeStorePp').on('click', function(){
        $('#storePp').val('');
        $('#previewStorePp').attr('src', '').hide();
        // 필요시 서버에 기존 파일 삭제 요청을 추가할 수 있습니다.
        // 삭제 시 히든 필드의 값도 초기화할 수 있습니다.
        existingStorePp = "";
        $('#existingStorePp').val("");
    });
    
    // 스토어 배경 삭제
    $('#removeStoreBp').on('click', function(){
        $('#storeBp').val('');
        $('#previewStoreBp').attr('src', '').hide();
        existingStoreBp = "";
        $('#existingStoreBp').val("");
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
        var formData = new FormData();
        formData.append('sel_pw', $('#storePw').val());
        formData.append('sel_nm', $('#storeNm').val());
        formData.append('sel_rn', $('#ceoNm').val());
        formData.append('sel_br', $('#brn').val());
        formData.append('sel_ad', $('#storead').val());
        formData.append('sel_cs', $('#storeNumber').val());
        formData.append('sel_mn', $('#phNm').val());
        formData.append('sel_mp', $('#phNumber').val());
    
        var storePpFile = $('#storePp')[0].files[0];
        var storeBpFile = $('#storeBp')[0].files[0];
    
        formData.append('storePpFile', storePpFile ? storePpFile : null);
        formData.append('storeBpFile', storeBpFile ? storeBpFile : null);
    
        // 기존 파일 경로 정보 전송
        formData.append('existingStorePp', existingStorePp);
        formData.append('existingStoreBp', existingStoreBp);
    
        if(!effectiveness){
            alert('정보를 올바르게 입력 후 수정하기를 눌러주세요.');
            return;
        }
        
        $.ajax({
            type: "POST",
            url: "sellermodify",
            data: formData,
            processData: false,
            contentType: false,
            success: function() {
                alert('회원정보가 수정되었습니다.');
                window.location.href = "seller";
            },
            error: function(xhr, status, error) {
                alert("서버 오류가 발생했습니다.");
            }
        });
    }
    
    // 유효성 검사 함수들
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
    // 사업자번호
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
    // 담당자 핸드폰 번호
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
