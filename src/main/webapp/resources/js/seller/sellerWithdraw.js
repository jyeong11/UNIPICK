$(function() {
	
	// 직접입력
	$('.radio-btn').on('change', function() {
        if ($('#custom-reason').prop('checked')) {
            $('.last-div').removeClass("none");
        } else {
            $('.last-div').addClass("none");
        }
    });

	// 글자수
	$('#input-reason').on('input', function() {

		if ($('#input-reason').val().length >= 200) {
            // 200자 넘으면 더 이상 입력하지 못하게 처리
            $('#input-reason').val($('#input-reason').val().substring(0, 200));
        }

		$('#charCount').text($('#input-reason').val().length);
		
		 
	});
	
	$('#submit').on('click', function() {
		if(confirm('정말 탈퇴하고 계정을 삭제할까요?')){
			$.ajax({
				type: "GET",
		        url: "sellerWithdraw",
		        success: function() {
					alert('회원탈퇴 정상적으로 처리되었습니다.')
					window.location.href="main";
				},
				error: function(xhr, status, error) {
		        	alert("서버 오류가 발생했습니다.");
		        }
			});
		}
		
		return;
	})
	
});