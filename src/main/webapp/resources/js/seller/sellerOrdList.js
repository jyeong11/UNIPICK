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
                    // 서버에서 받은 데이터 구조에 맞게 매핑
                    // com_cd와 com_cd_nm 필드를 사용
                    statusOptions = data.map(function(item) {
                        return {
                            code: item.code,  // DELIVERY01, DELIVERY02, ...
                            name: item.name  // 상품준비중, 배송준비중, ...
                        };
                    });

                    console.log("상태 옵션 설정 완료:", statusOptions);
                    
                    // 상태 옵션이 로드되면 주문 목록도 다시 로드
                    loadOrderList(currentPage);
                } else {
                    // 데이터가 없을 경우 기본값 설정
                    statusOptions = [
                        {code: 'DELIVERY01', name: '상품준비중'},
                        {code: 'DELIVERY02', name: '배송준비중'},
                        {code: 'DELIVERY03', name: '배송시작'},
                        {code: 'DELIVERY04', name: '배송중'},
                        {code: 'DELIVERY05', name: '배송완료'},
                        {code: 'DELIVERY06', name: '교환접수'},
                        {code: 'DELIVERY07', name: '교환취소'},
                        {code: 'DELIVERY08', name: '교환완료'},
                        {code: 'DELIVERY09', name: '반품접수'},
                        {code: 'DELIVERY10', name: '반품취소'},
                        {code: 'DELIVERY11', name: '반품완료'}
                    ];
                    
                    // 상태 옵션이 로드되면 주문 목록도 다시 로드
                    loadOrderList(currentPage);
                }
            },
            error: function(xhr, status, error) {
                console.error("주문상태 옵션 로드 실패:", error);
                // 에러 시 기본값 설정
                statusOptions = [
                    {code: 'DELIVERY01', name: '상품준비중'},
                    {code: 'DELIVERY02', name: '배송준비중'},
                    {code: 'DELIVERY03', name: '배송시작'},
                    {code: 'DELIVERY04', name: '배송중'},
                    {code: 'DELIVERY05', name: '배송완료'},
                    {code: 'DELIVERY06', name: '교환접수'},
                    {code: 'DELIVERY07', name: '교환취소'},
                    {code: 'DELIVERY08', name: '교환완료'},
                    {code: 'DELIVERY09', name: '반품접수'},
                    {code: 'DELIVERY10', name: '반품취소'},
                    {code: 'DELIVERY11', name: '반품완료'}
                ];
                
                // 에러가 발생해도 주문 목록 로드
                loadOrderList(currentPage);
            }
        });
    }
    
    // 페이지 로드시 상태 옵션 로드
    loadStatusOptions();
    
    // 주문상태 변경 함수
    function updateOrderStatus(ordId, statusCode) {
        console.log("주문상태 변경 시도:", ordId, statusCode, "타입:", typeof statusCode);
        
        // 상태 코드가 유효하지 않은 경우 처리 (undefined, 'undefined', null, '', 공백문자열 등)
        if (!statusCode || statusCode === 'undefined' || statusCode.trim() === '') {
            alert("유효하지 않은 상태 코드입니다. 다시 선택해주세요.");
            return;
        }
        
        // 서버에 전송할 데이터 로깅
        console.log("서버에 전송할 데이터:", { ordId, statusCode });
        
        $.ajax({
            url: "/UNIPICK/seller/updateOrderStatus",
            type: "POST",
            data: { 
                ordId: ordId,
                statusCode: statusCode
            },
            dataType: "json",
            success: function(response) {
                console.log("주문상태 변경 성공:", response);
                alert("주문상태가 변경되었습니다.");
                loadOrderList(currentPage); // 목록 새로고침
            },
            error: function(xhr, status, error) {
                console.error("주문상태 변경 실패:", error, "상태:", xhr.status, "응답:", xhr.responseText);
                alert("주문상태 변경에 실패했습니다.");
            }
        });
    }
    
    // 주문상태 변경 이벤트 핸들러
    $(document).on('change', '.status-select', function() {
        const ordId = $(this).data('ord-id');
        const statusCode = $(this).val();
        const originalValue = $(this).data('original-value');
        const originalCode = getStatusCode(originalValue);
        
        console.log("상태 변경 이벤트 발생:", ordId, "새 상태코드:", statusCode, "원래 상태값:", originalValue, "원래 상태코드:", originalCode);
        
        // 상태 코드가 유효하지 않은 경우 처리
        if (!statusCode || statusCode === 'undefined' || statusCode.trim() === '') {
            console.warn("유효하지 않은 상태 코드:", statusCode);
            alert("유효하지 않은 상태 코드입니다. 다시 선택해주세요.");
            // 원래 값으로 되돌림
            $(this).val(originalCode);
            return;
        }
        
        if (confirm("주문상태를 변경하시겠습니까?")) {
            updateOrderStatus(ordId, statusCode);
        } else {
            // 취소 시 원래 값으로 되돌림
            $(this).val(originalCode);
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

    // 상태 이름을 코드로 변환하는 함수
    function getStatusCode(statusName) {
        // 한글 상태명을 코드로 변환
        switch (statusName) {
            case '상품준비중': return 'DELIVERY01';
            case '배송준비중': return 'DELIVERY02';
            case '배송시작': return 'DELIVERY03';
            case '배송중': return 'DELIVERY04';
            case '배송완료': return 'DELIVERY05';
            case '교환접수': return 'DELIVERY06';
            case '교환취소': return 'DELIVERY07';
            case '교환완료': return 'DELIVERY08';
            case '반품접수': return 'DELIVERY09';
            case '반품취소': return 'DELIVERY10';
            case '반품완료': return 'DELIVERY11';
            case '결제완료': return 'DELIVERY01'; // 결제완료 상태 추가 (상품준비중과 동일한 코드 사용)
            default: return 'DELIVERY01';
        }
    }

    // 코드를 상태 이름으로 변환하는 함수
    function getStatusName(statusCode) {
        // 코드를 한글 상태명으로 변환
        switch (statusCode) {
            case 'DELIVERY01': return '상품준비중';
            case 'DELIVERY02': return '배송준비중';
            case 'DELIVERY03': return '배송시작';
            case 'DELIVERY04': return '배송중';
            case 'DELIVERY05': return '배송완료';
            case 'DELIVERY06': return '교환접수';
            case 'DELIVERY07': return '교환취소';
            case 'DELIVERY08': return '교환완료';
            case 'DELIVERY09': return '반품접수';
            case 'DELIVERY10': return '반품취소';
            case 'DELIVERY11': return '반품완료';
            default: return '상품준비중';
        }
    }

    function renderOrderList(orderList) {
        let html = "";

        if (!orderList || !Array.isArray(orderList)) {
            orderList = [];  
        }

        if (orderList.length > 0) {
            $.each(orderList, function(index, order) {
                console.log("주문 데이터:", order); // 각 주문 데이터 확인용 로그
                
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
                row += `<td class="product-card" data-status="${order.odd_st}">${order.odd_st || '-'}</td>`;
                // 8. 상태변경 - 여기가 문제였을 수 있음
                
                // 한글 상태명을 코드로 변환하여 저장
                const originalValue = order.odd_st || '';
                const statusCode = getStatusCode(originalValue);
                
                console.log("주문 ID:", order.ord_id, "원래 상태값:", originalValue, "변환된 코드:", statusCode);
                
                row += '<td><select class="status-select form-control" data-ord-id="' + order.ord_id + '" data-original-value="' + originalValue + '">';
                
                // 상태 옵션 동적 생성
                if (statusOptions && statusOptions.length > 0) {
                    statusOptions.forEach(function(option) {
                        const isSelected = statusCode === option.code ? 'selected' : '';
                        row += `<option value="${option.code}" ${isSelected}>${option.name}</option>`;
                    });
                } else {
                    // 기본 옵션
                    row += '<option value="DELIVERY01" ' + (statusCode === 'DELIVERY01' ? 'selected' : '') + '>상품준비중</option>';
                    row += '<option value="DELIVERY02" ' + (statusCode === 'DELIVERY02' ? 'selected' : '') + '>배송준비중</option>';
                    row += '<option value="DELIVERY03" ' + (statusCode === 'DELIVERY03' ? 'selected' : '') + '>배송시작</option>';
                    row += '<option value="DELIVERY04" ' + (statusCode === 'DELIVERY04' ? 'selected' : '') + '>배송중</option>';
                    row += '<option value="DELIVERY05" ' + (statusCode === 'DELIVERY05' ? 'selected' : '') + '>배송완료</option>';
                    row += '<option value="DELIVERY06" ' + (statusCode === 'DELIVERY06' ? 'selected' : '') + '>교환접수</option>';
                    row += '<option value="DELIVERY07" ' + (statusCode === 'DELIVERY07' ? 'selected' : '') + '>교환취소</option>';
                    row += '<option value="DELIVERY08" ' + (statusCode === 'DELIVERY08' ? 'selected' : '') + '>교환완료</option>';
                    row += '<option value="DELIVERY09" ' + (statusCode === 'DELIVERY09' ? 'selected' : '') + '>반품접수</option>';
                    row += '<option value="DELIVERY10" ' + (statusCode === 'DELIVERY10' ? 'selected' : '') + '>반품취소</option>';
                    row += '<option value="DELIVERY11" ' + (statusCode === 'DELIVERY11' ? 'selected' : '') + '>반품완료</option>';
                }
                
                row += '</select></td>';
                row += '</tr>';
                
                html += row;
            });
        } else {
            html = '<tr><td colspan="8" class="text-center">조회된 주문이 없습니다.</td></tr>';
        }
        
        console.log("HTML 일부:", html.substring(0, 300)); // 처음 300자만 로그로 출력
        $("#noticeListTable").html(html);
        
        // 모든 상태 선택 요소의 original-value 확인
        $('.status-select').each(function() {
            console.log("선택 요소:", $(this).data('ord-id'), "저장된 원래 값:", $(this).data('original-value'));
        });
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