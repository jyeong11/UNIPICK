$(function () {
	
	newOrdCount();
	
});

function newOrdCount() {
	$.ajax({
		url: "newOrdCount",
		method: "POST",
		success: function(res){
			$("#totalProducts").text(res);
		},	
		error: function (xhr, textStatus, errorThrown) {
            alert("다시 접속해주세요.");
        }
	});	
}