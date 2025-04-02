$(function() {
	
	const contextPath = window.location.pathname.substring(0, window.location.pathname.indexOf("/", 2));
	
	let data = {lev_cd : "All",
				kind : "PST01",
				limit : "20"}
	
	$.ajax({
		url: "productSort",
		method: "POST",
		data: JSON.stringify(data),
		contentType: "application/json",
		success: function(res) {
					let prd = res.map(item =>
						`<div class="product_posting">
							<a href="#">
								<img src="${contextPath}${item.fil_pt}" class="prdImg">
								<div>
									<div>${item.sel_nm}</div>
									<div>${item.prd_nm}</div>
									<div class="price">
										<div class='dc'>${item.dc}</div>
										<div class="prdOp">${item.prd_op}</div>
										<div class="prdSp">${item.prd_sp}</div>
									</div>
									<div class="prdBd">${item.cod_nm}</div>
								</div>
							</a>
						</div>`)
								.join('');
					$('#img12').append(prd);
				
		},
		error: function(xhr, status, error) {
        	alert("서버 오류가 발생했습니다.");
        }
		
	})
	
	
	
	
	
})