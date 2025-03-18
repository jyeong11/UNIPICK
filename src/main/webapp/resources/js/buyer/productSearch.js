$(function() {
	$(document).ready(function() {
    if (searchterm !== "") {
	debugger;
        $.ajax({
            url: "searchProduct",
            method: "GET",
            data: { query: searchterm },
            success: function(res) {
                let resultHtml = "";
                if (res.length > 0) {
                    res.forEach(function(prd) {
						debugger;
                        resultHtml += `
                            <div class="prd-item">
                                <img src="${prd.prd_image}" alt="${prd.prd_nm}" style="width:100px; height:100px;">
                                <div>${prd.prd_nm}</div>
                                <div>${prd.prd_op}원</div>
								<div>${prd.prd_sp}원</div>
								<div>${prd.prd_bd}</div>
                            </div>
                        `;
                    });
                } else {
                    resultHtml = "<p>검색 결과가 없습니다.</p>";
                }
                $("#search_results").html(resultHtml);
            },
            error: function() {
                alert("검색 중 오류가 발생했습니다.");
            }
        });
    } else {
        alert("검색어를 입력하세요.");
    }
});
	
	
	
});