$(document).ready(function() {
    // 기간 타입 변경 시 날짜 입력 필드 표시/숨김 처리
    $('#periodType').change(function() {
        var periodType = $(this).val();
        if (periodType === 'daily') {
            $('.date-input').show();
        } else {
            $('.date-input').hide();
        }
    });

    // 검색 버튼 클릭 이벤트
    $('#searchBtn').click(function() {
        var periodType = $('#periodType').val();
        var startDate = $('#startDate').val();
        var endDate = $('#endDate').val();

        if (periodType === 'daily' && (!startDate || !endDate)) {
            alert('시작일과 종료일을 선택해주세요.');
            return;
        }

        // AJAX 요청으로 데이터 조회
        $.ajax({
            url: contextPath + '/seller/account/search',
            type: 'GET',
            data: {
                periodType: periodType,
                startDate: startDate,
                endDate: endDate
            },
            success: function(response) {
                updateSettlementTable(response);
                updateSummary(response);
            },
            error: function(xhr, status, error) {
                alert('데이터 조회 중 오류가 발생했습니다.');
                console.error(error);
            }
        });
    });

    // 엑셀 다운로드 버튼 클릭 이벤트
    $('#excelBtn').click(function() {
        var periodType = $('#periodType').val();
        var startDate = $('#startDate').val();
        var endDate = $('#endDate').val();

        // 엑셀 다운로드 요청
        window.location.href = contextPath + '/seller/account/excel?periodType=' + periodType + 
                             '&startDate=' + startDate + '&endDate=' + endDate;
    });

    // 정산 테이블 업데이트 함수
    function updateSettlementTable(data) {
        var tbody = $('#settlementTable tbody');
        tbody.empty();

        data.forEach(function(item) {
            var row = '<tr>' +
                     '<td>' + item.period + '</td>' +
                     '<td>' + item.order_count + '</td>' +
                     '<td>' + item.sales_quantity + '</td>' +
                     '<td>' + item.exchange_count + '</td>' +
                     '<td>' + item.return_count + '</td>' +
                     '<td>' + formatNumber(item.revenue) + '원</td>' +
                     '<td>' + formatNumber(item.commission) + '원</td>' +
                     '<td>' + formatNumber(item.profit) + '원</td>' +
                     '<td>' + item.settlement_date + '</td>' +
                     '</tr>';
            tbody.append(row);
        });
    }

    // 요약 정보 업데이트 함수
    function updateSummary(data) {
        var totalOrders = 0;
        var totalSales = 0;
        var totalCommission = 0;
        var totalProfit = 0;

        data.forEach(function(item) {
            totalOrders += item.order_count;
            totalSales += item.sales_quantity;
            totalCommission += item.commission;
            totalProfit += item.profit;
        });

        $('#totalOrders').text(totalOrders);
        $('#totalSales').text(totalSales);
        $('#totalCommission').text(formatNumber(totalCommission) + '원');
        $('#totalProfit').text(formatNumber(totalProfit) + '원');
    }

    // 숫자 포맷팅 함수
    function formatNumber(num) {
        return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }
}); 