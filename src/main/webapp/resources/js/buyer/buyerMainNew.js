$(function() {
	
	const contextPath = window.location.pathname.substring(0, window.location.pathname.indexOf("/", 2));
	let data = {lev_cd : "All",
				kind : "PST03",
				limit : "8"}

	$.ajax({
		url: "productBestNew",
		method: "POST",
		data: JSON.stringify(data),
		contentType: "application/json",
		success: function(res) {
			let product = res.prd.map(item =>{ let heartClass = item.buy_em ? 'fa-solid yellow' : 'fa-regular';
						return `<div class="product_posting">
									<a href="productDetail?prd_cd=${item.prd_cd}&sel_nm=${item.sel_nm}">
											<div class="prdImg-div">
												<img src="${contextPath}${item.fil_pt}" class="prdImg">
												<i class="${heartClass} fa-heart heart" data-value="${item.prd_cd}"></i>
											</div>
										<div>
											<div>${item.sel_nm}</div>
											<div>${item.prd_nm}</div>
											<div class="price">
												<div class='dc'>${item.dc}</div>
												<div class="prdOp">${item.prd_op}원</div>
												<div class="prdSp">${item.prd_sp}원</div>
											</div>
											<div class="prdBd">${item.cod_nm}</div>
										</div>
									</a>
								</div>`})
								.join('');
					$('#newImg8').append(product);
		},
		error: function(xhr, status, error) {
        	alert("서버 오류가 발생했습니다.");
        }
	});
})
