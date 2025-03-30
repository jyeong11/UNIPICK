$(function() {
	let query = window.location.search;
    let param = new URLSearchParams(query);
	let data = {ord_id : param.get('ord_id')}
	
	let sum = 0;
	
	$.ajax({
		url: "myRecentlyPrd",
		method: "POST",
		data: JSON.stringify(data),
		contentType: "application/json",
		success: function(res) {
			const contextPath = window.location.pathname.substring(0, window.location.pathname.indexOf("/", 2));
			
			let product = res.map(item => { const date = new Date(item.vie_tm).toLocaleString();
											const percent = (item.prd_op - item.prd_sp) / item.prd_op * 100;
											return `<a href="productDetail?prd_cd=${item.prd_cd}" id="prd-link">
													    <div class="card">
												            <div class="card-body">
													            <div class="date">${date}</div>
													            <div class="store">${item.sel_nm}</div>
													            <div class="prdImg"><img src="${contextPath}${item.fil_pt}"></div>
													            <div class="prdName">${item.prd_nm}</div>
													            <div class="price">
														            <div class="originalPrice">${percent}% <span class="original">${item.prd_op}원<span></div>
													                <div class="salePrice">${item.prd_sp}원</div>
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