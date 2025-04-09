
const contextPath = window.location.pathname.substring(0, window.location.pathname.indexOf("/", 2));

let limit = "15";
let lev_cd = "All";

// 신상인 경우
let kind = "PST03";

// 베스트인 경우
let path = window.location.pathname.split("/").pop();
if(path == 'best') {
	kind = "PST01"
}

$(function() {	
	
	$("#category").on("click", "li", function () {
        categoryPrd($(this));
    });

	$(document).on("click", ".prdImg-div .heart", function(event) {
		event.preventDefault();
		wish($(this));
	});
	
	let data = {lev_cd : lev_cd,
				kind : kind,
				limit : limit}
	
	$.ajax({
		url: "productBestNew",
		method: "POST",
		data: JSON.stringify(data),
		contentType: "application/json",
		success: function(res) {
					// 카테고리
					let category = res.cate.filter(item => item.lev_cd.length === 10)
										   .map(item =>`<li data-value="${item.lev_cd}"><div class="select-cate">${item.lev_nm}</div></li>`)
										   .join('');
							
							$('#category').append(category);
			
					// 상품
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
					$('#img12').append(product);
				
		},
		error: function(xhr, status, error) {
        	alert("서버 오류가 발생했습니다.");
        }
		
	})
	
})

// 카테고리에 해당하는 상품 출력
function categoryPrd(select) {
	
	let data = {lev_cd : select.data('value'),
				kind : kind,
				limit : limit}
	
	$.ajax({
		url: "productSort",
		method: "POST",
		data: JSON.stringify(data),
		contentType: "application/json",
	    success: function(res) {
			$('#img12').html("");
			let product = res.map(item =>{ let heartClass = item.buy_em ? 'fa-solid yellow' : 'fa-regular';
						return `<div class="product_posting">
									<a href="productDetail?prd_cd=${item.prd_cd}&sel_nm=${item.sel_nm}">
											<div class="prdImg-div">
												<img src="${contextPath}${item.fil_pt}" class="prdImg">
												<i class="${heartClass} fa-heart heart"></i>
											</div>
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
								</div>`})
							.join('');
				$('#img12').html(product);
				$('#selectCate').empty();
				$('#selectCate').append(select.text());
			
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