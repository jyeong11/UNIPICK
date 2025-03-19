$(function() {
	productList();
	
	$('#product-sort').on('change',productList);
	
	
	let query = window.location.search;
	let param = new URLSearchParams(query);
	let category = param.get('category');
	$('#category').append(category);
	
	$.ajax({
		type: "GET",
        url: "productSortKind",
        success: function(res) {
			let kind = res.map(item => `<option value="${item.cod_cd}">${item.cod_nm}</option>`)
						  .join('');

    		$('#product-sort').append(kind);
		},
        error: function(xhr, status, error) {
        	alert("서버 오류가 발생했습니다.");
        }
	});
	
	
	function productList(){ 
		
		let data = {kind : $('#product-sort').val()};
		
		$.ajax({
			type: "POST",
	        url: "productSort",
			data: JSON.stringify(data),
			contentType: "application/json",
	        success: function(res) {
				let row = res.map(prd => `<div class="product_posting">
												<a href="#">
												<img src="${prd.fil_nm}" alt="${prd.fil_nm}">
												<div>
													<div>${prd.sel_nm}</div>
													<div>${prd.prd_nm}</div>
													<div>${prd.prd_op}</div>
													<div>${prd.prd_sp}</div>
													<div>${prd.prd_bd}</div>
												</div>
											</div>`)
							  .join('');
		
				$('#img12').append(row);
			},
	        error: function(xhr, status, error) {
	        	alert("서버 오류가 발생했습니다.");
	        }
		});
	}
	
	
	
});