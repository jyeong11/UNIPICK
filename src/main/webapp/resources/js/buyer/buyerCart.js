$(function() {
	let sum = 0;
	
	$.ajax({
		url:"cartSelect",
		method: "POST",
		success: function(res) {
			const container = document.querySelector(".product_posting");
			container.innerHTML = "";
			res.forEach(prd => {
				let totalPrdPrice = parseInt(prd.prd_sp * parseInt(prd.crt_qt));
				const html = `
					<div class="cart-item" data-cart-id="${prd.crt_id}" data-unit-price="${prd.prd_sp}" data-prd-cd="${prd.prd_cd}">
						<div class="check">
							<div><input type="checkbox" class="item-checkbox" checked></div>
							<div class="info">
								<div class="prd-info">상품정보</div>
								<div>옵션</div>
								<div>상품 금액</div>
							</div>
						</div>
						<div class="tie" data-id="${prd.prd_cd}" data-sel="${prd.sel_nm}" style="cursor: pointer;">
							<img src="${contextPath}${prd.fil_pt}" alt="${prd.prd_nm}">
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
										<input type="hidden" class="siz" value="${prd.cod_cd}">
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
								<div class="tt">
									<div class="ttsp">${(prd.prd_sp * parseInt(prd.crt_qt) + prd.prd_sf).toLocaleString()}원</div>
								</div>
							</div>
						</div>
					</div>
				`;
				sum += totalPrdPrice + prd.prd_sf;
				
				container.insertAdjacentHTML("beforeend", html);
				
				 $("#orderInfo-container").html(`
			        <div class="ttpr">총 결제금액:  ${sum.toLocaleString()}원</div>
			    `);
				
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
	
	// 사진 클릭시 해당 상품으로 이동
	$(document).on("click", ".tie", function() {
        let prdCd = $(this).data("id");
		let selNm = $(this).data("sel");
    	window.location.href = `productDetail?prd_cd=${prdCd}&sel_nm=${encodeURIComponent(selNm)}`;
    });
	
	// 옵션 변경시 업데이트 
	$(document).on("click", ".qty-btn", function (e) {
		e.stopPropagation();
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
				const unitPrice = parseInt(cartItem.data("unit-price"));
	            const newTotal = unitPrice * qty;

				cartItem.find(".ttsp").text(newTotal.toLocaleString() + "원");
				updateTotalPrice();
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
		updateTotalPrice();
	});
	// 개별 체크박스가 바뀔 때
	$(document).on("change", ".item-checkbox", function () {
	    updateTotalPrice();

		const allCheckboxes = document.querySelectorAll(".item-checkbox");
		const checkedCheckboxes = document.querySelectorAll(".item-checkbox:checked");

		// 전체 선택 체크박스의 상태 동기화
		document.getElementById("selectAll").checked = allCheckboxes.length === checkedCheckboxes.length;
	});
	
	// 결제하기
	document.querySelector("#price-button button").addEventListener("click", function () {
	    const checkedItems = document.querySelectorAll(".item-checkbox:checked");
		
		if (checkedItems.length === 0) {
	        alert("선택된 상품이 없습니다.");
	        return;
    	}
	    const params = new URLSearchParams();
	
	    checkedItems.forEach(item => {
	        const cartItem = item.closest(".cart-item");
	
	        const prd_cd = cartItem.dataset.prdCd;
	        const [clr_nm, siz_nm] = cartItem.querySelector(".opt div").innerText.split(" / ");
	        const qty = cartItem.querySelector(".qty-input").value;
			const ot = cartItem.querySelector(".siz").value;
	
	        params.append("prd_cd", prd_cd);
	        params.append("clr_nm", clr_nm);
	        params.append("siz_nm", siz_nm);
	        params.append("qty", qty);
			params.append("ot", ot);
	    });
	
	    // 최종 URL 이동
	    location.href = `/UNIPICK/productOrder?${params.toString()}`;
	});
});
// 상품 총 금액 계산 
function updateTotalPrice() {
    let sum = 0;

    document.querySelectorAll(".item-checkbox:checked").forEach(checkbox => {
        const cartItem = checkbox.closest(".cart-item");
        const unitPrice = parseInt(cartItem.dataset.unitPrice);
        const qty = parseInt(cartItem.querySelector(".qty-input").value);
        const shippingFee = parseInt(cartItem.querySelector(".del div:last-child").innerText.replace(/[^0-9]/g, ''));

        sum += unitPrice * qty + shippingFee;
    });

    document.getElementById("orderInfo-container").innerHTML = `
        <div class="ttpr">총 주문금액: ${sum.toLocaleString()}원</div>
    `;
	
	// 결제하기 버튼 활성화
  	const btn = document.querySelector("#price-button button");
	    btn.classList.toggle("active", sum > 0);
}