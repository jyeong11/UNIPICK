$(function() {
	
	
	$.ajax({
			url: "reviewData",
			method: "GET",
			success: function(res) {
				
				let card = res.map(item =>{ 
											const date = new Date(item.rev_ca).toLocaleString();
											return `<div class="card">
												<div class="card-body">
													<div class="nick">${item.buy_nn}</div>
													<div class="date">${date}</div>
													<div class="star">${item.rev_rt}</div>
													<div class="prdName">${item.prd_nm}</div>
													<div class="reviewImg">리뷰이미지</div>
													<div class="options">${item.cod_nm} ${item.clr_nm} ${item.buy_ht} ${item.buy_wt}</div>
													<div class="reivewCon">${item.rev_ct}</div>
												</div>
											</div>`})
								.join('');
								
				$('#cards').append(card);
				
        	},
			error: function(xhr, status, error) {
	        	alert("서버 오류가 발생했습니다.");
	        }
		});
	
	
});