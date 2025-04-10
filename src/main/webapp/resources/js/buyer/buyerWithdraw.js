$(function() {
	$(document).ready(function () {
	    $('input[name="reason"]').change(function () {
	        if ($('#custom-reason').is(':checked')) {
	            $('.last-div').removeClass('none');
	        } else {
	            $('.last-div').addClass('none');
	        }
	    });
	
	    // 글자수 카운트 (보너스)
	    $('#input-reason').on('input', function () {
	        const len = $(this).val().length;
	        $('#charCount').text(len);
	    });
	});
	
	$('#submit').on('click', function() {
		
		if(confirm("정말로 회원탈퇴를 진행하시겠습니까?\n탈퇴 시 계정 정보와 이용 내역이 모두 삭제됩니다.")){
			$.ajax({
				url: "buyerWithdraw",
				method: "GET",
				success: function() {
					alert('탈퇴되었습니다.');
					window.location.href="main";
				},
				error: function(xhr, status, error) {
		        	alert("서버 오류가 발생했습니다.");
		        }
			});
		}
		return false;
		
	});
	
});