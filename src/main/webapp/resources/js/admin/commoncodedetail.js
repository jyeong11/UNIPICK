$(function() {
	codeDetailList();
	
	$('#codeDetailSearch').on('click',function(){
		codeDetailList();
	}); // att 검색 이벤트
	$('#codeDetailSearchWord').on('keydown', function(event){	// att 엔터 이벤트
		if (event.key === 'Enter'){
			$('#codeDetailSearch').click();
		}
	});
	
	// 상세공통코드 조회
	function codeDetailList() {
		
		let data = {};
		
		let kindElement = document.getElementById('searchKind');
		let wordElement = document.getElementById('codeDetailSearchWord');
		
		let kind = kindElement ? kindElement.value : null;
		let word = wordElement ? wordElement.value : null;
		
		if(kind == "option1" && word != ''){
			data.com_cd = word;
		} else if(kind == "option2"){
			data.cod_cd = word;
		} else if(kind == "option3"){
			data.cod_nm = word;
		}
		
		$.ajax({
			type: "GET",
			url: "cmDetailCodeList",
			data: data,
			success: function(res) {
				$('#commonDetailTableBody').empty();
				let tablebody;
				
                res.forEach(function(cd) {
					debugger;
                    tablebody += `
                        <tr>
							<td class="codeDeatilUpdate btn btn-link project_font_color" data-bs-toggle="modal" 
                            data-bs-target="#exampleModal">${cd.cod_nb}</td>
							<td>${cd.com_cd}</td>
							<td>${cd.com_nm}</td>
                            <td>${cd.cod_cd}</td>
							<td>${cd.cod_nm}</td>
							<td>${cd.cod_so}</td>
							<td>${cd.cod_yn}</td>
                        </tr>
                    `;
				});
					
				$('#commonDetailTableBody').append(tablebody);
			},
			error: function(xhr, status, error) {
				console.error("AJAX error:", error);
				alert("오류가 발생했습니다.");
			}
		
		});
	};
	
	// 상세공통코드 등록 화면
	$("#btnModal").on("click", function() {
		$.ajax({
			type: "GET",
			url:"cmCodeList",
			success: function(res){
				let bodydata;
				$('#modal-con').empty();
					 bodydata = `
						<div class="row mb-3">
							<label class="col-sm-2 col-form-label">공통코드 : </label>
							<div class="col-sm-3">
								<input type="text" id="code" class="col-sm-2 form-control" value="${res[0].code_id}" disabled>
							</div>
						</div>
						<div class="row mb-3">
							<label class="col-sm-2 col-form-label">코드명 : </label>
							<div class="col-sm-3">
								<select id="codeNameSelect" class="col-sm-2 form-select"></select>
							</div>
						</div>
						<div class="row mb-3">
							<label class="col-sm-2 col-form-label">상세코드 : </label>
							<div class="col-sm-3">
								<input type="text" id="codeDetail" class="col-sm-2 form-control">
							</div>
						</div>
						<div class="row mb-3">
							<label class="col-sm-2 col-form-label">상세코드명 : </label>
							<div class="col-sm-3">
								<input type="text" id="codeDetailName" class="col-sm-2 form-control">
							</div>
						</div>
						<div class="row mb-3">
							<label class="col-sm-2 col-form-label">정렬순번 : </label>
							<div class="col-sm-3">
								<input type="text" id="sortNum" class="col-sm-2 form-control">
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
							<input type="button" id="codeDetailRegister" class="btn btn_main_color" value="등록">
							<input type="button" id="commonDetailColse" class="btn btn_main_color" value="닫기" onclick="location.href ='commonCodeDetail'">	
						</div>
					`;
				
				$('#modal-con').append(bodydata);
					
					res.forEach(function(code) {
						$('#codeNameSelect').append(`<option value="${code.code_id}">${code.code_nm}</option>`);
					});
			},
			error: function(xhr, status, error) {
                console.error("AJAX error:", error);
            }
		});
	});
	
	$(document).on('change', '#codeNameSelect', function(){
		$('#code').val($(this).val());
	})
	
	// 상세공통코드 등록 화면 등록 클릭시
	 $(document).on('click', '#codeDetailRegister', function(){
		confirm("등록하시겠습니까?") ? alert("등록이 완료되었습니다.") : alert("등록이 취소되었습니다.");
		let data = {};
		data.code_id = $('#code').val();
		data.detail_id = $('#codeDetail').val();
		data.code_nm = $('#codeDetailName').val();
		data.use_yn = $('#useYN').val();
		data.code_sort = $('#sortNum').val();
		
		$.ajax({
			type: 'POST',
			url: 'cmDatailCodeRegister',
			data: data,
			success: function() {
				codeDetailList();
				$('#exampleModal').modal('hide');
			},
			 error: function(xhr, status, error) {
                console.error("AJAX error:", error);
                alert("데이터를 불러오는데 실패했습니다.");
			}
		});
	});
	
	$(document).on('change', '#codeNameSelect', function(){
		$('#code').val($(this).val());
	});
	
	// 상세공통코드 수정 화면
	let selectData;
	$(document).on('click', '.codeDeatilUpdate', function(){
		let row = $(this).closest("tr");
	    
		selectData = {
	        code_id: row.find("td:eq(1)").text(),
			code_nm: row.find("td:eq(2)").text(),
	        detail_id: row.find("td:eq(3)").text(),
			detailcode_nm: row.find("td:eq(4)").text(),
			use_yn: row.find("td:eq(5)").text(),
	        code_sort: row.find("td:eq(6)").text() 
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
						<input type="text" id="codeNameSelect" class="col-sm-2 form-control" value="${selectData.code_nm}" disabled>
					</div>
				</div>
				<div class="row mb-3">
					<label class="col-sm-2 col-form-label">상세코드 : </label>
					<div class="col-sm-3">
						<input type="text" id="codeDetail" class="col-sm-2 form-control" value="${selectData.detail_id}">
					</div>
				</div>
				<div class="row mb-3">
					<label class="col-sm-2 col-form-label">상세코드명 : </label>
					<div class="col-sm-3">
						<input type="text" id="codeDetailName" class="col-sm-2 form-control" value="${selectData.detailcode_nm}">
					</div>
				</div>
				<div class="row mb-3">
					<label class="col-sm-2 col-form-label">정렬순번 : </label>
					<div class="col-sm-3">
						<input type="text" id="sortNum" class="col-sm-2 form-control" value="${selectData.code_sort}">
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
					<input type="button" id="cdDetailUpdate" class="btn btn_main_color" value="수정">
					<input type="button" id="cdDetailDelete" class="btn btn_main_color" value="삭제">
					<input type="button" id="commonDetailColse" class="btn btn_main_color" value="닫기" onclick="location.href ='commonCodeDetail'">	
				</div>
			`;
			$('#modal-con').append(bodydata);
		});
		
		// 수정버튼 클릭시
		$(document).on('click', '#cdDetailUpdate', function(){
			confirm("수정하시겠습니까?") ? alert("수정이 완료되었습니다.") : alert("수정이 취소되었습니다.");
			let codeDetail = $('#codeDetail').val();
			let codeDetailName = $('#codeDetailName').val();
	        let sortNum = $('#sortNum').val();
	        let useYN = $('#useYN').val();
			
			$.ajax({
				type: "POST",
				url: "cmcdDetailUpdate",
				data: { 
					beforecodeDetailName: selectData.detail_id, //이전 상세코드
		            codeDetail: codeDetail, // 상세코드
		            codeDetailName: codeDetailName, // 상세코드명
					sortNum: sortNum,
					useYN: useYN,
	            },
				success: function(code){
					codeDetailList();
					$('#exampleModal').modal('hide');
				}
			});
		});
		// 상세코드 삭제버튼 클릭시
		$(document).on('click', '#cdDetailDelete', function(){
			if(confirm("삭제하시겠습니까?")){
				alert("삭제가 완료되었습니다.")
			} else{
				alert("삭제 취소되었습니다.")
				return;
			}
			let codeDetail = $('#codeDetail').val();
			
			$.ajax({
				type: "POST",
				url: "cmcdDetailDelete",
				data: { 
		            codeDetail: codeDetail, //상세코드
	            },
				success: function(code){
					codeDetailList();
					$('#exampleModal').modal('hide');
				}
			});
		});
	});
	