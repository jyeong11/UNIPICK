$(document).ready(function() {
	noticeSearch();
	
	$('#noticeSearch').on('click',function(){
		noticeSearch();
	}); // att 검색 이벤트
	$('#noticeSearchWord').on('keydown', function(event){	// att 엔터 이벤트
		if (event.key === 'Enter'){
			$('#noticeSearch').click();
		}
	});
	
    $("#noticeListTable").on("click", ".not_ti a", function(event) {
        event.preventDefault();

       let not_id = $(this).closest("tr").find(".display_no").data("not_id");
        console.log("디테일 노티스 아이디 : " + not_id);
        
        if (not_id === "" || not_id === "0") {
            alert("올바른 공지번호를 찾을 수 없습니다.");
            return;
        }


function noticeSearch(pageNum = 1) {
	
        let data = {};
		data.pageNum = pageNum;
        
		let kindElement = document.getElementById('noticeSearchKind');
		let wordElement = document.getElementById('noticeSearchWord');
		
		let kind = kindElement ? kindElement.value : null;
		let word = wordElement ? wordElement.value : null;
		
		if(word != null){
			if(word.includes('%')){
				word = word.replace("%", "\\%");
			}
			if(word.includes('_')){
				word = word.replace("_", "\\_");
			}
		}
		
        if(kind == "option1" ){
            data.not_ti = word;
        } else if(kind == "option2"){
            data.dep_nm = word;
        } else if(kind == "option3"){
            data.emp_nm = word;
        }
        $.ajax({
            type:"GET",
            url:"noticeSearch",
            data: $.param(data),
            success: function(res){
                $('#noticeListTable').empty();
				$("#pageList").empty();
                res.list.forEach(function(notice){
                    let row = $('<tr></tr>');
                    row.append('<td class="display_no" data-not_id="' + notice.not_id + '">' + notice.display_no + '</td>');
                    row.append(`<td class="not_ti"><a class="not_ati" href="" data-bs-toggle="modal" data-bs-target="#detailModal">${notice.not_ti}</a></td>`);
                    row.append('<td>' + notice.dep_nm + '</td>');
                    row.append('<td>' + notice.emp_nm + '</td>');
                    row.append('<td>' + notice.date + '</td>');
                    row.append('<td>' + notice.not_ct + '</td>');
                    $('#noticeListTable').append(row);
                });
				paging(res.pageList[2]);
				
            },
            complete: function() {
                $('#noticeSearch').data('loading', false);
            }
        });	
    }

	// 페이징 처리 함수
	function paging(pageInfo) {
		let prevBtn = $("<input>", {
		    type: "button",
			class: "btn btn-link project_font_color",
		    value: "이전",
		    click: function () {
		        if (pageInfo.pageNum > 1) {
					noticeSearch(pageInfo.pageNum - 1);
		        }
		    }
		}).prop("disabled", pageInfo.pageNum === 1);
		$("#pageList").append(prevBtn);
		
		// 페이지 번호 버튼 생성 (startPage ~ endPage)
		for (let i = pageInfo.startPage; i <= pageInfo.endPage; i++) {
		    let pageLink;
		    if (i === pageInfo.pageNum) {
		        // 현재 페이지는 강조 표시
		        pageLink = $("<strong>").text(i);
		    } else {
		        pageLink = $("<a>", {
		            href: "#",
		            text: i,
					class: "pageNum",
		            click: function (e) {
		                e.preventDefault();
						noticeSearch(i);
		            }
		        });
		    }
		    $("#pageList").append(pageLink);
		}
			
	    // '다음' 버튼 생성
	    let nextBtn = $("<input>", {
	        type: "button",
	        value: "다음",
			class: "btn btn-link project_font_color",
	        click: function () {
					noticeSearch(pageInfo.pageNum + 1);
	        }
	    }).prop("disabled", pageInfo.pageNum === pageInfo.maxPage);
	    $("#pageList").append(nextBtn);
    }
	// 페이징 처리 함수 끝
});