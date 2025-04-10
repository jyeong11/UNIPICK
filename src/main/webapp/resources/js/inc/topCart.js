$(function(){
   	$.ajax({
		url: "cartCnt",
		method: "POST",
		success: function(res){
			let $cartCount = $("#cart-count");
        	$cartCount.text(res).toggle(Number(res) > 0);
		},
		error: function(xhr, status, error) {
        	alert("서버 오류가 발생했습니다.");
        }
	});
});
