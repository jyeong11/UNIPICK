$(document).ready(function () {
    const sellerId = $('#sessionUserId').val();
    // DataTable 인스턴스를 전역 변수로 관리
    let visitorDataTable = null;
    
    if (!sellerId) {
        console.error('판매자 ID를 찾을 수 없습니다.');
        return;
    }

    // 날짜 형식 변환 함수 (YYYY-MM-DD 형식을 MM/DD로 변환)
    const formatDate = (dateString) => {
        const date = new Date(dateString);
        return `${date.getMonth() + 1}/${date.getDate()}`;
    };

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
                console.log("받은 데이터:", data); // 디버깅용 로그
                
                // 데이터 유효성 검사
                if (!data || !data.dailyVisits || !data.popularProducts) {
                    console.error("API에서 필요한 데이터를 받지 못했습니다:", data);
                    return;
                }
                
                // 데이터 길이 확인
                console.log("방문 데이터 개수:", data.dailyVisits.length);
                console.log("인기 상품 데이터 개수:", data.popularProducts.length);
                
                updateCharts(data);
                updateTable(data);
                updateSummaryStats();
            },
            error: function(xhr, status, error) {
                console.error('데이터 로드 실패:', error);
                console.error('상태 코드:', xhr.status);
                console.error('응답 텍스트:', xhr.responseText);
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

        // 데이터를 날짜순으로 정렬 (과거 -> 현재)
        const sortedData = [...data.dailyVisits].sort((a, b) => {
            return new Date(a.visitDate) - new Date(b.visitDate);
        });

        const ctx = document.getElementById("dailyVisitChart").getContext('2d');
        new Chart(ctx, {
            type: "line",
            data: {
                labels: sortedData.map(d => formatDate(d.visitDate)),
                datasets: [{
                    label: "방문자 수",
                    data: sortedData.map(d => d.visitCount),
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
                        display: true,
                        title: {
                            display: false
                        },
                        grid: {
                            display: false
                        },
                        ticks: {
                            maxRotation: 0,
                            autoSkip: true,
                            maxTicksLimit: 10,
                            callback: function(value, index, values) {
                                return value; // 날짜만 표시 (이미 formatDate 함수에서 처리됨)
                            }
                        }
                    },
                    y: {
                        beginAtZero: true,
                        title: {
                            display: false
                        }
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
                            },
                            title: function(tooltipItems) {
                                return tooltipItems[0].label; // 날짜 표시
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
        console.log("테이블 업데이트 시작");
        
        // 기본 테이블 참조 가져오기
        const visitorTable = document.getElementById('visitorTable');
        if (!visitorTable) {
            console.error('테이블을 찾을 수 없습니다.');
            return;
        }
        
        const tbody = visitorTable.querySelector('tbody');
        if (!tbody) {
            console.error('테이블 본문을 찾을 수 없습니다.');
            return;
        }
        
        // 기존 DataTable 인스턴스 제거 (간소화된 방식)
        try {
            if ($.fn.DataTable.isDataTable('#visitorTable')) {
                console.log("기존 DataTable 인스턴스 제거");
                const dt = $('#visitorTable').DataTable();
                dt.destroy();
                
                // DataTable 관련 DOM 요소 제거
                $('#visitorTable_wrapper').remove();
            }
        } catch (err) {
            console.warn('DataTable 제거 중 오류:', err);
        }
        
        // tbody 비우기
        tbody.innerHTML = '';

        // 날짜별로 정렬된 데이터 사용 (최신 날짜순)
        const sortedVisits = [...data.dailyVisits].sort((a, b) => {
            return new Date(b.visitDate) - new Date(a.visitDate);
        });

        console.log("정렬된 방문 데이터:", sortedVisits);

        // 데이터가 없는 경우 처리
        if (sortedVisits.length === 0) {
            console.log("방문 데이터가 없습니다");
            tbody.innerHTML = `<tr><td colspan="4" class="text-center">방문 데이터가 없습니다.</td></tr>`;
            return;
        }
        
        // 방문 데이터 표시 (인기 상품 데이터 없어도 방문 데이터만 표시)
        let tableContent = '';
        
        sortedVisits.forEach((daily, index) => {
            let productName = '-';
            let productVisits = '-';
            
            // 인기 상품 데이터가 있으면 표시
            if (data.popularProducts && data.popularProducts.length > 0) {
                const popularIndex = index % data.popularProducts.length;
                const popularProduct = data.popularProducts[popularIndex];
                
                productName = popularProduct ? popularProduct.productName : '-';
                //productVisits = popularProduct ? popularProduct.visitCount : '-';
            }
            
            // 날짜 형식을 MM/DD로 변환
            const formattedDate = formatDate(daily.visitDate);
            
            tableContent += `
                <tr>
                    <td>${formattedDate}</td>
                    <td>${daily.visitCount}</td>
                    <td>${productName}</td>
                </tr>
            `;
        });
        
        tbody.innerHTML = tableContent;

        // 테이블 초기화 (간소화된 방식)
        try {
            console.log("새 DataTable 인스턴스 생성");
            $('#visitorTable').DataTable({
                destroy: true,
                searching: true,
                ordering: true,
                order: [[0, "desc"]],
                pageLength: 10,
                // CORS 문제 해결을 위해 직접 언어 설정
                language: {
                    "decimal": "",
                    "emptyTable": "데이터가 없습니다",
                    "info": "_START_ - _END_ / _TOTAL_",
                    "infoEmpty": "0 - 0 / 0",
                    "infoFiltered": "(전체 _MAX_ 개 항목에서 필터링됨)",
                    "infoPostFix": "",
                    "thousands": ",",
                    "lengthMenu": "페이지당 _MENU_ 개씩 보기",
                    "loadingRecords": "로딩중...",
                    "processing": "처리중...",
                    "search": "검색:",
                    "zeroRecords": "검색 결과가 없습니다",
                    "paginate": {
                        "first": "처음",
                        "last": "마지막",
                        "next": "다음",
                        "previous": "이전"
                    },
                    "aria": {
                        "sortAscending": ": 오름차순 정렬",
                        "sortDescending": ": 내림차순 정렬"
                    }
                }
            });
            console.log("테이블 업데이트 완료");
        } catch (error) {
            console.error('DataTables 초기화 중 오류 발생:', error);
            // 오류 발생 시 기본 테이블만 표시
            console.log("기본 테이블만 표시합니다");
        }
    }

    // 요약 통계 업데이트
    function updateSummaryStats() {
        const periodType = $('#periodType').val();
        const startDate = $('#startDate').val();
        const endDate = $('#endDate').val();

        $.ajax({
            url: `${contextPath}/sellerVisit/stats/${sellerId}`,
            type: "GET",
            data: { periodType, startDate, endDate },
            dataType: "json",
            success: function(data) {
                // 총 방문자 수 계산 (dailyVisits 배열의 visitCount 합계)
                const totalVisits = data.dailyVisits.reduce((sum, visit) => sum + parseInt(visit.visitCount), 0);
                $('#totalVisits').text(totalVisits);
                
                // 오늘 방문자 수 (오늘 날짜의 방문자 수 찾기)
                const today = new Date().toISOString().split('T')[0];
                const todayVisit = data.dailyVisits.find(visit => visit.visitDate === today);
                $('#todayVisits').text(todayVisit ? todayVisit.visitCount : 0);
                
                // 총 상품 수 (인기 상품의 고유 항목 수)
                const uniqueProducts = new Set(data.popularProducts.map(product => product.productName));
                $('#totalProducts').text(uniqueProducts.size);
                
                // 전환율 계산 (여기서는 더미 데이터 대신 API에서 받아온 값을 사용)
                // 전환율 = (구매 수 / 방문자 수) * 100 (예시 계산법)
                const conversionRate = totalVisits > 0 ? Math.round((uniqueProducts.size / totalVisits) * 100) : 0;
                $('#conversionRate').text(conversionRate + '%');
            },
            error: function(xhr, status, error) {
                console.error('요약 통계 데이터 로드 실패:', error);
                // 오류 발생 시 기본값 표시
                $('#totalVisits').text('0');
                $('#todayVisits').text('0');
                $('#totalProducts').text('0');
                $('#conversionRate').text('0%');
            }
        });
    }
});