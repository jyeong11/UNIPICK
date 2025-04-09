$(function() {
	
	$(document).on("click", ".prdImg .heart", function(event) {
		event.preventDefault();
		wish($(this));
	});
	
	$.ajax({
		url: "myWishPrd",
		method: "POST",
		success: function(res) {
			const contextPath = window.location.pathname.substring(0, window.location.pathname.indexOf("/", 2));
			
			let product = res.map(item =>{let heartClass = item.buy_em ? 'fa-solid yellow' : 'fa-regular';
							return `<a href="productDetail?prd_cd=${item.prd_cd}&sel_nm=${item.sel_nm}" id="prd-link">
							    		<div class="card">
						            		<div class="card-body">
												<div class="top">
										            <div class="store">${item.sel_nm}</div>
												</div>
												<div class="prd-info">
										            <div class="prdImg">
														<img src="${contextPath}${item.fil_pt}" class="prd-img">
														<i class="${heartClass} fa-heart heart" data-value="${item.prd_cd}"></i>
													</div>
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