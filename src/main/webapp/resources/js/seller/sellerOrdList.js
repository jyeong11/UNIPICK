$(document).ready(function() {
    console.log("sellerOrdList.js 로드됨");
    let currentPage = 1;
    const listLimit = 10;
    let currentStatus = "all";
    let statusOptions = []; // 상태 옵션 저장 변수
    
    // 공통코드에서 주문상태 옵션 로드
    function loadStatusOptions() {
        $.ajax({
            url: "/UNIPICK/seller/commonCode",
            type: "GET",
            data: { comCd: "DELIVERY" },
            dataType: "json",
            success: function(data) {
                console.log("주문상태 옵션 로드 성공:", data);
                if (data && data.length > 0) {
                    statusOptions = data;
                } else {
                    // 데이터가 없을 경우 기본값 설정
                    statusOptions = [
                        {com_cd: '결제완료', com_cd_nm: '결제완료'},
                        {com_cd: '배송대기', com_cd_nm: '배송대기'},
                        {com_cd: '배송중', com_cd_nm: '배송중'},
                        {com_cd: '배송완료', com_cd_nm: '배송완료'},
                        {com_cd: '취소접수', com_cd_nm: '취소접수'},
                        {com_cd: '반품접수', com_cd_nm: '반품접수'}
                    ];
                }
            },
            error: function(xhr, status, error) {
                console.error("주문상태 옵션 로드 실패:", error);
                // 에러 시 기본값 설정
                statusOptions = [
                    {com_cd: '결제완료', com_cd_nm: '결제완료'},
                    {com_cd: '배송대기', com_cd_nm: '배송대기'},
                    {com_cd: '배송중', com_cd_nm: '배송중'},
                    {com_cd: '배송완료', com_cd_nm: '배송완료'},
                    {com_cd: '취소접수', com_cd_nm: '취소접수'},
                    {com_cd: '반품접수', com_cd_nm: '반품접수'}
                ];
            }
        });
    }
    
    // 페이지 로드시 상태 옵션 로드
    loadStatusOptions();
    
    // 주문상태 변경 함수
    function updateOrderStatus(ordId, statusCode) {
        console.log("주문상태 변경 시도:", ordId, statusCode);
        $.ajax({
            url: "/UNIPICK/seller/updateOrderStatus",
            type: "POST",
            data: { 
                ordId: ordId,
                statusCode: statusCode
            },
            dataType: "json",
            success: function(response) {
                alert("주문상태가 변경되었습니다.");
                loadOrderList(currentPage); // 목록 새로고침
            },
            error: function(xhr, status, error) {
                console.error("주문상태 변경 실패:", error);
                alert("주문상태 변경에 실패했습니다.");
            }
        });
    }
    
    // 주문상태 변경 이벤트 핸들러
    $(document).on('change', '.status-select', function() {
        const ordId = $(this).data('ord-id');
        const statusCode = $(this).val();
        
        if (confirm("주문상태를 변경하시겠습니까?")) {
            updateOrderStatus(ordId, statusCode);
        } else {
            // 취소 시 원래 값으로 되돌림
            $(this).val($(this).data('original-value'));
        }
    });
    
    // 필터 버튼 클릭 이벤트
    $('.filter-btn').on('click', function() {
        currentStatus = $(this).data('status');  // 클릭한 버튼의 data-status 값을 가져옴
        console.log("현재 선택된 상태:", currentStatus);
        $('.filter-btn').removeClass('active');  // 기존 활성화된 버튼에서 active 제거
        $(this).addClass('active');  // 클릭한 버튼에 active 클래스 추가
        currentPage = 1;  // 페이지 초기화
        loadOrderList(currentPage);  // 필터링된 리스트 로드
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
        // DB에 저장된 값 그대로 사용
        return status || '-';
    }

    function renderOrderList(orderList) {
        let html = "";

        if (!orderList || !Array.isArray(orderList)) {
            orderList = [];  
        }

        if (orderList.length > 0) {
            $.each(orderList, function(index, order) {
                // 여기서 명확하게 각 TD를 분리해서 작성합니다
                let row = '<tr>';
                // 1. 주문번호
                row += `<td><a href="sellerOrdDetail?ord_id=${order.ord_id || ''}">${order.ord_id || '-'}</a></td>`;
                // 2. 주문일
                row += `<td>${formatDate(order.ord_at)}</td>`;
                // 3. 구매자
                row += `<td>${order.buy_nm || '-'}</td>`;
                // 4. 연락처 
                row += `<td>${order.buy_ph || '-'}</td>`;
                // 5. 구매수량
                row += `<td>${order.odd_qt || '-'}</td>`;
                // 6. 결제금액
                row += `<td>${order.odd_am || '-'}</td>`;
                // 7. 주문상태
                row += `<td class="product-card" data-status="${order.odd_st}">${getStatusLabel(order.odd_st)}</td>`;
                // 8. 상태변경 - 여기가 문제였을 수 있음
                row += '<td><select class="status-select form-control" data-ord-id="' + order.ord_id + '" data-original-value="' + (order.odd_st || '-') + '">';
                row += '<option value="결제완료" ' + (order.odd_st === '결제완료' ? 'selected' : '') + '>결제완료</option>';
                row += '<option value="배송대기" ' + (order.odd_st === '배송대기' ? 'selected' : '') + '>배송대기</option>';
                row += '<option value="배송중" ' + (order.odd_st === '배송중' ? 'selected' : '') + '>배송중</option>';
                row += '<option value="배송완료" ' + (order.odd_st === '배송완료' ? 'selected' : '') + '>배송완료</option>';
                row += '<option value="취소접수" ' + (order.odd_st === '취소접수' ? 'selected' : '') + '>취소접수</option>';
                row += '<option value="반품접수" ' + (order.odd_st === '반품접수' ? 'selected' : '') + '>반품접수</option>';
                row += '</select></td>';
                row += '</tr>';
                
                html += row;
            });
        } else {
            html = '<tr><td colspan="8">조회된 상품이 없습니다.</td></tr>';
        }
        
        console.log("HTML 일부:", html.substring(0, 300)); // 처음 300자만 로그로 출력
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

    // 페이지 로드 시 상품 목록 로드
    loadOrderList(currentPage);
});