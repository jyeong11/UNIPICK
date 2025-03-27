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
				let sum = 0;
				let sumDel = 0;
				let ordPrd = res.map(item => {
											   let seller = new Set();
											   if(!seller.has(item.sel_nm)){
											   	   sumDel += parseInt(item.prd_sf, 10);
											   }
								
												debugger;
											   sum += parseFloat(item.odd_am);
											   const formatPrdSf = new Intl.NumberFormat().format(item.prd_sf);
											   const formatPrdSp = new Intl.NumberFormat().format(item.prd_sp);
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
											                       <div class="prd-sp">${formatPrdSp}원</div>
											                   </div>
											                   <div class="prd-1">
											                       <div class="prd-sf">배송비</div>
											                       <div class="prd-sf-wrap">${formatPrdSf}원</div>
											                   </div>
											               </div>
											           </div>`})
				$('#order-container').append(ordPrd);
				const formatSumPrice = new Intl.NumberFormat().format(sum);
				const formatSumDel = new Intl.NumberFormat().format(sumDel);
				$('#totalPrice').prepend(formatSumPrice);
				$('#totalDelPrice').prepend(formatSumDel);
				const formatSumAll = new Intl.NumberFormat().format(sum + sumDel);
				$('#sum').prepend(formatSumAll);
				
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