$(document).ready(function() {
	
	$(document).on("click", "tbody > tr > td:nth-child(2)", function() {
	    let prd_cd = $(this).closest("tr").find("td:first-child").text().trim();
    	window.location.href="sellerPrdDetail?prd_cd=" + prd_cd;
	});
	
	console.log("prdList.js 로드됨");
    let currentPage = 1;
    const listLimit = 10; // 페이지당 10개 상품

    function loadProductList(page) {
        // 페이지 번호가 유효한지 확인
        if (page < 1) page = 1;
        
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

        // 로딩 전에 기존 데이터 초기화
        $("#noticeListTable").html('<tr><td colspan="9" class="text-center">로딩 중...</td></tr>');
        
        $.ajax({
            url: "/UNIPICK/seller/api/selProductList",
            type: "GET",
            data: { prd_nm, prd_ca, clr_nm, prd_cd, startRow, listLimit },
            dataType: "json",
            success: function(data) {
                console.log("서버 응답:", data);
                
                // 데이터 검증
                if (!data || !Array.isArray(data.productList)) {
                    console.error("서버 응답 형식 오류:", data);
                    $("#noticeListTable").html('<tr><td colspan="9" class="text-center">데이터를 불러오는 중 오류가 발생했습니다.</td></tr>');
                    return;
                }
                
                // SQL 로그에서 확인된 문제:
                // 실제 상품 수와 서버에서 반환된 총 상품 수가 불일치
                // 서버에서 받은 상품 수를 그대로 사용하지 않고 페이징을 위한 계산 수정
                let totalCount = data.totalCount || 0;
                
                // 옵션에 의한 중복 카운트 가능성이 있음을 콘솔에 기록
                console.log("서버에서 보낸 총 상품 수:", totalCount);
                console.log("현재 페이지 상품 수:", data.productList.length);
                
                // 만약 상품 목록이 비어있고 현재 페이지가 1보다 크면 이전 페이지로 이동
                if (data.productList.length === 0 && page > 1) {
                    currentPage = page - 1;
                    loadProductList(currentPage);
                    return;
                }
                
                // 상품 목록 및 페이징 렌더링
                renderProductList(data.productList);
                
                // 옵션에 의한 중복 카운트 문제 방지를 위해 처리
                // totalCount가 비정상적으로 큰 값이라면 상품이 많지 않을 때는
                // 현재 페이지의 상품 수를 기준으로 페이징 처리
                if (totalCount > 100 && data.productList.length < listLimit) {
                    // 마지막 페이지로 판단하고 적절히 처리
                    totalCount = (page - 1) * listLimit + data.productList.length;
                    console.log("조정된 총 상품 수:", totalCount);
                }
                
                renderPagination(totalCount, page);
            },
            error: function(xhr, status, error) {
                console.error("상품 목록 로드 실패:", error);
                $("#noticeListTable").html('<tr><td colspan="9" class="text-center">데이터를 불러오는 중 오류가 발생했습니다.</td></tr>');
            }
        });
    }

    function renderProductList(productList) {
        let html = "";  // 동적으로 추가할 HTML 문자열
        if (productList && productList.length > 0) {
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
                        <td>${product.prd_st_nm || '-'}</td>
                    </tr>`;
            });
        } else {
            html = '<tr><td colspan="9" class="text-center">조회된 상품이 없습니다.</td></tr>';
        }
        
        // 테이블에 최종적으로 HTML 삽입
        $("#noticeListTable").html(html);
    }

    function formatDate(timestamp) {
        if (!timestamp) return "-";
        let date = new Date(timestamp);
        return `${date.getFullYear()}-${(date.getMonth() + 1).toString().padStart(2, '0')}-${date.getDate().toString().padStart(2, '0')}`;
    }

    function renderPagination(totalCount, currentPage) {
        // 정확한 전체 페이지 수 계산
        const totalPages = Math.ceil(totalCount / listLimit);
        let $pagination = $('#pageList');
        $pagination.empty();

        // 페이지 수가 0인 경우 페이징 표시하지 않음
        if (totalPages <= 0) {
            console.log("표시할 페이지가 없습니다. 전체 아이템 수:", totalCount);
            return;
        }

        // 이전 버튼
        if (currentPage > 1) {
            $pagination.append(`<a href="#" class="page-link prev-page" data-page="${currentPage - 1}">이전</a>`);
        }

        // 페이지 범위 계산 (최대 5개 페이지 표시)
        let startPage = Math.max(1, currentPage - 2);
        let endPage = Math.min(totalPages, startPage + 4);
        
        // 시작 페이지가 5개 미만일 경우 endPage 조정
        if (endPage - startPage < 4 && totalPages > 5) {
            startPage = Math.max(1, endPage - 4);
        }

        // 페이지 번호 생성
        for (let i = startPage; i <= endPage; i++) {
            let activeClass = (i === currentPage) ? "active" : "";
            $pagination.append(`<a href="#" class="page-link ${activeClass}" data-page="${i}">${i}</a>`);
        }

        // 다음 버튼
        if (currentPage < totalPages) {
            $pagination.append(`<a href="#" class="page-link next-page" data-page="${currentPage + 1}">다음</a>`);
        }
        
        // 디버깅용 페이징 정보 출력
        console.log("페이징 정보:", {
            총상품수: totalCount,
            페이지당개수: listLimit,
            현재페이지: currentPage,
            전체페이지수: totalPages,
            시작페이지: startPage,
            종료페이지: endPage
        });
    }

    $('#noticeSearch').on('click', function() {
        currentPage = 1; // 검색 시 첫 페이지로 이동
        loadProductList(currentPage);
    });

    $('#pageList').on('click', '.page-link', function(e) {
        e.preventDefault();
        let selectedPage = parseInt($(this).data('page'));
        if (!isNaN(selectedPage) && selectedPage !== currentPage) {
            currentPage = selectedPage;
            loadProductList(currentPage);
            
            // 페이지 이동 시 상단으로 스크롤
            $('html, body').animate({
                scrollTop: $('#productList').offset().top - 100
            }, 200);
        }
    });

    $('#noticeSearchWord').on('keydown', function(e) {
        if (e.key === 'Enter') {
            e.preventDefault(); // 기본 동작을 막기
            $('#noticeSearch').trigger('click'); // 검색 버튼 클릭 이벤트 트리거
        }
    });

    // 페이지 로드 시 상품 목록 불러오기
    loadProductList(currentPage);
});
