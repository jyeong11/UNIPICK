$(function() {
	
	
	$.ajax({
			url: "reviewData",
			method: "GET",
			success: function(res) {
				
				let card = res.data.map(item =>{ 
					let starValue = item.rev_rt;
					let star = '';
					for (let i = 1; i <= 5; i++) {
									        if (i <= starValue) {
										            star += `<span class="star filled" data-value="${i}">★</span>`;
										        } else {
										            star += `<span class="star empty" data-value="${i}">★</span>`;
										        }
										    }
											const date = new Date(item.rev_ca).toLocaleString();
											return `<div class="card">
												<div class="card-body">
													<div class="nick">${item.buy_nn}</div>
													<div class="date">${date}</div>
													<div class="stars">
														<span>${star}</span>
											        </div>
													<div class="prdName">${item.prd_nm}</div>
													<div class="reviewImg">리뷰이미지</div>
													<div class="options">${item.cod_nm} / ${item.clr_nm}</div>
													<div class="bodySize">${item.buy_ht}cm / ${item.buy_wt}kg</div>
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