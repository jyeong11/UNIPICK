$(function(){
	
	$("#search_btn").click(function() {
	    var searchterm = $("#search_input").val().trim();
	
	    if (searchterm != "") {
	        window.location.href = "productSearch?query=" + encodeURIComponent(searchterm);
	    }
	});
	 
	$("#search_input").keypress(function(event) {
        if (event.which === 13) { // Enter key code
            $("#search_btn").click(); // 버튼 클릭 이벤트 호출
        }
    });
	
});


function myPage() {
    $.ajax({
        url: "checkLogin", // 로그인 상태를 확인하는 API
        method: "GET",
        success: function(res) {
			window.location.href = res;
        },
        error: function() {
            alert("로그인 상태를 확인하는 중 오류가 발생했습니다.");
        }
    });
}