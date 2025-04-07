$(function() {
	codeList();
	
	$('#codeSearch').on('click',function(){
		codeList();
	}); 
	// 검색 이벤트
	$('#codeSearchWord').on('keydown', function(event){
		if (event.key === 'Enter'){
			$('#codeSearch').click();
		}
	});

    // 공통코드 등록 클릭시
    $(document).on("click", "#coderegister", function() {
		alert("등록 되었습니다.")
        let com_cd = $('#code').val();
        let com_nm = $('#codeName').val();
        let com_yn = $('#useYN').val();

        $.ajax({
            type: 'POST',
            url: 'cmcodeRegister',
            data: { 
                com_cd: com_cd, 
                com_nm: com_nm,
                com_yn: com_yn
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
		
		data[kind] = word;
		
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
                            <td class="codeUpdate btn btn-link no-border" data-bs-toggle="modal" 
                       		 data-bs-target="#exampleModal">${cd.com_nb}</td>
                            <td>${cd.com_cd}</td>
                            <td>${cd.com_nm}</td>
							<td>${cd.com_yn}</td>
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
			com_nb: row.find("td:eq(0)").text(),
	        com_cd: row.find("td:eq(1)").text(),
	        com_nm: row.find("td:eq(2)").text(),
	        com_yn: row.find("td:eq(3)").text() 
	    };

		 let bodydata;
            $('#modal-con').empty();
            bodydata = `
                <div class="row mb-3">
                    <label class="col-sm-2 col-form-label">공통코드 : </label>
                    <div class="col-sm-8">
                        <input type="text" id="code" class="col-sm-4 form-control" value="${selectData.com_cd}" disabled>
                    </div>
                </div>
                <div class="row mb-3">
                    <label class="col-sm-2 col-form-label">코드명 : </label>
                    <div class="col-sm-8">
                        <input type="text" id="codeName" class="col-sm-4 form-control" value="${selectData.com_nm}">
                    </div>
                </div>
                <div class="row mb-1">
                    <label class="col-sm-2 col-form-label">사용여부 : </label>
                    <div class="col-sm-8">
                        <select id="useYN" class="col-sm-4 form-select">
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
		
			document.getElementById("useYN").value = selectData.com_yn;
	
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
                com_cd: code,
	            com_nm: codeName,
	            com_yn: useYN
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
                com_cd: code,
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
                    <div class="row mb-1">
                        <label class="col-sm-2 col-form-label">사용여부 : </label>
                        <div class="col-sm-8">
                            <select id="useYN" class="col-sm-4 form-select">
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
