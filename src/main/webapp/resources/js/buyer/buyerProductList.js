$(function() {
	
	$(document).on('click', '.first-cate', function(){
    	categorySelect($(this));
	});
	
	$('#product-sort').on('change',function(){
		productList();
	});
	
	$(document).on("click", ".prdImg-div .heart", function(event) {
		event.preventDefault();
		wish($(this));
	});
	
	let query = window.location.search;
	let param = new URLSearchParams(query);
	let cateName = param.get('category');
	$('#category').append(cateName);
	let cateCode = param.get('lev_cd');
	
	// 페이지 처음 이동 시 데이터 출력
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
									
			res.cate.filter(item => item.lev_cd.length === 12)
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
	
	// 상품리스트
	function productList(){  
		
		const contextPath = window.location.pathname.substring(0, window.location.pathname.indexOf("/", 2));
		
		let data = {lev_cd : cateCode,
					kind : $('#product-sort').val()};
					
		$('#img12').empty();
		
		$.ajax({
			type: "POST",
	        url: "productSort",
			data: JSON.stringify(data),
			contentType: "application/json",
	        success: function(res) {
				
				let row = res.map(prd => {let heartClass = prd.buy_em ? 'fa-solid yellow' : 'fa-regular';
										 return `<div class="product-posting">
													<a href="productDetail?prd_cd=${prd.prd_cd}&sel_nm=${prd.sel_nm}">
														<div class="prdImg-div">
															<img src="${contextPath}${prd.fil_pt}" class="prd-img">
															<i class="${heartClass} fa-heart heart" data-value="${prd.prd_cd}"></i>
														</div>
														<div class="prdInfo-div">
															<div class="selNm">${prd.sel_nm}</div>
															<div class="prdNm">${prd.prd_nm}</div>
															<div class="price">
																<div class="dc">${prd.dc}</div>
																<div class="prdOp">${prd.prd_op}원</div>
																<div class="prdSp">${prd.prd_sp}원</div>
															</div>
															<div class="prdBd">${prd.cod_nm}</div>
														</div>
													</a>
												</div>`
											})
							  .join('');
		
				$('#img12').append(row);
			},
	        error: function(xhr, status, error) {
	        	alert("서버 오류가 발생했습니다.");
	        }
		});
	}
	
	// 찜 버튼
	function wish(heart) {
		heartIcon = heart[0];
		let prd_cd = heart.attr('data-value');
		heartIcon.classList.toggle("fa-regular");
		heartIcon.classList.toggle("fa-solid");
		heartIcon.classList.toggle("yellow");
		
		let action = "insert";
		
		if(heartIcon.classList.contains("fa-regular")) {
			 action = "delete";
		}
		
		data = {prd_cd : prd_cd, action : action};
		
		$.ajax({
			type: "POST",
	        url: "wishList",
			data: JSON.stringify(data),
			contentType: "application/json",
	        error: function(xhr, status, error) {
	        	if(confirm("로그인 후 사용하실 수 있습니다.\n 로그인페이지로 이동하시겠습니까?")){
					window.location.href="buyerlogin";
				}
				heartIcon.classList.toggle("fa-regular");
				heartIcon.classList.toggle("fa-solid");
				return false;
			}
		});
		
	}
	
});