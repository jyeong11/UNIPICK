$(function() {
	prdLoad();
	
	$(document).on('click', '.prdList', function(){
		let row = $(this).closest("tr");
		
		let data = {prd_cd:  row.find("td:eq(1)").text()}
		debugger;
		$.ajax({
			url:"admprdListDetail",
			method: "POST",
			data: data,
			success: function(res) {
				let bodydata;
				$('#modal-con').empty();
					 bodydata = `
						<div class="row mb-3">
							<label class="col-sm-2 col-form-label">상품코드 : </label>
							<div class="col-sm-8">
			                    <span id="code" class="col-sm-4 form-control-plaintext">${res.prd_cd}</span>
			                </div>
						</div>
						<div class="row mb-3">
							<label class="col-sm-2 col-form-label">스토어 명 : </label>
							<div class="col-sm-8">
			                    <span id="codeNameSelect" class="col-sm-4 form-control-plaintext">${res.sel_nm}</span>
			                </div>
						</div>
						<div class="row mb-3">
							<label class="col-sm-2 col-form-label">상품설명 : </label>
							<div class="col-sm-8">
								<span id="codeNameSelect" class="col-sm-4 form-control-plaintext">상품설명 값없음</span>
							</div>
						</div>
						<div class="row mb-3">
							<label class="col-sm-2 col-form-label">정가 : </label>
							<div class="col-sm-8">
								<span id="codeDetailName" class="col-sm-4 form-control-plaintext">${res.prd_op}</span>
							</div>
						</div>
						<div class="row mb-3">
							<label class="col-sm-2 col-form-label">판매가 : </label>
							<div class="col-sm-8">
								<span id="sortNum" class="col-sm-4 form-control-plaintext">${res.prd_sp}</span>
							</div>
						</div>
						<div class="row mb-1">
							<label class="col-sm-2 col-form-label">재고수량 : </label>
							<div class="col-sm-8">
								<span id="sortNum" class="col-sm-4 form-control-plaintext">재고수량도 없음</span>
							</div>
						</div>
						<div class="row mb-1">
							<label class="col-sm-2 col-form-label">색상 : </label>
							<div class="col-sm-8">
								<span id="sortNum" class="col-sm-4 form-control-plaintext">색상도 없음</span>
							</div>
						</div>
						<div class="row mb-1">
							<label class="col-sm-2 col-form-label">상태 : </label>
							<div class="col-sm-8">
								<select id="useYN" class="col-sm-4 form-select">
										<option>${res.prd_st}</option>
										<option value="y">승인</option>
										<option value="n">반려</option>
								</select>
							</div>
						</div>
						<div align="right">
							<input type="button" id="codeDetailRegister" class="btn btn_main_color" value="저장">
							<input type="button" id="commonDetailColse" class="btn btn_main_color" value="닫기">	
						</div>
					`;
				
				$('#modal-con').append(bodydata);
			},
			error: function(xhr, status, error) {
				alert("오류가 발생했습니다! 다시 접속해주세요.");
			}
		});
	});
});

function prdLoad(){
	$.ajax({
		url: "admproductList",
		method: "POST",
		dataType: "json",
		success: function(res) {
			renderPrdTbody(res);
		},
		error: function(xhr, status, error) {
				alert("오류가 발생했습니다! 다시 접속해주세요.");
		}
	});
}
function renderPrdTbody(prd) {
	const Tbody = $("#prdTableBody");
	Tbody.empty();
	if (prd.length === 0) {
        tableBody.append(`<tr><td colspan="4" class="text-center">접수된 상품이 없습니다.</td></tr>`);
        return;
    }
	
	prd.forEach((prd,idx) => {
		const row =  `
			<tr>
				<td class="prdList btn btn-link no-border" data-bs-toggle="modal" 
                    data-bs-target="#exampleModal">${idx + 1}</td>
				<td>${prd.prd_cd}</td>
				<td>${prd.prd_nm}</td>
				<td>${prd.prd_sp}</td>
				<td>${prd.sel_nm}</td>
				<td>${prd.prd_st}</td>
			</tr>
		`;
		$("#prdTableBody").append(row);
	});
}



