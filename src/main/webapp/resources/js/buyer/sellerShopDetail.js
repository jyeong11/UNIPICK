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
            },
            error: function () {
                alert("검색 중 오류가 발생했습니다.");
            }
        });
	});
	 // 엔터 키 입력 시 검색 실행
    $("#searchInput").keypress(function (e) {
        if (e.which === 13) {
            $("#searchBtn").click();
        }
    });

	// 카테고리 클릭시
	$(document).on("click", ".category", function (e) {
        e.preventDefault(); 

        let category = $(this).data("category");
        loadProducts(category, sel_nm);

    });
	
	// 이미지 클릭시 	
	$(document).on("click", ".image-item", function() {
        let prdCd = $(this).data("id");
		let selNm = $(this).data("sel");
    	window.location.href = `productDetail?prd_cd=${prdCd}&sel_nm=${encodeURIComponent(selNm)}`;
    });
});
function loadProducts(category, sel_nm) {
	$.ajax({
            url: "getCatePrd",
            type: "POST",
			contentType: "application/json",
            data: JSON.stringify({ 
				category: category,
				sel_nm: sel_nm 
			}),
            success: function (res) {
                let gallery = $("#imageGallery");
                gallery.empty();

                if (res.length === 0) {
                    gallery.append("<p>해당 카테고리에 상품이 없습니다.</p>");
                    return;
                }

                res.forEach(function (sel) {
                    let productHTML = `
                        <div class="image-item" data-id="${sel.prd_cd}" data-sel="${sel.sel_nm}">
                            <img src="${contextPath}${sel.fil_pt}" alt="${sel.prd_nm}"/>
                            <div class="sel-nm">${sel.sel_nm}</div>
                            <div class="prd-nm">${sel.prd_nm}</div>
                            <div class="pr">
                                <div class="dc">${sel.dc}</div>
                                <div class="prd-sp">${sel.prd_sp.toLocaleString()}원</div>
                            </div>
                        </div>`;
                    gallery.append(productHTML);
                });
            },
            error: function () {
                alert("상품을 불러오는 데 실패했습니다.");
            }
        });
    }