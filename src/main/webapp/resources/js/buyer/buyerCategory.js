$(function() {
	
	firstCategory();
	
	
	function firstCategory() {
		$.ajax({
			type: "GET",
	        url: "firstCategory",
	        success: function(res) {
				
			},
	        error: function(xhr, status, error) {
            	alert("서버 오류가 발생했습니다.");
	        }
		});
	}
	
	
});