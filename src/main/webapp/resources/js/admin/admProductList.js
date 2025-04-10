$(function() {
	prdLoad();
	
	$('#search').on('click',function(){
		prdLoad();
	});
	
	// 검색 이벤트
	$('#ListSearchWord').on('keydown', function(event){
		if (event.key === 'Enter'){
			$('#search').click();
		}
	});
	
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
	
	// 모달 닫기
	$(document).on("click", "#commonDetailColse", function() {
    	$('#exampleModal').modal('hide'); 
	});
	
	// 검색시 페이징
	$('#noticeSearch').on('click', function() {
	    currentPage = 1;
	    prdLoad();
	});

	// 페이징 버튼 클릭시
	$('#pageList').on('click', '.page-link', function(e) {
	    e.preventDefault();
	    let selectedPage = parseInt($(this).data('page'));
	console.log("클릭된 페이지:", $(this).data('page')); 
	    if (selectedPage && selectedPage !== currentPage) {
	        currentPage = selectedPage;
	        prdLoad(); 
	    }
	});
});
let currentPage = 1;
const listLimit = 10;

function prdLoad(){
	let kind = $('#searchKind').val();
	let word = $('#ListSearchWord').val();
	
	let offset = (currentPage - 1) * listLimit;
	
	let data = {
		limit: listLimit,
		offset: offset
	};
	if (kind && word) {
		data[kind] = word;
	}
	
	
	$.ajax({
		url: "admproductList",
		method: "POST",
		data: data,
		dataType: "json",
		success: function(res) {
			renderPrdTbody(res.list);
			renderPagination(res.totalCount, currentPage);
		},
		error: function(xhr, status, error) {
				alert("오류가 발생했습니다! 다시 접속해주세요.");
		}
	});
}
function renderPrdTbody(prd) {
	const Tbody = $("#prdTableBody");
	Tbody.empty();
	if (!prd || prd.length === 0) {
        Tbody.append(`<tr><td colspan="9" class="text-center">접수된 상품이 없습니다.</td></tr>`);
        return;
    }
	
	prd.forEach((prd,idx) => {
		const row =  `
			<tr>
				<td class="prdList"" data-bs-toggle="modal" 
                    data-bs-target="#exampleModal"> ${(currentPage - 1) * listLimit + idx + 1}</td>
				<td>${prd.prd_cd}</td>
				<td>${prd.prd_nm}</td>
				<td>${prd.prd_sp.toLocaleString()}원</td>
				<td>${prd.sel_nm}</td>
				<td>${prd.prd_st}</td>
			</tr>
		`;
		$("#prdTableBody").append(row);
	});
}

function renderPrdDetail(res) {
 	let statusOptions = res.statusList;
    // 0번 인덱스 값만 사용
    let firstRes = res.prdList[0];

    // 사이즈, 색상, 재고수량을 순회하면서 표시할 값 준비
    let sizes = res.prdList.map(item => item.cod_nm).join(', ') || '사이즈 없음';
    let colors = res.prdList.map(item => item.clr_nm).join(', ') || '색상 없음';
    let stockQty = res.prdList.map(item => item.prd_qt).join(', ') || '재고수량 없음';

    let bodydata = `
        <div class="row mb-3">
            <label class="col-sm-2 col-form-label">상품코드 : </label>
            <div class="col-sm-8">
                <span id="code" class="col-sm-4 form-control-plaintext">${firstRes.prd_cd}</span>
            </div>
        </div>
        <div class="row mb-3">
            <label class="col-sm-2 col-form-label">스토어 명 : </label>
            <div class="col-sm-8">
                <span id="codeNameSelect" class="col-sm-4 form-control-plaintext">${firstRes.sel_nm}</span>
            </div>
        </div>
        <div class="row mb-3">
            <label class="col-sm-2 col-form-label">정가 : </label>
            <div class="col-sm-8">
                <span id="codeDetailName" class="col-sm-4 form-control-plaintext">${parseInt(firstRes.prd_op).toLocaleString()}원</span>
            </div>
        </div>
        <div class="row mb-3">
            <label class="col-sm-2 col-form-label">판매가 : </label>
            <div class="col-sm-8">
                <span id="sortNum" class="col-sm-4 form-control-plaintext">${parseInt(firstRes.prd_sp).toLocaleString()}</span>
            </div>
        </div>
        <div class="row mb-1">
            <label class="col-sm-2 col-form-label">사이즈 : </label>
            <div class="col-sm-8">
                <span id="productColor" class="col-sm-4 form-control-plaintext">${sizes}</span>
            </div>
        </div>
        <div class="row mb-1">
            <label class="col-sm-2 col-form-label">색상 : </label>
            <div class="col-sm-8">
                <span id="productColor" class="col-sm-4 form-control-plaintext">${colors}</span>
            </div>
        </div>
        <div class="row mb-1">
            <label class="col-sm-2 col-form-label">재고수량 : </label>
            <div class="col-sm-8">
                <span id="stockQty" class="col-sm-4 form-control-plaintext">${stockQty}</span>
            </div>
        </div>
        <div class="row mb-1">
            <label class="col-sm-2 col-form-label">상태 : </label>
            <div class="col-sm-8">
                 <select id="useYN" class="col-sm-4 form-select">
                    ${statusOptions.map(status => 
                        `<option value="${status.cod_cd}" ${firstRes.prd_st === status.cod_cd ? 'selected' : ''}>${status.cod_nm}</option>`
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

function renderPagination(totalCount, currentPage) {
        let totalPages = Math.ceil(totalCount / listLimit);
        let $pagination = $('#pageList');
        $pagination.empty();

        let startPage = Math.max(1, currentPage - 2);
        let endPage = Math.min(totalPages, currentPage + 2);
        if (currentPage > 1) {
            $pagination.append(`<a href="#" class="page-link" data-page="${currentPage - 1}">이전</a>`);
        }

        for (let i = startPage; i <= endPage; i++) {
            let activeClass = (i === currentPage) ? "active" : "";
            $pagination.append(`<a href="#" class="page-link ${activeClass}" data-page="${i}">${i}</a>`);
        }

        if (currentPage < totalPages) {
            $pagination.append(`<a href="#" class="page-link" data-page="${currentPage + 1}">다음</a>`);
        }
}



