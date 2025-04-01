$(function() {
	let query = window.location.search;
	let param = new URLSearchParams(query);
	let sel_nm = param.get('sel_nm');
	
	$("#searchBtn").click(function () {
    	let keyword = $("#searchInput").val().trim();
		
		$.ajax({
            type: "POST",
            url: "selPrdsearch",
			contentType: "application/json",
            data:JSON.stringify({
				keyword: keyword,
				sel_nm: sel_nm
			}),
            success: function (res) {
                let gallery = $("#imageGallery");
                gallery.empty();

                res.forEach(sel => {
                    let item = `
                        <div class="image-item" data-id="${sel.prd_cd}" data-sel="${sel.sel_nm}">
                            <img src="${contextPath}${sel.fil_pt}" alt="${sel.prd_nm}"/>
                            <div class="sel-nm">${sel.sel_nm}</div>
                            <div class="prd-nm">${sel.prd_nm}</div>
                            <div class="pr">
                                <div class="dc">${sel.dc}</div>
                                <div class="prd-sp">${sel.prd_sp}원</div>
                            </div>
                        </div>
                    `;
                    gallery.append(item);
                });
debugger;
            },
            error: function () {
                alert("검색 중 오류가 발생했습니다.");
            }
        });
	});
	 // 엔터 키 입력 시 검색 실행
    $("#searchInput").keypress(function (e) {
        if (e.which === 13) { // 엔터 키 코드 = 13
            $("#searchBtn").click();
        }
    });
	
	$(document).on("click", ".image-item", function() {
        let prdCd = $(this).data("id");
		let selNm = $(this).data("sel");
		debugger;
    	window.location.href = `productDetail?prd_cd=${prdCd}&sel_nm=${encodeURIComponent(selNm)}`;
    });
});