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

	$("#sellerBtn").click(function() {
        window.open("seller","_blank");
    });

	$("#adminBtn").click(function() {
        window.open("admin","_blank");
    });
	
});
