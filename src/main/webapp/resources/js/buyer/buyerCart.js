$(function() {
	let sum = 0;
	let totalSf = 0;
	
	$.ajax({
		url:"cartSelect",
		method: "POST",
		success: function(res) {
			const container = document.querySelector(".product_posting");
			container.innerHTML = "";

			res.forEach(prd => {
				let totalPrdPrice = parseInt(prd.prd_sp * parseInt(prd.crt_qt));
				const html = `
					<div class="cart-item" data-cart-id="${prd.crt_id}" data-unit-price="${prd.prd_sp}">
						<div class="check">
							<div><input type="checkbox" class="item-checkbox"></div>
							<div class="info">
								<div class="prd-info">상품정보</div>
								<div>옵션</div>
								<div>상품 금액</div>
							</div>
						</div>
						<div class="tie">
							<a href="#">
								<img src="${contextPath}${prd.fil_pt}" alt="${prd.prd_nm}">
							</a>
							<div>
								<a href="sellerShopDetail?sel_nm=${prd.sel_nm}">
									<div class="sel_nm">${prd.sel_nm}</div>
								</a>
								<div class="product-line">
									<div class="prd">
										<div class="prd_nm">${prd.prd_nm}</div>
									</div>
									<div class="opt">
										<div>${prd.clr_nm} / ${prd.cod_nm}</div>
										<div class="quantity-box">
											<button type="button" class="qty-btn minus">-</button>
											<input type="text" class="qty-input" value="${prd.crt_qt}" min="1">
											<button type="button" class="qty-btn plus">+</button>
										</div>
									</div>
									<div class="prd-sp">${prd.prd_sp.toLocaleString()}원</div>
								</div>
								<div class="del">
									<div class="prd-sf">배송비</div>
									<div>${prd.prd_sf.toLocaleString()}원</div>
								</div>
							</div>
						</div>
					</div>
				`;
				sum += totalPrdPrice + prd.prd_sf;
        		totalSf += prd.prd_sf;
				
				container.insertAdjacentHTML("beforeend", html);
				
            });
		},
		error: function(xhr, status, error) {
            console.error("리뷰 데이터를 불러오는 데 실패했습니다:", error);
      	}
	});
	
	// 체크박스 선택해서 삭제
	document.getElementById("cartDelete").addEventListener("click", function () {
		const checkedItems = document.querySelectorAll(".item-checkbox:checked");
		const cartIds = [];
	
		checkedItems.forEach(item => {
			const cartId = item.closest(".cart-item").dataset.cartId;
			if (cartId) cartIds.push({ crt_id: parseInt(cartId) });
		});
		
		// 아무것도 선택 안 했으면 종료
		if (cartIds.length === 0) {
			alert("삭제할 상품을 선택해주세요.");
			return;
		}
		$.ajax({
			url: "deleteCart",
			method: "POST",
			contentType: "application/json",
			data: JSON.stringify(cartIds),
			success: function () {
				alert("선택된 상품이 삭제되었습니다.");
				location.reload(); 
			},
			error: function (xhr, status, error) {
				console.error("삭제 실패:", error);
				alert("삭제 중 오류가 발생했습니다.");
			}
		});
	});
	
	// 옵션 변경시 업데이트 
	$(document).on("click", ".qty-btn", function () {
		// 버튼이 +, -인지 판별
	    const isPlus = $(this).hasClass("plus");
	    const cartItem = $(this).closest(".cart-item");
	    const crt_id = cartItem.data("cart-id");
	    const qtyInput = cartItem.find(".qty-input");
	
	    let qty = parseInt(qtyInput.val());
	    if (isPlus) {
	        qty += 1;
	    } else {
	        if (qty > 1) qty -= 1;
	    }
		
	    qtyInput.val(qty);
		
	    $.ajax({
	        url: "updateCart",
	        method: "POST",
	        contentType: "application/json",
	        data: JSON.stringify({
	            crt_id: crt_id,
	            qty: qty
	        }),
			success: function () {
				const unitPrice = parseInt(cartItem.data("unit-price")); // 단가 가져옴
	            const newTotal = unitPrice * qty;

				cartItem.find(".prd-sp").text(newTotal.toLocaleString() + "원");
			},
	        error: function (xhr, status, error) {
	            console.error("수량 업데이트 실패:", error);
	        }
	    });
	});
	// 전체 선택 체크박스 기능
	document.getElementById("selectAll").addEventListener("change", function () {
		const isChecked = this.checked;
		const itemCheckboxes = document.querySelectorAll(".item-checkbox");
	
		itemCheckboxes.forEach(cb => {
			cb.checked = isChecked;
		});
	});
});