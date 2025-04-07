$(function() {
	let query = window.location.search;
    let param = new URLSearchParams(query);
	let data = {ord_id : param.get('ord_id')};
	
	$('#home').on('click', function() {
		window.location.href="main";
	});
	
	$('#orderList').on('click', function() {
		window.location.href="myOrderList";
	});
	
	$.ajax({
			url: "myOrderDetail",
			method: "POST",
			data: JSON.stringify(data),
			contentType: "application/json",
			success: function(res) {
				const contextPath = window.location.pathname.substring(0, window.location.pathname.indexOf("/", 2));
				let sum = 0;
				let sumDel = 0;
				let payment = res[0].ord_pm
				let ordPrd = res.map(item => {
					   sum += parseFloat(item.odd_am);
					   sumDel += parseFloat(item.prd_sf);
					   const formatPrdSp = new Intl.NumberFormat().format(item.prd_sp);
					   const formatPrdSf = new Intl.NumberFormat().format(item.prd_sf);
					   
					   const optTotal = parseFloat(item.odd_qt) * parseFloat(item.prd_sp) + parseFloat(item.prd_sf);
					   const formatOptTt = new Intl.NumberFormat().format(optTotal);
		
					   return `<div class="ord-product">
								   <div class="ord-title">
							           <div class="order-selnm">${item.sel_nm}</div>
							           <div class="pr">주문금액</div>
							       </div>
							       <div class="order-info">
							           <div class="order-img">
						                   <img src="${contextPath}${item.fil_pt}">
						               </div>
						               <div class="price-info">
						                   <div class="prd">
						                       <div class="prd-nm">${item.prd_nm}</div>
						                       <div class="prd-sp">${formatPrdSp}원</div>
						                   </div>
										   <div class="prd-1">
										       <div class="prd-nm">${item.cod_nm} / ${item.clr_nm} / ${item.odd_qt}</div>
										   </div>
						                   <div class="prd-2">
						                       <div class="prd-sf">배송비</div>
						                       <div class="prd-sf-wrap">${formatPrdSf}원</div>
						                   </div>
						               </div>
						           </div>
									<div class="ttpr">
							    		<span id="optTotal">상품 주문금액: </span><span>${formatOptTt}원</span>
							    	</div>
								</div>`})
				$('#product-info').append(ordPrd);
				const formatSumPrice = new Intl.NumberFormat().format(sum - sumDel);
				const formatSumDel = new Intl.NumberFormat().format(sumDel);
				$('#totalPrice').prepend(formatSumPrice);
				$('#totalDelPrice').prepend(formatSumDel);
				const formatSumAll = new Intl.NumberFormat().format(sum);
				$('#sum').prepend(formatSumAll);
				$('#payment').append(payment);
				
				let item = res[0];
				$('#shipping_name').val(item.ord_nm);
				$('#shipping_telephone').val(item.ord_ph);
				$('#shipping_zip').val(item.ord_ad);
				$('#shipping_memo').val(item.ord_dm);
				
								
				
        	},
			error: function(xhr, status, error) {
	        	alert("서버 오류가 발생했습니다.");
	        }
		});
	
	
});