let dtModal;
let first = true;

$(function() {
	reportList();

	$('#reportSearch').on('click',function() {
		reportList();
	}); 
	$('#reportSearchWord').on('keydown', function(event) {	
		if (event.key === "Enter"){
			$('#reportSearch').click();
		}
	});
	
    $('#reportListTable').on('click', 'tr td:nth-child(1)', function () {
		const rptStatus = $(this).closest('tr').find('td').eq(5).text();
		modal($(this), rptStatus);
	});
	
	$(document).on('click', '#close', function() {
        if (dtModal) {
            dtModal.hide();
			reportList();
        }
    });

	function reportList() {
		let data = {};
		
		let kindElement = document.getElementById('reportSearchKind');
		let wordElement = document.getElementById('reportSearchWord');
		let stKindElement = document.getElementById('reportStatusKind');
		
		let kind = kindElement ? kindElement.value : null;
		let word = wordElement ? wordElement.value : null;
		let stKind = stKindElement ? stKindElement.value : null;
		
		data[kind] = word;
		data["cod_cd"] = stKind;
		
		$.ajax({
		url: "getReportInfo",
		method: "POST",
		data: data,
		success: function (res) {
			if(first){
				let status = res.rptSt.map(item => `<option value="${item.cod_cd}">${item.cod_nm}</option>`);
				$('#reportStatusKind').append(status);
				first = false;
			}
			
			let tableBody = $("#reportListTable");
            tableBody.empty();
			let reportList = res.report.map(item => {const date = new Date(item.rpt_dt).toLocaleString();
									return `<tr>
												<td>${item.rpt_id}</td>
												<td>${item.rpr_id}</td>
												<td>${item.rpd_id}</td>
												<td>${item.rpt_tg}</td>
												<td>${date}</td>
												<td>${item.cod_nm}</td>
											</tr>`})
							.join('');
                tableBody.append(reportList);
		},
		error: function (xhr, status, error) {
                alert("데이터를 불러오는 데 실패했습니다.");
        }
		
	});
	}
	
	function modal(rpt, rptStatus) {
		
	    let data = { rpt_id: rpt.text() };
	
	    $.ajax({
	        url: "getReportInfo",
	        method: "POST",
	        data: data,
	        success: function (res) {
	            $('#modal-con').empty();
	            let report = res.report.map(item => {
	                const date = new Date(item.rpt_dt).toLocaleString();
	                return `<div class="row mb-3">
	                    <label class="col-sm-3 col-form-label">신고 ID </label>
	                    <div class="col-sm-8">
	                        <input type="text" id="rptId" class="col-sm-12 form-control" value="${item.rpt_id}" disabled>
	                    </div>
	                </div>
	                <div class="row mb-3">
	                    <label class="col-sm-3 col-form-label">신고자 ID : </label>
	                    <div class="col-sm-8">
	                        <input type="text" id="rprId" class="col-sm-12 form-control" value="${item.rpr_id}" disabled>
	                    </div>
	                </div>
	                <div class="row mb-3">
	                    <label class="col-sm-3 col-form-label">신고대상자 ID : </label>
	                    <div class="col-sm-8">
	                        <input type="text" id="rpdId" class="col-sm-12 form-control" value="${item.rpd_id}" disabled>
	                    </div>
	                </div>
	                <div class="row mb-3">
	                    <label class="col-sm-3 col-form-label">신고대상 : </label>
	                    <div class="col-sm-8">
	                        <input type="text" id="rptTg" class="col-sm-12 form-control" value="${item.rpt_tg}" disabled>
	                    </div>
	                </div>
	                <div class="row mb-3">
	                    <label class="col-sm-3 col-form-label">신고내용 : </label>
	                    <div class="col-sm-8">
	                        <textarea id="rptRs" disabled>${item.rpt_rs}</textarea>
	                    </div>
	                </div>
	                <div class="row mb-3">
	                    <label class="col-sm-3 col-form-label">신고일시 : </label>
	                    <div class="col-sm-8">
	                        <input type="text" id="date" class="col-sm-12 form-control" value="${date}" disabled>
	                    </div>
	                </div>
					<div class="row mb-3">
                        <label class="col-sm-3 col-form-label">신고상태 : </label>
                        <div class="col-sm-8">
                            <select id="rpt_st" class="col-sm-4 form-select">
                            </select>
                        </div>
                    </div>
	                <div align="right">
	                    <input type="button" id="close" class="btn btn_main_color modal-close" value="닫기">
	                </div>`;
	            });
	
	            $('#modal-con').append(report);

				let status = res.rptSt.map(item => `<option value="${item.cod_cd}" ${item.cod_nm == rptStatus ? 'selected' : ''} >${item.cod_nm}</option>`)
									  .join('');
				
				$('#rpt_st').append(status);

	            const detail = document.getElementById('exampleModal');
				dtModal = new bootstrap.Modal(detail);
	            dtModal.show();
	        },
	        error: function (xhr, status, error) {
	            alert("데이터를 불러오는 데 실패했습니다.");
	        }
	    });
	}
	
	$(document).on('change', '#rpt_st', function () {
	    const rptId = $('#rptId').val();
	    const newStatus = $(this).val();

		let data = {rpt_id : rptId,
					rpt_st : newStatus}

	    $.ajax({
	        url: "updateReportStatus",
	        method: "POST",
	        data: JSON.stringify(data),
			contentType: "application/json",
	        success: function () {
	        },
	        error: function (xhr, status, error) {
	            alert("데이터를 저장하는 데 실패했습니다.");
	        }
	    });
	});
	
	
});
