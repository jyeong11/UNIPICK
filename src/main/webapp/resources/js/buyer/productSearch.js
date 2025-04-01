$(function() {
	$(document).ready(function() {
	    if (searchterm !== "") {
	        $.ajax({
	            url: "searchProduct",
	            method: "GET",
	            data: { query: searchterm },
	            success: function(res) {
	                let resultHtml = "";
	                if (res.length > 0) {
	                    res.forEach(function(prd) {
	                        resultHtml += `
	                            <div class="prd-item" data-id="${prd.prd_cd}" data-sel="${prd.sel_nm}" style="cursor: pointer;">
				                    <img src="${contextPath}${prd.fil_pt}" class="prd-img">
									<div class="prdInfo">${prd.sel_nm}</div>
									<div class="prdInfo">${prd.prd_nm}</div>
				                    <div class="prd_pr">
				                    	<div class="dc">${prd.dc}</div>
				                    	<div class="prd_sp">${prd.prd_sp}원</div>
				                    </div>
									<div class="bd">${prd.cod_nm}</div>
				                </div>
	                        `;
	                    });
	                } else {
	                    resultHtml = "<p>검색된 상품이 없습니다.</p>";
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
	$(document).on("click", ".prd-item", function() {
        let prdCd = $(this).data("id");
		let selNm = $(this).data("sel");
    	window.location.href = `productDetail?prd_cd=${prdCd}&sel_nm=${encodeURIComponent(selNm)}`;
    });
});