$(function(){
	let query = window.location.search;
	let param = new URLSearchParams(query);
	let prd_cd = param.get('prd_cd');
	
	console.log(prd_cd);
	$(document).ready(function() {
		$.ajax({
			url: "sellerOrdDetail",
			method: "POST",
			data: JSON.stringify({ prd_cd: prd_cd }),
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