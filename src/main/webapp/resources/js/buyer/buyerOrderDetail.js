$(function() {
	let query = window.location.search;
    let param = new URLSearchParams(query);
	let data = {ord_id : param.get('ord_id')}
	
	let sum = 0;
	
	$.ajax({
			url: "myOrderDetail",
			method: "POST",
			data: JSON.stringify(data),
			contentType: "application/json",
			success: function(res) {
				const contextPath = window.location.pathname.substring(0, window.location.pathname.indexOf("/", 2));
				let ordPrd = res.map(item => {const formatPrdSf = new Intl.NumberFormat().format(item.prd_sf);
											   return `<div class="ord-title">
												           <div class="order-selnm">${item.sel_nm}</div>
												           <div class="pr">주문금액</div>
												       </div>
												       <div class="order-info">
												           <div class="order-img">
											                   <img src="${contextPath}/resources${item.fil_pt}">
											               </div>
											               <div>
											                   <div class="prd">
											                       <div class="prd-nm">${item.prd_nm}</div>
											                       <div class="prd-sp"></div>
											                   </div>
											                   <div class="prd-1">
											                       <div class="prd-sf">배송비</div>
											                       <div class="prd-sf-wrap">${formatPrdSf}원</div>
											                   </div>
											               </div>
											           </div>`})
				$('#order-container').append(ordPrd);
				
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