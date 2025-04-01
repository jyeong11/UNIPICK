$(document).ready(function() {
    // 초기 데이터 로드
    loadSettlementData();

    // 검색 버튼 클릭 이벤트
    $('#searchBtn').click(function() {
        loadSettlementData();
    });

    // Excel 다운로드 버튼 클릭 이벤트
    $('#excelBtn').click(function() {
        downloadExcel();
    });

    function loadSettlementData() {
        const periodType = $('#periodType').val();
        const startDate = $('#startDate').val();
        const endDate = $('#endDate').val();

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
                "url": "//cdn.datatables.net/plug-ins/1.10.24/i18n/Korean.json"
            },
            "order": [[0, "desc"]],
            "pageLength": 10
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