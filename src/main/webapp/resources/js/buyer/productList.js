$(function() {
	
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
	
});