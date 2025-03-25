$(function() {
	let query = window.location.search;
	let param = new URLSearchParams(query);
	let prd_cd = param.get('prd_cd');
	$.ajax({
		url: "productOrder",
		method: "POST",
		data: JSON.stringify({ prd_cd: prd_cd }),
		contentType: 'application/json',
		success: function(res){
			let sum = 0;
			let totalShippingFee = 0;
	        if (res.length > 0) {
	            res.forEach(function(item) {
	                $("#order-container").append(`
						<div class="ord-title">
	                    	<div class="order-selnm">${item.sel_nm}</div>
							<div class="pr"> 주문 금액 </div>
						</div>
						<div class="order-info">
	                    	<div class="order-img">
	                        	<img src="${contextPath}/resources${item.fil_pt}">
	                    	</div>
							<div class="prd">
								<div class="prd-nm">${item.prd_nm}</div>
								<div class="prd-sp">${item.prd_sp}원</div>
							<div>
						</div>
						<div class="prd">
								<div class="prd-sf">배송비</div>
								<div class="prd-sf-wrap">${item.prd_sf}원</div>
							<div>
						</div>
	                `);
					 sum += parseInt(item.prd_sp.replace(',', ''));
	            });
				$("#orderInfo-container").html(`
               		 <div class="ttpr">총 주문금액:  ${sum.toLocaleString()}원</div>
            	`);
				$("#deliInfo-container").html(`
					 <form id="delivery-form">
				        <div id="del"><h2>배송지 정보</h2></div>
				        <div class="del-nm"><span>수령인</span><input type="text" id="shipping_name"></div>
				        <div class="del-nm"><span>휴대폰</span><input type="text" id="shipping_telephone"></div>
				        <div class="del-nm"><span>배송주소</span><input type="text" id="shipping_zip"></div>
				        <div class="del-nm"><span>배송메모</span><input type="text" id="shipping_memo" placeholder="최대 100자까지 가능합니다"></div>
				    </form>
            	`);
				$("#delprice-container").html(`
					<div id="total"><h2>최종 결제금액</h2></div>
					<div class="price">
						<div id="total-pr"><span>총 상품금액</span><span>${sum.toLocaleString()}원</span></div>
						<div id="total-dp"><span>총 배송비</span><span> 3,000원</span></div>
					</div>
					<div id="prpr"><span>결제 예상 금액</span><span id="sum">${sum.toLocaleString()}원</span></div>            	
				`);
				$("#payment-container").html(`
					<div id="payment"><h2>결제수단</h2></div>
					<div class="price">
						<div id="payment"><span>빠른페이</span></div>
					</div>
					<div class="card-first">
						<div class="tie">
							<div id="pmregister"><span>유니페이</span></div>
							<button  id ="openButton" class="add_btn"> + 결제 수단 등록</button>
						</div>
					</div> 	
				`);
				$("#term-container").html(`
					<div id="total"><h2>주문내용 확인 및 결제 동의</h2></div>
					<div class="price">
					    <label><input type="checkbox" id="agree_all"> 전체 동의하기</label>
					    <label><input type="checkbox" class="agree_chk"> 유니픽 약관 동의 (필수)</label>
					    <label><input type="checkbox" class="agree_chk"> 개인정보수집 및 이용에 대한 안내 (필수)</label>
					    <label><input type="checkbox" class="agree_chk"> 구매조건 및 개인정보 제3자 제공 (필수)</label>
					</div>
				`);
				
				$("#agree_all").change(function() {
					$(".agree_chk").prop("checked", $(this).prop("checked"));
					ButtonState();
				});

				$(".agree_chk").change(function() {
					$("#agree_all").prop("checked", $(".agree_chk:checked").length === $(".agree_chk").length);
					ButtonState();
				});
	        }
	    },
	    error: function() {
	        alert("주문 정보를 불러오는 데 실패했습니다.");
	    }
	});
	function ButtonState() {
        if ($("#agree_all").prop("checked")) {
            $("#submit-btn").prop("disabled", false).addClass("active");
        } else {
            $("#submit-btn").prop("disabled", true).removeClass("active");
        }
    }
	$(document).on("click", "#openButton", function () {
    	window.open("payment", "_blank", "width=380,height=670");
	});
});