$(function() {
	
	$.ajax({
			url: "OrderListData",
			method: "GET",
			success: function(res) {
				
				alert('aa');
				
				let card = res.map(item => `<div class="card" id="${item.ord_at}">
												<div>${item.ord_at}</div>
											</div>`)
								.join('');
								
				$('#cards').append(card);
				
				
				
        	},
			error: function(xhr, status, error) {
	        	alert("서버 오류가 발생했습니다.");
	        }
		});
	
	
	
});