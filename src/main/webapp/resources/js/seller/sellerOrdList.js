$(document).ready(function() {
	console.log("sellerOrdList.js 로드됨");
    let currentPage = 1;
    const listLimit = 10;
	let currentStatus = "all";
	
	$('.filter-btn').on('click', function() {
        currentStatus = $(this).data('status');  // 클릭한 버튼의 data-status 값을 가져옴
		console.log("현재 선택된 상태:", currentStatus);
        $('.filter-btn').removeClass('active');  // 기존 활성화된 버튼에서 active 제거
        $(this).addClass('active');  // 클릭한 버튼에 active 클래스 추가
        currentPage = 1;  // 페이지 초기화
        loadOrderList(currentPage);  // 필터링된 리스트 로드

    $(".product-card").each(function () {
        const productStatus = $(this).data("status");  // 각 상품 카드의 data-status 값 가져오기
        console.log("현재 버튼 상태:", currentStatus);
        console.log("상품 카드 상태:", productStatus);

        // 상태가 'all'이거나, 현재 선택 상태와 일치하는 경우 보여주기
        if (currentStatus === 'all' || currentStatus == productStatus) {
            $(this).show();
        } else {
            $(this).fadeOut();
        }
    });
    });

    function loadOrderList(page) {
        let startRow = (page - 1) * listLimit;
        let searchKind = $('#noticeSearchKind').val();
        let buy_nm = "", buy_ph = "", ord_id = "";

        if (searchKind === "name") { 
            buy_nm = $('#noticeSearchWord').val();
        } else if (searchKind === "phone") { 
            buy_ph = $('#noticeSearchWord').val();
        } else if (searchKind === "order") { 
            ord_id = $('#noticeSearchWord').val();
        }

        $.ajax({
            url: "/UNIPICK/seller/api/selOrderList",
            type: "GET",
            data: { buy_nm, buy_ph, ord_id, orderStatus: currentStatus, startRow, listLimit },
            dataType: "json",
            success: function(data) {
                console.log("서버 응답:", data);

          let orderList = (data && Array.isArray(data.orderList)) ? data.orderList : [];
    	  let totalCount = (data && typeof data.totalCount === "number") ? data.totalCount : 0;

        console.log("최종 orderList:", orderList);
        console.log("총 개수:", totalCount);

                renderOrderList(data.orderList);
                renderPagination(data.totalCount, page);
            },
            error: function(xhr, status, error) {
                console.error("상품 목록 로드 실패:", error);
            }
        });
    }

function getStatusLabel(status) {
    switch(status) {
        case '0': return '배송대기';
        case '1': return '배송중';
        case '2': return '배송완료';
        case '3': return '취소접수';
        case '4': return '반품접수';
        default: return status || '-';
    }
}

 function renderOrderList(orderList) {
    let html = "";  // 동적으로 추가할 HTML 문자열


    if (!orderList || !Array.isArray(orderList)) {
        orderList = [];  
    }

    if (orderList.length > 0) {
        $.each(orderList, function(index, order) {
            html += `
                <tr>
                    <td><a href="sellerOrdDetail?ord_id=${order.ord_id || ''}">${order.ord_id || '-'}</a></td>
 					<td>${formatDate(order.ord_at)}</td>
                    <td>${order.buy_nm || '-'}</td>
                    <td>${order.buy_ph || '-'}</td>
                    <td>${order.odd_qt || '-'}</td>
                    <td>${order.odd_am || '-'}</td>
					<td class="product-card" data-status="${order.odd_st}">${getStatusLabel(order.odd_st)}</td>
                    
                </tr>`;


        });
   	//<td>${order.odd_st || '-'}</td>
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
        loadOrderList(currentPage);
    });

    $('#pageList').on('click', '.page-link', function(e) {
        e.preventDefault();
        let selectedPage = parseInt($(this).data('page'));
        if (selectedPage && selectedPage !== currentPage) {
            currentPage = selectedPage;
            loadOrderList(currentPage);
        }
    });

 $('#noticeSearchWord').on('keydown', function(e) {
        if (e.key === 'Enter') {
            e.preventDefault(); // 기본 동작을 막기
            $('#noticeSearch').trigger('click'); // 검색 버튼 클릭 이벤트 트리거
        }
    });

    loadOrderList(currentPage);
});
