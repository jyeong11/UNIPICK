$(document).ready(function() {
	
	$(document).on("click", "tbody > tr > td:nth-child(2)", function() {
	    let prd_cd = $(this).closest("tr").find("td:first-child").text().trim();
    	window.location.href="sellerPrdDetail?prd_cd=" + prd_cd;
	});
	
	console.log("prdList.js 로드됨");
    let currentPage = 1;
    const listLimit = 10;

    function loadProductList(page) {
        let startRow = (page - 1) * listLimit;
        let searchKind = $('#noticeSearchKind').val();
        let prd_nm = "", prd_ca = "", prd_cd = "", clr_nm = "";

        if (searchKind === "name") { 
            prd_nm = $('#noticeSearchWord').val();
        } else if (searchKind === "category") { 
            prd_ca = $('#noticeSearchWord').val();
        } else if (searchKind === "color") { 
            clr_nm = $('#noticeSearchWord').val();
        }

        $.ajax({
            url: "/UNIPICK/seller/api/selProductList",
            type: "GET",
            data: { prd_nm, prd_ca, clr_nm, prd_cd, startRow, listLimit },
            dataType: "json",
            success: function(data) {
                console.log("서버 응답:", data); // alert 대신 console.log 사용
                renderProductList(data.productList);
                renderPagination(data.totalCount, page);
            },
            error: function(xhr, status, error) {
                console.error("상품 목록 로드 실패:", error);
            }
        });
    }

 function renderProductList(productList) {
    let html = "";  // 동적으로 추가할 HTML 문자열
    if (productList.length > 0) {
        $.each(productList, function(index, product) {
            html += `
                <tr>
                    <td>${product.prd_cd || '-'}</td>
                    <td>${product.prd_nm || '-'}</td>
                    <td>${product.prd_sp || '-'}</td>
                    <td>${product.lev_nm || '-'}</td>
                    <td>${product.colors || '-'}</td>
                    <td>${product.sizes || '-'}</td>
                    <td>${product.total_stock || '-'}</td>
                    <td>${formatDate(product.prd_dt)}</td>
					<td>${product.prd_st || '-'}</td>
                </tr>`;
        });
   	
    } else {
        html = '<tr><td colspan="8">조회된 상품이 없습니다.</td></tr>';
    }
      console.log(html);
    // 테이블에 최종적으로 HTML 삽입
 $("#noticeListTable").html(html);
}

    function formatDate(timestamp) {
        if (!timestamp) return "-";
        let date = new Date(timestamp);
        return `${date.getFullYear()}-${(date.getMonth() + 1).toString().padStart(2, '0')}-${date.getDate().toString().padStart(2, '0')}`;
    }

    function renderPagination(totalCount, currentPage) {
        let totalPages = Math.ceil(totalCount / listLimit);
        let $pagination = $('#pageList');
        $pagination.empty();

        let startPage = Math.max(1, currentPage - 2);
        let endPage = Math.min(totalPages, currentPage + 2);

        if (currentPage > 1) {
            $pagination.append(`<a href="#" class="page-link" data-page="${currentPage - 1}">이전</a>`);
        }

        for (let i = startPage; i <= endPage; i++) {
            let activeClass = (i === currentPage) ? "active" : "";
            $pagination.append(`<a href="#" class="page-link ${activeClass}" data-page="${i}">${i}</a>`);
        }

        if (currentPage < totalPages) {
            $pagination.append(`<a href="#" class="page-link" data-page="${currentPage + 1}">다음</a>`);
        }
    }

    $('#noticeSearch').on('click', function() {
        currentPage = 1;
        loadProductList(currentPage);
    });

    $('#pageList').on('click', '.page-link', function(e) {
        e.preventDefault();
        let selectedPage = parseInt($(this).data('page'));
        if (selectedPage && selectedPage !== currentPage) {
            currentPage = selectedPage;
            loadProductList(currentPage);
        }
    });

 $('#noticeSearchWord').on('keydown', function(e) {
        if (e.key === 'Enter') {
            e.preventDefault(); // 기본 동작을 막기
            $('#noticeSearch').trigger('click'); // 검색 버튼 클릭 이벤트 트리거
        }
    });

    loadProductList(currentPage);
});
