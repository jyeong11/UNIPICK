$(function(){
	let query = window.location.search;
	let param = new URLSearchParams(query);
	let ord_id = param.get('ord_id');
	console.log(ord_id);
	$(document).ready(function() {
		$.ajax({
			url: "sellerOrdDetail",
			method: "POST",
			data: JSON.stringify({ ord_id: ord_id }),
			contentType: "application/json",
			success: function(res){
				debugger;
			},
			error: function(xhr, status, error) {
				alert("다시 시도해주세요.");
			}
		});
	});
});