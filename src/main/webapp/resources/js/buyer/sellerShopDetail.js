$(function() {
	
	$.ajax({
		type: "POST",
        url: "sellerShopCategory",
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
			
			res.cate.filter(item => item.lev_cd.length === 12)
				    .forEach(item => {
								        let parentClass = item.lev_cd.substring(0, 10);
								        let listItem = `<li>
															<a href="productList?lev_cd=${item.lev_cd}&category=${item.lev_nm}" class="cate-button">${item.lev_nm}</a>
														</li>`;
								
								        $(`.${parentClass}`).append(listItem)});	
		}
	});
	$(document).on('click', '.first-cate', function(){
		categorySelect($(this));
	});
	// 카테고리 선택
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
});