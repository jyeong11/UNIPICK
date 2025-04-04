$(function() {
	$.ajax({
		url: "myRecentlyPrd",
		method: "POST",
		success: function(res) {
			const contextPath = window.location.pathname.substring(0, window.location.pathname.indexOf("/", 2));
			
			let product = res.map(item => { const date = new Date(item.vie_tm).toLocaleString();
					return `<a href="productDetail?prd_cd=${item.prd_cd}&sel_nm=${item.sel_nm}" id="prd-link">
							    <div class="card">
						            <div class="card-body">
										<div class="top">
								            <div class="store">${item.sel_nm}</div>
											<div class="date">${date}</div>
										</div>
										<div class="prd-info">
								            <div class="prdImg"><img src="${contextPath}${item.fil_pt}" class="prd-img"></div>
											<div class="right-info">
									            <div class="prdName">${item.prd_nm}</div>
									            <div class="price">
										            <div class="originalPrice">${item.dc} <span class="original">${item.prd_op}원<span></div>
									                <div class="salePrice">${item.prd_sp}원</div>
									            </div>
											</div>
										</div>	
							        </div>
						        </div>
							</a>`})
							.join('');
			$('#cards').append(product);
		},
		error: function(xhr, status, error) {
        	alert("서버 오류가 발생했습니다.");
        }
	});
	
	
});