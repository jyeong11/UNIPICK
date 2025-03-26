$(function() {
	
	search();
	$('#ordSearch').on('click', function() {
		search();
	});
	$('.search-radio').on('click', function() {
		search();
	});
	
});

function search() {
	
	let selectValue = $('input[name="choice"]:checked').val();
	let today = new Date(); // 현재 날짜
	
	let dateString = "";
	let searchData = $('#searchData').val();
	
	if(selectValue != 'option3'){
		let num = 12;
		if(selectValue == 'option1'){
			num = 3;
		}
		today.setMonth(today.getMonth() - num);
		
		let year = today.getFullYear();
		let month = ('0' + (today.getMonth() + 1)).slice(-2);
		let day = ('0' + today.getDate()).slice(-2);
		
		dateString = year + '-' + month  + '-' + day;
	}
	
	let data = {
		date : dateString,
		searchData : searchData
	};
	debugger;
	
	$.ajax({
			url: "OrderListData",
			method: "POST",
			data: JSON.stringify(data),
			contentType: "application/json",
			success: function(res) {
				$('#cards').empty();
				let ord = new Set();
				debugger;
				let card = res.map(item => {
											if(ord.has(item.ord_id)) {
												return
											}
											const date = new Date(item.ord_at).toLocaleString();
											return `<div class="card" id="${item.ord_id}">
														<div>${date}</div>
													</div>`;})
								.join('');
				$('#cards').append(card);
				
				const contextPath = window.location.pathname.substring(0, window.location.pathname.indexOf("/", 2));
				
				res.forEach(item => {
					let display = 'none';
					if (item.odd_st === "배송완료"){
						display = 'show';
					}
	                let cardContent = `<div class="order-info">
										   <div><b>${item.sel_nm}</b></div>
										   <div class="second-info">
										   	   <div><img src="${contextPath}/resources${item.fil_pt}" class="prd-img"></div>
											   <div>
										           <div>${item.odd_st}</div>
											       <div>${item.prd_nm}</div>
												   <div>${item.clr_nm} / ${item.cod_nm} / ${item.odd_qt}개</div>
											       <div><b>${item.odd_am}원</b></div>
												   <div>
											           <button class="order-btn ${display}">리뷰쓰기</button>
											           <button class="order-btn">문의하기</button>
										   	       </div>
											   </div>
										   </div>
	                				   </div>`;
	                $(`#${item.ord_id}`).append(cardContent);
	            });
				
				
				
        	},
			error: function(xhr, status, error) {
	        	alert("서버 오류가 발생했습니다.");
	        }
		});
}






