$(function() {
	// event
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
        let code = $('#code').val();
        let codeName = $('#codeName').val();
        let useYN = $('#useYN').val();

        $.ajax({
            type: 'POST',
            url: 'cmcodeRegister',
            data: { 
                code: code, 
                codeName: codeName,
                useYN: useYN
            },
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
			data.code_id = word;
		} else if(kind == "option2"){
			data.code_nm = word;
		}
	
        $.ajax({
            type: "GET",
            url: "cmCodeList",
			data: data,
            success: function(res) {
                $('#commonTableBody').empty();
                let bodydata = "";

                res.forEach(function(cd) {
                    bodydata += `
                        <tr>
                            <td class="codeUpdate btn btn-link" data-bs-toggle="modal" 
                       		 data-bs-target="#exampleModal">${cd.code_num}</td>
                            <td>${cd.code_id}</td>
                            <td>${cd.code_nm}</td>
                            <td>${cd.use_yn}</td>
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
			code_num: row.find("td:eq(0)").text(),
	        code_id: row.find("td:eq(1)").text(),
	        code_nm: row.find("td:eq(2)").text(),
	        use_yn: row.find("td:eq(3)").text() 
	    };

		 let bodydata;
            $('#modal-con').empty();
            bodydata = `
                <div class="row mb-3">
                    <label class="col-sm-2 col-form-label">공통코드 : </label>
                    <div class="col-sm-3">
                        <input type="text" id="code" class="col-sm-2 form-control" value="${selectData.code_id}" disabled>
                    </div>
                </div>
                <div class="row mb-3">
                    <label class="col-sm-2 col-form-label">코드명 : </label>
                    <div class="col-sm-3">
                        <input type="text" id="codeName" class="col-sm-2 form-control" value="${selectData.code_nm}">
                    </div>
                </div>
                <div class="row mb-1">
                    <label class="col-sm-2 col-form-label">사용여부 : </label>
                    <div class="col-sm-3">
                        <select id="useYN" class="col-sm-1 form-select">
                            <option value="y">사용</option>
                            <option value="n">미사용</option>
                        </select>
                    </div>
                </div>
				<div align="right">
					<input type="button" id="cmcdUpdate" class="btn btn_main_color" value="수정">
					<input type="button" id="cmcodeDelete" class="btn btn_main_color" value="삭제">
					<input type="button" id="commonColse" class="btn btn_main_color" value="닫기" onclick="location.href ='commonCode'">	
				</div>
            `;
            $('#modal-con').append(bodydata);
		
			document.getElementById("useYN").value = selectData.use_yn;
	
    });
	// 공통코드 수정 버튼 클릭시
	$(document).on("click", "#cmcdUpdate", function() {
		confirm("수정하시겠습니까?") ? alert("수정이 완료되었습니다.") : alert("수정이 취소되었습니다.");
		let code = $('#code').val();
        let codeName = $('#codeName').val();
        let useYN = $('#useYN').val();
		
		$.ajax({
			type: "POST",
			url: "cmcodeUpdate",
			data: { 
                code_id: code,
	            code_nm: codeName,
	            use_yn: useYN
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
			url: "cmcodeDelete",
			data: { 
                code_id: code,
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
                        <div class="col-sm-3">
                            <input type="text" id="code" class="col-sm-2 form-control">
                        </div>
                    </div>
                    <div class="row mb-3">
                        <label class="col-sm-2 col-form-label">코드명 : </label>
                        <div class="col-sm-3">
                            <input type="text" id="codeName" class="col-sm-2 form-control">
                        </div>
                    </div>
                    <div class="row mb-1">
                        <label class="col-sm-2 col-form-label">사용여부 : </label>
                        <div class="col-sm-3">
                            <select id="useYN" class="col-sm-1 form-select">
                                <option value="y">사용</option>
                                <option value="n">미사용</option>
                            </select>
                        </div>
                    </div>
					<div align="right">
						<input type="button" id="coderegister" class="btn btn_main_color" value="등록">
						<input type="button" id="commonColse" class="btn btn_main_color" value="닫기" onclick="location.href ='commonCode'">	
					</div>
                `;
                $('#modal-con').append(bodydata);
            },
            error: function(xhr, status, error) {
                console.error("AJAX error:", error);
            }
        });
    });
});
