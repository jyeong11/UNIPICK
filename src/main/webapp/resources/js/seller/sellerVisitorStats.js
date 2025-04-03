$(document).ready(function () {
    const sellerId = $('#sessionUserId').val();
    
    if (!sellerId) {
        console.error('판매자 ID를 찾을 수 없습니다.');
        return;
    }

    // 초기 설정
    initializeDateRange();
    initializeEventHandlers();
    loadData(); // 초기 데이터 로드

    // 날짜 범위 초기화
    function initializeDateRange() {
        const today = new Date();
        const thirtyDaysAgo = new Date(today);
        thirtyDaysAgo.setDate(today.getDate() - 30);
        
        $('#endDate').val(today.toISOString().split('T')[0]);
        $('#startDate').val(thirtyDaysAgo.toISOString().split('T')[0]);
    }

    // 이벤트 핸들러 초기화
    function initializeEventHandlers() {
        // 기간 선택 버튼 클릭 이벤트
        $('.period-selector').click(function() {
            $('.period-selector').removeClass('active');
            $(this).addClass('active');
            $('#periodType').val($(this).data('period'));
            loadData();
        });

        // 검색 버튼 클릭 이벤트
        $('#searchBtn').click(loadData);

        // 내보내기 버튼 이벤트
        $('#exportExcel').click(function(e) {
            e.preventDefault();
            alert('Excel 내보내기 기능이 준비 중입니다.');
        });
        
        $('#exportPDF').click(function(e) {
            e.preventDefault();
            alert('PDF 내보내기 기능이 준비 중입니다.');
        });
    }

    // 데이터 로드 및 차트 업데이트
    function loadData() {
        const periodType = $('#periodType').val();
        const startDate = $('#startDate').val();
        const endDate = $('#endDate').val();

        $.ajax({
            url: `${contextPath}/sellerVisit/stats/${sellerId}`,
            type: "GET",
            data: { periodType, startDate, endDate },
            dataType: "json",
            success: function(data) {
                updateCharts(data);
                updateTable(data);
                updateSummaryStats();
            },
            error: function(xhr, status, error) {
                console.error('데이터 로드 실패:', error);
            }
        });
    }

    // 차트 업데이트
    function updateCharts(data) {
        updateDailyVisitChart(data);
        updatePopularProductsChart(data);
    }

    // 일별 방문자 차트 업데이트
    function updateDailyVisitChart(data) {
        // 기존 차트 제거를 위해 캔버스 재생성
        const chartContainer = document.getElementById("dailyVisitChart").parentNode;
        const oldCanvas = document.getElementById("dailyVisitChart");
        oldCanvas.remove();
        const newCanvas = document.createElement("canvas");
        newCanvas.id = "dailyVisitChart";
        chartContainer.appendChild(newCanvas);

        const ctx = document.getElementById("dailyVisitChart").getContext('2d');
        new Chart(ctx, {
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
                maintainAspectRatio: false,
                scales: {
                    x: {
                        display: false // x축 레이블 숨기기
                    },
                    y: {
                        beginAtZero: true
                    }
                },
                plugins: {
                    legend: {
                        display: false // 범례 숨기기
                    },
                    tooltip: {
                        mode: 'index',
                        intersect: false,
                        callbacks: {
                            label: function(context) {
                                return `방문자 수: ${context.raw}명`;
                            }
                        }
                    }
                }
            }
        });
    }

    // 인기 상품 차트 업데이트
    function updatePopularProductsChart(data) {
        // 기존 차트 제거를 위해 캔버스 재생성
        const chartContainer = document.getElementById("popularProductsChart").parentNode;
        const oldCanvas = document.getElementById("popularProductsChart");
        oldCanvas.remove();
        const newCanvas = document.createElement("canvas");
        newCanvas.id = "popularProductsChart";
        chartContainer.appendChild(newCanvas);

        const ctx = document.getElementById("popularProductsChart").getContext('2d');
        new Chart(ctx, {
            type: "doughnut",
            data: {
                labels: data.popularProducts.map(p => p.productName),
                datasets: [{
                    data: data.popularProducts.map(p => p.visitCount),
                    backgroundColor: [
                        '#4e73df', '#1cc88a', '#36b9cc', '#f6c23e',
                        '#e74a3b', '#5a5c69', '#858796', '#6f42c1'
                    ],
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        display: false
                    },
                    tooltip: {
                        callbacks: {
                            label: function(context) {
                                return `${context.label}: ${context.raw}회`;
                            }
                        }
                    }
                },
                cutout: '60%'
            }
        });
    }

    // 테이블 업데이트
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
            language: {
                url: "//cdn.datatables.net/plug-ins/1.10.24/i18n/Korean.json"
            },
            order: [[0, "desc"]],
            pageLength: 10
        });
    }

    // 요약 통계 업데이트
    function updateSummaryStats() {
        // 예시 데이터 - 실제로는 API에서 가져온 데이터로 대체해야 함
        $('#totalVisits').text(Math.floor(Math.random() * 10000));
        $('#todayVisits').text(Math.floor(Math.random() * 100));
        $('#totalProducts').text(Math.floor(Math.random() * 500));
        $('#conversionRate').text(Math.floor(Math.random() * 15) + '%');
    }
});