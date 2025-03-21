$(function() {
	
	$(document).on('click', '.first-cate', function(){
    	categorySelect($(this));
	});
	
	$('#product-sort').on('change',function(){
		productList();
	});
	
	let query = window.location.search;
	let param = new URLSearchParams(query);
	let cateName = param.get('category');
	$('#category').append(cateName);
	let cateCode = param.get('lev_cd');
	
	$.ajax({
		type: "GET",
        url: "productListData",
        success: function(res) {
			let firstCategory = res.cate.filter(item => item.lev_cd.length === 10)
										 .map(item => `<div data-value="${item.lev_cd}" class="first-cate">
													   		${item.lev_nm}
															<i class="fa-solid fa-angle-down" data-id="${item.lev_cd}"></i>
													   </div>
													   <ul class="${item.lev_cd} cate-ul"> 
													   </ul>`)
										 .join('');
									
			$('.category-data').append(firstCategory);
									
			let secondCategory = res.cate.filter(item => item.lev_cd.length === 12)
										 .forEach(item => {
													        let parentClass = item.lev_cd.substring(0, 10);
													        let listItem = `<li>
																				<a href="productList?lev_cd=${item.lev_cd}&category=${item.lev_nm}" class="cate-button">${item.lev_nm}</a>
																			</li>`;
													
													        $(`.${parentClass}`).append(listItem)});	
			//
			// 정렬 종류
			let kindOption = res.kind.map(item => `<option value="${item.cod_cd}">${item.cod_nm}</option>`)
						  .join('');

    		$('#product-sort').append(kindOption);
			productList();
			//
		},
        error: function(xhr, status, error) {
        	alert("서버 오류가 발생했습니다.");
        }
	});
	
	function categorySelect(cate) {
		let selectCate = $(`.${cate.data("value")}`);
		let icon = cate.find('i');
		
		if (selectCate.is(":visible")) {
			icon.removeClass('fa-angle-up').addClass('fa-angle-down');
        	selectCate.hide(200);
	    } else {
			icon.removeClass('fa-angle-down').addClass('fa-angle-up');
	        selectCate.show(200);
	    }

		
		
		
		
	}
	
	function productList(){  
		
		let data = {lev_cd : cateCode,
					kind : $('#product-sort').val()};
					
		$('#img12').empty();
		
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