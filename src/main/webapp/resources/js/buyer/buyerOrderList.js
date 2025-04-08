$(function() {
	const contextPath = window.location.pathname.substring(0, window.location.pathname.indexOf("/", 2));
		
	search();
	$('#ordSearch').on('click', function() {
		search();
	});
	$('.search-radio').on('change', function() {
		search();
	});
	$('#searchData').on('keyup', function(event) {
	    if (event.key === "Enter") {
	        search();
	    }
	});
	$(document).on('click', '#reviewBtn', function(event) {
	    event.preventDefault();

		if ($(this).hasClass('noneClick')) {
			alert('이미 리뷰를 작성하였습니다.');
	        return;
    	}

		let oddId = $(this).data('value');
	    window.location.href = 'myReview?odd_id=' + oddId;
	});
	
	$(document).on('click', '#questionBtn', function(event) {
	    event.preventDefault();
		var popupUrl = contextPath + "/chat/product-inquiry?prd_cd=" + $(this).data('prd') + "&prd_nm=" + $(this).data('sel');
			                window.open(popupUrl, "상품문의", "width=500,height=700");
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
	
	$.ajax({
		url: "OrderListData",
		method: "POST",
		data: JSON.stringify(data),
		contentType: "application/json",
		success: function(res) {
			$('#cards').empty();
			let ord = new Set();
			let card = res.map(item => {
										if(ord.has(item.ord_id)) {
											return
										}
										const date = new Date(item.ord_at).toLocaleString();
										ord.add(item.ord_id);
										return `<div class="card" id="${item.ord_id}">
													<div class="top-info">
														<div>${date}</div>
														<div><a href="orderDetail?ord_id=${item.ord_id}" class="detail-link">상세정보</a></div>
													</div>
												</div>`;})
							.join('');
			$('#cards').append(card);
			
			const contextPath = window.location.pathname.substring(0, window.location.pathname.indexOf("/", 2));
			
			res.forEach(item => {
				let display = 'none';
				if (item.odd_st === "배송완료"){
					display = 'show';
				}
				const formatOddAm = new Intl.NumberFormat().format(item.odd_am);
				let revName = "리뷰쓰기";
				let revClass = " ";
				if(item.rev_id){
					revName = "리뷰완료";
					revClass = " noneClick";
				}
                let cardContent = `<a href="productDetail?prd_cd=${item.prd_cd}&sel_nm=${item.sel_nm}" class="product-link">
									   <div class="order-info">
									   		<div><b>${item.sel_nm}</b></div>
									   		<div class="left-info">
									   	   		<div><img src="${contextPath}${item.fil_pt}" class="prd-img"></div>
										   		<div class="right-info">
									           		<div>${item.odd_st}</div>
										       		<div>${item.prd_nm}</div>
											   		<div>${item.clr_nm} / ${item.cod_nm} / ${item.odd_qt}개</div>
										       		<div><b id="price">${formatOddAm}원</b></div>
											   		<div>
										           		<button id="reviewBtn" data-value="${item.odd_id}" class="order-btn ${display}${revClass} " >${revName}</button>
										           		<button id="questionBtn" class="order-btn" data-prd="${item.prd_cd}" data-sel="${item.sel_nm}">문의하기</button>
									   	       		</div>
										  		 </div>
									   		</div>
                				   		</div>
									</a>`;
                $(`#${item.ord_id}`).append(cardContent);
            });
    	},
		error: function(xhr, status, error) {
        	alert("서버 오류가 발생했습니다.");
        }
	});
}






