$(document).ready(function() {
    // 기본 날짜 설정 (오늘 날짜와 기간 유형에 따른 시작일)
    function setDefaultDates() {
        const today = new Date();
        
        // yyyy-mm-dd 형식으로 변환
        const formatDate = (date) => {
            const year = date.getFullYear();
            const month = String(date.getMonth() + 1).padStart(2, '0');
            const day = String(date.getDate()).padStart(2, '0');
            return `${year}-${month}-${day}`;
        };
        
        // 기본 종료일은 오늘
        $('#endDate').val(formatDate(today));
        
        // 기본 시작일은 현재 선택된 기간 유형에 따라 결정
        const periodType = $('#periodType').val();
        let startDate;
        
        switch(periodType) {
            case 'daily':
                // 종료일과 동일한 날짜 (오늘 날짜)
                startDate = new Date(today);
                break;
            case 'weekly':
                // 종료일 기준 7일 전
                startDate = new Date(today);
                startDate.setDate(today.getDate() - 7);
                break;
            case 'monthly':
                // 종료일 기준 해당 월의 1일
                startDate = new Date(today);
                startDate.setDate(1); // 월의 1일로 설정
                break;
            case 'yearly':
                // 종료일 기준 1년 전
                startDate = new Date(today);
                startDate.setFullYear(today.getFullYear() - 1);
                break;
            default:
                // 기본값은 월 단위 (월의 1일)
                startDate = new Date(today);
                startDate.setDate(1);
        }
        
        $('#startDate').val(formatDate(startDate));
        
        console.log('초기 날짜 설정:');
        console.log('시작일:', formatDate(startDate));
        console.log('종료일:', formatDate(today));
    }
    
    // 초기 설정 및 데이터 로드
    setDefaultDates();
    loadSettlementData();
    
    // periodType 변경 이벤트
    $('#periodType').change(function() {
        loadSettlementData();
        
        // 선택된 기간 유형에 따라 날짜 필드 업데이트
        updateDateFieldsByPeriodType();
    });
    
    // 날짜 필드 변경 이벤트
    $('#startDate, #endDate').change(function() {
        loadSettlementData();
    });
    
    // 검색 버튼 이벤트
    $('#searchBtn').click(function() {
        loadSettlementData();
    });
    
    // 검색 버튼 이벤트 (폼 제출 시)
    $('#searchForm').on('submit', function(e) {
        e.preventDefault();
        loadSettlementData();
    });
    
    // Excel 다운로드 버튼 클릭 이벤트
    $('#excelBtn').click(function() {
        downloadExcel();
    });
    
    // 기간 유형에 따라 날짜 필드 설정
    function updateDateFieldsByPeriodType() {
        const periodType = $('#periodType').val();
        const today = new Date();
        
        // 날짜 포맷 변환 함수
        const formatDate = (date) => {
            const year = date.getFullYear();
            const month = String(date.getMonth() + 1).padStart(2, '0');
            const day = String(date.getDate()).padStart(2, '0');
            return `${year}-${month}-${day}`;
        };
        
        // 현재 종료일 값 가져오기 (없으면 오늘 날짜 사용)
        let endDateValue = $('#endDate').val() || formatDate(today);
        let endDate = new Date(endDateValue + 'T00:00:00'); // 시간 추가하여 날짜 객체 생성
        
        // 종료일이 유효하지 않으면 오늘 날짜 사용
        if (isNaN(endDate.getTime())) {
            endDate = new Date(today);
            endDateValue = formatDate(endDate);
            $('#endDate').val(endDateValue);
        }
        
        let startDate;
        
        switch(periodType) {
            case 'daily':
                // 종료일과 동일한 날짜 (오늘 날짜)
                startDate = new Date(endDate);
                break;
            case 'weekly':
                // 종료일 기준 7일 전
                startDate = new Date(endDate);
                startDate.setDate(endDate.getDate() - 7);
                break;
            case 'monthly':
                // 종료일 기준 해당 월의 1일
                startDate = new Date(endDate);
                startDate.setDate(1); // 월의 1일로 설정
                break;
            case 'yearly':
                // 종료일 기준 1년 전
                startDate = new Date(endDate);
                startDate.setFullYear(endDate.getFullYear() - 1);
                break;
        }
        
        // 계산된 날짜 설정
        $('#startDate').val(formatDate(startDate));
        
        // 콘솔에 날짜 계산 정보 출력 (디버깅용)
        console.log('기간 유형:', periodType);
        console.log('시작일:', formatDate(startDate));
        console.log('종료일:', endDateValue);
    }

    function loadSettlementData() {
        const periodType = $('#periodType').val();
        const startDate = $('#startDate').val();
        const endDate = $('#endDate').val();
        
        // 날짜 유효성 검사
        if (!startDate || !endDate) {
            console.error('날짜를 선택해주세요.');
            return;
        }
        
        // 로딩 메시지 표시
        $('#settlementTable tbody').html('<tr><td colspan="9" class="text-center">데이터를 불러오는 중입니다...</td></tr>');
        
        $.ajax({
            url: `${contextPath}/account/search`,
            type: "GET",
            data: {
                periodType: periodType,
                startDate: startDate,
                endDate: endDate
            },
            dataType: "json",
            success: function(response) {
                console.log('받은 데이터:', response); // 디버깅용 로그
                updateSettlementTable(response);
                updateSummary(response);
            },
            error: function(xhr, status, error) {
                console.error('데이터 로드 실패:', error);
                console.error('상태:', status);
                console.error('응답:', xhr.responseText);
                $('#settlementTable tbody').html('<tr><td colspan="9" class="text-center">데이터를 불러오는 중 오류가 발생했습니다.</td></tr>');
            }
        });
    }

    function downloadExcel() {
        const periodType = $('#periodType').val();
        const startDate = $('#startDate').val();
        const endDate = $('#endDate').val();

        window.location.href = `${contextPath}/account/excel?periodType=${periodType}&startDate=${startDate}&endDate=${endDate}`;
    }

    function updateSettlementTable(data) {
        const tbody = $('#settlementTable tbody');
        tbody.empty();

        if (!Array.isArray(data) || data.length === 0) {
            tbody.append('<tr><td colspan="9" class="text-center">데이터가 없습니다.</td></tr>');
            return;
        }

        data.forEach(item => {
            const row = `
                <tr>
                    <td>${item.기간 || '-'}</td>
                    <td>${formatNumber(item.주문수 || 0)}</td>
                    <td>${formatNumber(item.판매수량 || 0)}</td>
                    <td>${formatNumber(item.교환건수 || 0)}</td>
                    <td>${formatNumber(item.반품건수 || 0)}</td>
                    <td>${formatNumber(item.매출액 || 0)}</td>
                    <td>${formatNumber(item.수수료 || 0)}</td>
                    <td>${formatNumber(item.순이익 || 0)}</td>
                    <td>${item.정산일자 || '-'}</td>
                </tr>
            `;
            tbody.append(row);
        });

        // DataTables 새로고침
        if ($.fn.DataTable.isDataTable('#settlementTable')) {
            $('#settlementTable').DataTable().destroy();
        }
        $('#settlementTable').DataTable({
            "language": {
                "url": contextPath + "/resources/js/i18n/Korean.json"
            },
            "searching": false, // 검색 기능 비활성화
            "lengthChange": false, // 페이지당 표시 항목 수 변경 옵션 비활성화
            "order": [[0, "desc"]],
            "pageLength": 10,
            "pagingType": "simple_numbers",
            "responsive": true,
            "dom": '<"row"<"col-sm-12"tr>><"row"<"col-sm-12 col-md-5"i><"col-sm-12 col-md-7"p>>'
        });
    }

    function updateSummary(data) {
        if (!Array.isArray(data)) {
            data = [];
        }

        let totalOrders = 0;
        let totalSales = 0;
        let totalCommission = 0;
        let totalProfit = 0;

        data.forEach(item => {
            totalOrders += parseInt(item.주문수 || 0);
            totalSales += parseInt(item.판매수량 || 0);
            totalCommission += parseInt(item.수수료 || 0);
            totalProfit += parseInt(item.순이익 || 0);
        });

        $('#totalOrders').text(formatNumber(totalOrders));
        $('#totalSales').text(formatNumber(totalSales));
        $('#totalCommission').text(formatNumber(totalCommission));
        $('#totalProfit').text(formatNumber(totalProfit));
    }

    function formatNumber(num) {
        if (num === null || num === undefined) {
            return '0';
        }
        return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }
});