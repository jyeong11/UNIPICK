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
					<div class="cart-item" data-cart-id="${prd.crt_id}">
						<div class="check">
							<div><input type="checkbox"></div>
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
								<div class="prd">
									<div class="prd_nm">${prd.prd_nm}</div>
								</div>
								<div class="opt">
									<div>${prd.clr_nm} / ${prd.cod_nm}</div>
									<div class="crt-qt">${prd.crt_qt}</div>
									<div class="quantity-box">
										<button type="button" class="qty-btn minus">-</button>
										<input type="text" class="qty-input" value="${prd.crt_qt}" min="1">
										<button type="button" class="qty-btn plus">+</button>
									</div>
								</div>
								<div>${prd.prd_op.toLocaleString()}원</div>
								<div>${prd.prd_sp}</div>
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
				
				const lastBox = container.lastElementChild.querySelector(".quantity-box");
				const optBox = container.lastElementChild.querySelector(".opt");
				const minusBtn = lastBox.querySelector(".minus");
				const plusBtn = lastBox.querySelector(".plus");
				const qtyInput = lastBox.querySelector(".qty-input");
				const crtQt = optBox.querySelector(".crt-qt");
				
				
				minusBtn.addEventListener("click", () => {
					let value = parseInt(qtyInput.value, 10);
					if (value > 1) {
						qtyInput.value = value - 1;
						crtQt.textContent = qtyInput.value; 
					}
				});
				
				plusBtn.addEventListener("click", () => {
					let value = parseInt(qtyInput.value, 10);
					qtyInput.value = value + 1;
					crtQt.textContent = qtyInput.value; 
				});
            });
		},
		error: function(xhr, status, error) {
            console.error("리뷰 데이터를 불러오는 데 실패했습니다:", error);
      	}
	});
	
	document.getElementById("cartDelete").addEventListener("click", function () {
	const checkedItems = document.querySelectorAll(".item-checkbox:checked");
	const cartIds = [];

	checkedItems.forEach(item => {
		const cartId = item.closest(".cart-item").dataset.cartId;
		if (cartId) cartIds.push(cartId);
	});
debugger;
	// 아무것도 선택 안 했으면 종료
	if (cartIds.length === 0) {
		alert("삭제할 상품을 선택해주세요.");
		return;
	}

	// AJAX 요청 보내기
	$.ajax({
		url: "deleteCartItems", // → 이 URL은 너가 설정한 컨트롤러에 맞게 바꿔
		method: "POST",
		contentType: "application/json",
		data: JSON.stringify(cartIds), // 배열을 JSON으로 보냄
		success: function () {
			alert("선택된 상품이 삭제되었습니다.");
			location.reload(); // 새로고침하거나 DOM에서 직접 제거해도 됨
		},
		error: function (xhr, status, error) {
			console.error("삭제 실패:", error);
			alert("삭제 중 오류가 발생했습니다.");
		}
	});
});
});