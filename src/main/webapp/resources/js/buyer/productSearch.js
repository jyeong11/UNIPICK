$(function() {
	
	// 찜
	$(document).on("click", ".prdImg-div .heart", function(event) {
		event.stopPropagation();
		wish($(this));
	});
	
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
							let heartClass = prd.buy_em ? 'fa-solid yellow' : 'fa-regular';
	                        resultHtml += `
	                            <div class="prd-item" data-id="${prd.prd_cd}" data-sel="${prd.sel_nm}" style="cursor: pointer;">
									<div class="prdImg-div">
				                    	<img src="${contextPath}${prd.fil_pt}" class="prd-img">
										<i class="${heartClass} fa-heart heart" data-value="${prd.prd_cd}"></i>
									</div>
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

// 찜 버튼
function wish(heart) {
	heartIcon = heart[0];
	let prd_cd = heart.attr('data-value');
	heartIcon.classList.toggle("fa-regular");
	heartIcon.classList.toggle("fa-solid");
	heartIcon.classList.toggle("yellow");
	let action = "insert";
	
	if(heartIcon.classList.contains("fa-regular")) {
		 action = "delete";
	}
	
	data = {prd_cd : prd_cd, action : action};
	$.ajax({
		type: "POST",
        url: "wishList",
		data: JSON.stringify(data),
		contentType: "application/json",
        error: function(xhr, status, error) {
        	if(confirm("로그인 후 사용하실 수 있습니다.\n 로그인페이지로 이동하시겠습니까?")){
				window.location.href="buyerlogin";
			}
			heartIcon.classList.toggle("fa-regular");
			heartIcon.classList.toggle("fa-solid");
			return false;
        }
	});
	
}