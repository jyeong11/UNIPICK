$(function() {
	codeList();
	
	$('#codeSearch').on('click',function(){
		codeList();
	}); // 검색 이벤트
	$('#codeSearchWord').on('keydown', function(event){	// att 엔터 이벤트
		if (event.key === 'Enter'){
			$('#codeSearch').click();
		}
	});

    // 공통코드 등록 클릭시
    $(document).on("click", "#coderegister", function() {
		alert("등록 되었습니다.")

		let data = {};
		data.lev_cd = $('#code').val();
		data.lev_nm = $('#codeName').val();
		data.lev_ul = $('#codeLink').val();
		data.lev_yn = $('#useYN').val();
		data.lev_so = $('#sortNum').val();

        $.ajax({
            type: 'POST',
            url: 'lvCodeRegister',
            contentType: 'application/json',  // JSON으로 전송
        	data: JSON.stringify(data),  // 객체를 JSON 문자열로 변환
            success: function() {
                codeList();
				$('#exampleModal').modal('hide');
            },
            error: function(xhr, status, error) {
                console.error("AJAX error:", error);
                alert("데이터를 불러오는데 실패했습니다.");
            }
        });
    });

	// 공통코드 조회(리스트) 
    function codeList() {
	
		let data = {};
		
		let kindElement = document.getElementById('searchKind');
		let wordElement = document.getElementById('codeSearchWord');
		
		let kind = kindElement ? kindElement.value : null;
		let word = wordElement ? wordElement.value : null;
		
		if(kind == "option1" && word != ''){
			data.lev_cd = word;
		} else if(kind == "option2"){
			data.lev_nm = word;
		}
        $.ajax({
            type: "GET",
            url: "lvCodeList",
			data: data,
            success: function(res) {
                $('#commonTableBody').empty();
                let bodydata = "";

                res.forEach(function(cd) {
                    bodydata += `
                        <tr>
                            <td class="codeUpdate btn btn-link no-border" data-bs-toggle="modal" 
                       		 data-bs-target="#exampleModal">${cd.lev_nb}</td>
                            <td>${cd.lev_cd}</td>
                            <td>${cd.lev_nm}</td>
							<td>${cd.lev_ul}</td>
							<td>${cd.lev_so}</td>
							<td>${cd.lev_yn}</td>
                        </tr>
                    `;
                });

                $('#commonTableBody').append(bodydata);
            },
            error: function(xhr, status, error) {
                console.error("AJAX error:", error);
                alert("오류가 발생했습니다.");
            }
        });
    };

    // 공통코드 순번 클릭시 수정창
    $(document).on("click", ".codeUpdate", function() { 
		let row = $(this).closest("tr");
	    
		let selectData = {
			lev_nb: row.find("td:eq(0)").text(),
	        lev_cd: row.find("td:eq(1)").text(),
	        lev_nm: row.find("td:eq(2)").text(),
			lev_ul: row.find("td:eq(3)").text(),
			lev_so: row.find("td:eq(4)").text(),
	        lev_yn: row.find("td:eq(5)").text() 
	    };
		 let bodydata;
            $('#modal-con').empty();
            bodydata = `
                <div class="row mb-3">
                    <label class="col-sm-2 col-form-label">공통코드 : </label>
                    <div class="col-sm-8">
                        <input type="text" id="code" class="col-sm-4 form-control" value="${selectData.lev_cd}" disabled>
                    </div>
                </div>
                <div class="row mb-3">
                    <label class="col-sm-2 col-form-label">코드명 : </label>
                    <div class="col-sm-8">
                        <input type="text" id="codeName" class="col-sm-4 form-control" value="${selectData.lev_nm}">
                    </div>
                </div>
				<div class="row mb-3">
                    <label class="col-sm-2 col-form-label">URL링크 : </label>
                    <div class="col-sm-8">
                        <input type="text" id="codeLink" class="col-sm-4 form-control" value="${selectData.lev_ul}">
                    </div>
                </div>
				<div class="row mb-3">
					<label class="col-sm-2 col-form-label">정렬순번 : </label>
					<div class="col-sm-8">
						<input type="text" id="sortNum" class="col-sm-4 form-control" value="${selectData.lev_so}">
					</div>
				</div>
                <div class="row mb-1">
                    <label class="col-sm-2 col-form-label">사용여부 : </label>
                    <div class="col-sm-8">
                        <select id="useYN" class="col-sm-1 form-select">
                            <option value="y">사용</option>
                            <option value="n">미사용</option>
                        </select>
                    </div>
                </div>
				<div align="right">
					<input type="button" id="cmcdUpdate" class="btn btn_main_color" value="수정">
					<input type="button" id="cmcodeDelete" class="btn btn_main_color" value="삭제">
					<input type="button" id="commonColse" class="btn btn_main_color" value="닫기">	
				</div>
            `;
            $('#modal-con').append(bodydata);
		
			document.getElementById("useYN").value = selectData.lev_yn;
	
    });
	// 공통코드 수정 버튼 클릭시
	$(document).on("click", "#cmcdUpdate", function() {
		confirm("수정하시겠습니까?") ? alert("수정이 완료되었습니다.") : alert("수정이 취소되었습니다.");
		let code = $('#code').val();
        let codeName = $('#codeName').val();
		let codeLink = $('#codeLink').val();
        let useYN = $('#useYN').val();
		let sortNum = $('#sortNum').val();
		$.ajax({
			type: "POST",
			url: "lvCodeUpdate",
			data: { 
                lev_cd: code,
	            lev_nm: codeName,
				lev_ul: codeLink,
	            lev_yn: useYN,
				lev_so: sortNum
            },
			success: function(){
				codeList();
				$('#exampleModal').modal('hide');
			}
		});
	});
	// 공통코드 삭제 버튼 클릭시
	$(document).on("click", "#cmcodeDelete", function() {
		if(confirm("삭제하시겠습니까?")){
			alert("삭제가 완료되었습니다.")
		} else{
			alert("삭제 취소되었습니다.")
			return;
		}
		
		let code = $('#code').val();
		
		$.ajax({
			type: "POST",
			url: "lvCodeDelete",
			data: { 
                lev_cd: code,
            },
			success: function(code){
				codeList();
				$('#exampleModal').modal('hide');
			}
		});
	});
    
	
	// 공통코드 등록
    $("#btnModal").on("click", function() {
        $.ajax({
            type: "GET",
            success: function() {
                let bodydata;
                $('#modal-con').empty();
                bodydata = `
                    <div class="row mb-3">
                        <label class="col-sm-2 col-form-label">공통코드 : </label>
                        <div class="col-sm-8">
                            <input type="text" id="code" class="col-sm-4 form-control">
                        </div>
                    </div>
                    <div class="row mb-3">
                        <label class="col-sm-2 col-form-label">코드명 : </label>
                        <div class="col-sm-8">
                            <input type="text" id="codeName" class="col-sm-4 form-control">
                        </div>
                    </div>
                    <div class="row mb-3">
                        <label class="col-sm-2 col-form-label">URL링크 : </label>
                        <div class="col-sm-8">
                            <input type="text" id="codeLink" class="col-sm-4 form-control">
                        </div>
                    </div>
					<div class="row mb-3">
						<label class="col-sm-2 col-form-label">정렬순번 : </label>
						<div class="col-sm-8">
							<input type="text" id="sortNum" class="col-sm-4 form-control">
						</div>
					</div>
                    <div class="row mb-1">
                        <label class="col-sm-2 col-form-label">사용여부 : </label>
                        <div class="col-sm-8">
                            <select id="useYN" class="col-sm-1 form-select">
                                <option value="y">사용</option>
                                <option value="n">미사용</option>
                            </select>
                        </div>
                    </div>
					<div align="right">
						<input type="button" id="coderegister" class="btn btn_main_color" value="등록">
						<input type="button" id="commonColse" class="btn btn_main_color" value="닫기">	
					</div>
                `;
                $('#modal-con').append(bodydata);
            },
            error: function(xhr, status, error) {
                console.error("AJAX error:", error);
            }
        });
    });

	$(document).on("click", "#commonColse", function() {
	    $('#exampleModal').modal('hide'); // 모달 닫기
	});
});
