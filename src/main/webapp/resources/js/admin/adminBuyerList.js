let dtModal;
let first = true;

$(function() {
	buyerList();

	$('#buyerSearch').on('click',function() {
		buyerList();
	}); 
	$('#buyerSearchWord').on('keydown', function(event) {	
		if (event.key === "Enter"){
			$('#buyerSearch').click();
		}
	});
	
    $('#buyerListTable').on('click', 'tr td:nth-child(2)', function () {
		let acc_st = $(this).closest('tr').find('td').eq(5).text()
		modal($(this), acc_st);
	});
	
	 $(document).on('click', '#close', function() {
        if (dtModal) {
            dtModal.hide();
        }
    });

	function buyerList() {
		let data = {};
		
		let kindElement = document.getElementById('buyerSearchKind');
		let wordElement = document.getElementById('buyerSearchWord');
		let stKindElement = document.getElementById('buyerStatusKind');
		
		let kind = kindElement ? kindElement.value : null;
		let word = wordElement ? wordElement.value : null;
		let stKind = stKindElement ? stKindElement.value : null;
		
		data[kind] = word;
		data["cod_cd"] = stKind;
		
		$.ajax({
		url: "getBuyerInfo",
		method: "POST",
		data: data,
		success: function (res) {
			
			if(first){
				let buyerStatus = res.status.map(item => `<option value="${item.cod_cd}">${item.cod_nm}</option>`)
											.join('')
				$('#buyerStatusKind').append(buyerStatus);
				first = false;
			}
			
			let tableBody = $("#buyerListTable");
            tableBody.empty();
			let buyers = res.buyer.map(buyer => {const date = new Date(buyer.acc_at).toLocaleString();
									return `<tr>
												<td>${buyer.rn}</td>
												<td>${buyer.buy_em}</td>
												<td>${buyer.buy_nm}</td>
												<td>${buyer.buy_nn}</td>
												<td>${date}</td>
												<td>${buyer.cnt_rp}</td>
												<td>${buyer.cod_nm}</td>
											</tr>`})
							.join('');
                tableBody.append(buyers);
		},
		error: function (xhr, status, error) {
                alert("데이터를 불러오는 데 실패했습니다.");
        }
		
	});
	}
	
	function modal(buy_em, acc_st) {
		let data = {buy_em : buy_em.text()};
		
		$.ajax({
			url: "getBuyerInfo",
			method: "POST",
			data: data,
			success: function (res) {
				$('#modal-con').empty();
				let buyer = res.buyer.map(buy => { const date = new Date(buy.acc_at).toLocaleString();
				return `<div class="row mb-3">
                    <label class="col-sm-3 col-form-label">이메일 : </label>
                    <div class="col-sm-8">
                        <input type="text" id="buyEm" class="col-sm-12 form-control" value="${buy.buy_em}" disabled>
                    </div>
                </div>
                <div class="row mb-3">
                    <label class="col-sm-3 col-form-label">이름 : </label>
                    <div class="col-sm-8">
                        <input type="text" id="buyNm" class="col-sm-12 form-control" value="${buy.buy_nm}" disabled>
                    </div>
                </div>
				<div class="row mb-3">
                    <label class="col-sm-3 col-form-label">닉네임 : </label>
                    <div class="col-sm-8">
                        <input type="text" id="buyNN" class="col-sm-12 form-control" value="${buy.buy_nn}" disabled>
                    </div>
                </div>
				<div class="row mb-3">
                    <label class="col-sm-3 col-form-label">성별 : </label>
                    <div class="col-sm-8">
                        <input type="text" id="buyGn" class="col-sm-12 form-control" value="${buy.buy_gn}" disabled>
                    </div>
                </div>
				<div class="row mb-3">
                    <label class="col-sm-3 col-form-label">전화번호 : </label>
                    <div class="col-sm-8">
                        <input type="text" id="buyPh" class="col-sm-12 form-control" value="${buy.buy_ph}" disabled>
                    </div>
                </div>
				<div class="row mb-3">
                    <label class="col-sm-3 col-form-label">가입일시 : </label>
                    <div class="col-sm-8">
                        <input type="text" id="date" class="col-sm-12 form-control" value="${date}" disabled>
                    </div>
                </div>
				<div class="row mb-3">
                    <label class="col-sm-3 col-form-label">누적 신고수 : </label>
                    <div class="col-sm-8">
                        <input type="text" id="buySt" class="col-sm-12 form-control" value="${buy.cnt_rp}" disabled>
                    </div>
                </div>
                <div class="row mb-3">
                    <label class="col-sm-3 col-form-label">계정상태 : </label>
                    <div class="col-sm-8">
                        <input type="text" id="buySt" class="col-sm-12 form-control" value="${buy.cod_nm}" disabled>
                    </div>
                </div>
				<div align="right">
					<input type="button" id="close" class="btn btn_main_color modal-close" value="닫기">	
				</div>`})
					
			$('#modal-con').append(buyer);
			
			const detail = document.getElementById('exampleModal');
			dtModal = new bootstrap.Modal(detail);
			dtModal.show();
			
			},
			error: function(xhr, status, error) {
                alert("데이터를 불러오는 데 실패했습니다.");
        	}
			
		});
		
	}
});
