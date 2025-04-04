$(function() {
	$.ajax({
		url:"cartSelect",
		method: "POST",
		success: function(res) {
			debugger;
		},
		error: function(xhr, status, error) {
            console.error("리뷰 데이터를 불러오는 데 실패했습니다:", error);
      	}
	});
});