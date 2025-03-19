$(function() {
	prdLoad();
	
	$(document).on('click', '.prdList', function(){
		let row = $(this).closest("tr");
		
		let data = {prd_cd:  row.find("td:eq(1)").text()}
		$.ajax({
			url:"admprdListDetail",
			method: "POST",
			data: data,
			success: function(res) {
				renderPrdDetail(res);
			},
			error: function(xhr, status, error) {
				alert("오류가 발생했습니다! 다시 접속해주세요.");
			}
		});
	});
	$(document).on('click', '#codeDetailRegister', function() {
		let selectStatus = $("#useYN").val();
		let prd_cd = $("#code").text();
		$.ajax({
			url: "selectPrdstatus",
			method: "POST",
			data: {
				status: selectStatus,
				prd_cd: prd_cd 
			},
			success: function(res) {
				alert("저장되었습니다.");
				window.location.href = "/UNIPICK/admProductList";
			},
			error: function(xhr, status, error) {
				alert("오류가 발생했습니다! 다시 접속해주세요.");
				
			} 
		});
	});
	$(document).on("click", "#commonDetailColse", function() {
	    $('#exampleModal').modal('hide'); // 모달 닫기
	});
});

function prdLoad(){
	let data = {};
	
	let kindElement = document.getElementById('searchKind');
	let wordElement = document.getElementById('ListSearchWord');
	
	let kind = kindElement ? kindElement.value : null;
	let word = wordElement ? wordElement.value : null;
	
	if(kind == "option1" && word != ''){
		data.prd_cd = word;
	} else if(kind == "option2"){
		data.prd_nm = word;
	} else if(kind == "option3"){
		data.store_nm = word;
	} else if(kind == "option3"){
		data.store_st = word;
	}
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
function renderPrdDetail(res) {
	let statusOptions = ["승인", "반려", "접수"];
    let bodydata = `
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
                <span id="productDescription" class="col-sm-4 form-control-plaintext">${res.prd_desc || '상품설명 값없음'}</span>
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
                <span id="stockQty" class="col-sm-4 form-control-plaintext">${res.stock_qty || '재고수량도 없음'}</span>
            </div>
        </div>
        <div class="row mb-1">
            <label class="col-sm-2 col-form-label">색상 : </label>
            <div class="col-sm-8">
                <span id="productColor" class="col-sm-4 form-control-plaintext">${res.colors || '색상도 없음'}</span>
            </div>
        </div>
        <div class="row mb-1">
            <label class="col-sm-2 col-form-label">상태 : </label>
            <div class="col-sm-8">
                <select id="useYN" class="col-sm-4 form-select">
                    ${statusOptions.map(status => 
                    `<option value="${status}" ${res.prd_st === status ? 'selected' : ''}>${status}</option>`
                ).join('')}
                </select>
            </div>
        </div>
        <div align="right">
            <input type="button" id="codeDetailRegister" class="btn btn_main_color" value="저장">
            <input type="button" id="commonDetailColse" class="btn btn_main_color" value="닫기">	
        </div>
    `;
    $('#modal-con').empty().append(bodydata);
}


