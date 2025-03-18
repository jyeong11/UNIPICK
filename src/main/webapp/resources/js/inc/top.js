$(function(){
	
	$("#search_btn").click(function() {
    var searchterm = $("#search_input").val().trim();

    if (searchterm != "") {
        window.location.href = "productSearch?query=" + encodeURIComponent(searchterm);
    }
}); 
	
});