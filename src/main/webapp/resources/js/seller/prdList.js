$(document).ready(function(){
    // 초기 페이지 및 한 페이지에 표시할 건수
    let currentPage = 1;
    const listLimit = 10;

    // 상품 목록 로드 함수
    function loadProductList(page) {
    let startRow = (page - 1) * listLimit;
    let searchKind = $('#noticeSearchKind').val();
    let prd_nm = "";
    let prd_ca = "";

    // 검색 조건 설정
    if (searchKind === "name") { // 상품명 검색
        prd_nm = $('#noticeSearchWord').val();
    } else if (searchKind === "category") { // 카테고리 검색
        prd_ca = $('#noticeSearchWord').val();
    } else if (searchKind === "code") { // 상품코드 검색
        prd_nm = $('#noticeSearchWord').val();
    }

    $.ajax({
        url: "/seller/selProductList", // 서버 URL
        type: "GET",
        data: {
            prd_nm: prd_nm,
            prd_ca: prd_ca,
            startRow: startRow,
            listLimit: listLimit
        },
        dataType: "json",
        success: function(data) {
            renderProductList(data.productList);  // 상품 목록 렌더링
            renderPagination(data.totalCount, page);  // 페이지네이션 렌더링
        },
        error: function(xhr, status, error) {
            console.error("상품 목록 로드 실패:", error);
        }
    });
}

    // 상품 목록 테이블 렌더링
    function renderProductList(productList) {
        let $tableBody = $('#noticeListTable');
        $tableBody.empty(); // 테이블 초기화
        if (productList && productList.length > 0) {
            $.each(productList, function(index, product) {
                let row = `
                    <tr>
                        <td>${product.prd_cd}</td>
                        <td>${product.prd_nm}</td>
                        <td>${product.prd_sp}</td>
                        <td>${product.prd_ca}</td>
                        <td>${product.clr_nm}</td>
						<td>${product.siz_nm}</td>
                        <td>${product.prd_qt}</td>
                        <td>${formatDate(product.prd_dt)}</td>
                        <td><!-- 수정일 (필요 시 추가) --></td>
                    </tr>`;
                $tableBody.append(row);
            });
        } else {
            $tableBody.append('<tr><td colspan="8">조회된 상품이 없습니다.</td></tr>');
        }
    }

    // 날짜 형식 포맷팅
    function formatDate(timestamp) {
        let date = new Date(timestamp);
        let year = date.getFullYear();
        let month = String(date.getMonth() + 1).padStart(2, '0');
        let day = String(date.getDate()).padStart(2, '0');
        return `${year}-${month}-${day}`;
    }

    // 페이징 렌더링
    function renderPagination(totalCount, currentPage) {
        let totalPages = Math.ceil(totalCount / listLimit);
        let $pagination = $('#pageList');
        $pagination.empty();

        if (currentPage > 1) {
            $pagination.append(`<a href="#" class="page-link" data-page="${currentPage - 1}">이전</a>`);
        }

        for (let i = 1; i <= totalPages; i++) {
            let activeClass = (i === currentPage) ? "active" : "";
            $pagination.append(`<a href="#" class="page-link ${activeClass}" data-page="${i}">${i}</a>`);
        }

        if (currentPage < totalPages) {
            $pagination.append(`<a href="#" class="page-link" data-page="${currentPage + 1}">다음</a>`);
        }
    }

    // 검색 버튼 클릭 이벤트
    $('#noticeSearch').on('click', function(){
        currentPage = 1;
        loadProductList(currentPage);
    });

    // 페이징 링크 클릭 이벤트
    $('#pageList').on('click', '.page-link', function(e){
        e.preventDefault();
        let selectedPage = parseInt($(this).data('page'));
        if (selectedPage && selectedPage !== currentPage) {
            currentPage = selectedPage;
            loadProductList(currentPage);
        }
    });

    // 페이지 로딩 시 기본 상품 목록 호출
    loadProductList(currentPage);
});
