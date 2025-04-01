$(document).ready(function () {
    const sellerId = $('#sessionUserId').val();
    
    if (!sellerId) {
        console.error('판매자 ID를 찾을 수 없습니다.');
        return;
    }

    // 초기 데이터 로드
    loadData();

    // 검색 버튼 클릭 이벤트
    $('#searchBtn').click(function() {
        loadData();
    });

   function loadData() {
    const periodType = $('#periodType').val();
    const startDate = $('#startDate').val();
    const endDate = $('#endDate').val();

    $.ajax({
        url: `${contextPath}/sellerVisit/stats/${sellerId}`,
        type: "GET",
        data: {
            periodType: periodType,
            startDate: startDate,
            endDate: endDate
        },
        dataType: "json",
        success: function (data) {
            updateCharts(data);
            updateTable(data);
        },
        error: function(xhr, status, error) {
            console.error('데이터 로드 실패:', error);
        }
    });
}

    function updateCharts(data) {
        // 일별 방문자 차트 업데이트
        const dailyChart = new Chart(document.getElementById("dailyVisitChart"), {
            type: "line",
            data: {
                labels: data.dailyVisits.map(d => d.visitDate),
                datasets: [{
                    label: "방문자 수",
                    data: data.dailyVisits.map(d => d.visitCount),
                    borderColor: "#3b82f6",
                    backgroundColor: "rgba(59, 130, 246, 0.2)",
                    fill: true
                }]
            },
            options: {
                responsive: true,
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });

        // 인기 상품 차트 업데이트
        const popularChart = new Chart(document.getElementById("popularProductsChart"), {
            type: "bar",
            data: {
                labels: data.popularProducts.map(p => p.productName),
                datasets: [{
                    label: "조회수",
                    data: data.popularProducts.map(p => p.visitCount),
                    backgroundColor: "#f59e0b"
                }]
            },
            options: {
                responsive: true,
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });
    }

    function updateTable(data) {
        const tbody = $('#visitorTable tbody');
        tbody.empty();

        data.dailyVisits.forEach(daily => {
            const popularProduct = data.popularProducts.find(p => p.visitDate === daily.visitDate);
            const row = `
                <tr>
                    <td>${daily.visitDate}</td>
                    <td>${daily.visitCount}</td>
                    <td>${popularProduct ? popularProduct.productName : '-'}</td>
                    <td>${popularProduct ? popularProduct.visitCount : '-'}</td>
                </tr>
            `;
            tbody.append(row);
        });

        // DataTables 새로고침
        if ($.fn.DataTable.isDataTable('#visitorTable')) {
            $('#visitorTable').DataTable().destroy();
        }
        $('#visitorTable').DataTable({
            "language": {
                "url": "//cdn.datatables.net/plug-ins/1.10.24/i18n/Korean.json"
            },
            "order": [[0, "desc"]],
            "pageLength": 10
        });
    }
});