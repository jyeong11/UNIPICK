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
        const realToday = new Date();
        // 2025년 기준으로 오늘 날짜 설정
        const today = new Date(2025, realToday.getMonth(), realToday.getDate());
        const thirtyDaysAgo = new Date(today);
        thirtyDaysAgo.setDate(today.getDate() - 30);
        
        // YYYY-MM-DD 형식으로 변환
        const endDateFormatted = `${today.getFullYear()}-${String(today.getMonth() + 1).padStart(2, '0')}-${String(today.getDate()).padStart(2, '0')}`;
        const startDateFormatted = `${thirtyDaysAgo.getFullYear()}-${String(thirtyDaysAgo.getMonth() + 1).padStart(2, '0')}-${String(thirtyDaysAgo.getDate()).padStart(2, '0')}`;
        
        console.log("초기화된 날짜 범위:", startDateFormatted, "~", endDateFormatted);
        
        $('#endDate').val(endDateFormatted);
        $('#startDate').val(startDateFormatted);
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
                console.log("API 응답 데이터:", data);
                console.log("일별 방문 데이터 수:", data.dailyVisits ? data.dailyVisits.length : 0);
                console.log("인기 상품 데이터 수:", data.popularProducts ? data.popularProducts.length : 0);
                
                // 데이터 유효성 검사
                if (!data || !data.dailyVisits) {
                    console.error("API에서 필요한 데이터를 받지 못했습니다:", data);
                    return;
                }
                
                updateCharts(data);
                updateTable(data);
                updateSummaryStats(data);
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

        // 데이터 유효성 검사
        if (!data.dailyVisits || data.dailyVisits.length === 0) {
            console.warn("차트를 그릴 방문 데이터가 없습니다.");
            const ctx = document.getElementById("dailyVisitChart").getContext('2d');
            new Chart(ctx, {
                type: "line",
                data: {
                    labels: ["데이터 없음"],
                    datasets: [{
                        label: "방문자 수",
                        data: [0],
                        borderColor: "#3b82f6",
                        backgroundColor: "rgba(59, 130, 246, 0.2)",
                        fill: true
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: { display: false }
                    }
                }
            });
            return;
        }

        // 데이터를 날짜순으로 정렬 (과거 -> 현재)
        const sortedData = [...data.dailyVisits].sort((a, b) => {
            return new Date(a.visitDate) - new Date(b.visitDate);
        });

        // 오늘 날짜 확인
        const today = new Date();
        const todayFormatted = today.toISOString().split('T')[0]; // YYYY-MM-DD 형식
        
        // 오늘 날짜가 데이터에 없는 경우 추가
        const hasToday = sortedData.some(item => item.visitDate === todayFormatted);
        if (!hasToday) {
            console.log("오늘 날짜 데이터가 없어 추가합니다:", todayFormatted);
            sortedData.push({
                visitDate: todayFormatted,
                visitCount: 0 // 기본값은 0으로 설정
            });
            
            // 다시 날짜순으로 정렬
            sortedData.sort((a, b) => new Date(a.visitDate) - new Date(b.visitDate));
        }

        console.log("차트 데이터 (정렬 후):", sortedData);
        
        // 현재 선택된 기간 유형 확인
        const periodType = $('#periodType').val();
        console.log("현재 선택된 기간 유형:", periodType);
        
        // 기간 유형에 따른 라벨 포맷 함수 설정
        let labelFormatter;
        switch (periodType) {
            case 'weekly':
                labelFormatter = (dateString) => {
                    try {
                        // 날짜 문자열 디버깅
                        console.log('주간 날짜 형식:', dateString);
                        
                        // 날짜 형식 분석 (YYYY-WW 형식 확인)
                        if (dateString && dateString.includes('-')) {
                            // 2025-13 형식일 경우: 연도-주차
                            const parts = dateString.split('-');
                            if (parts.length === 2) {
                                const year = parseInt(parts[0]);
                                const weekNum = parseInt(parts[1]);
                                
                                if (!isNaN(year) && !isNaN(weekNum)) {
                                    // 해당 연도의 첫 날
                                    const firstDayOfYear = new Date(year, 0, 1);
                                    
                                    // 해당 주차의 날짜 계산 (각 주는 7일)
                                    const daysToAdd = (weekNum - 1) * 7;
                                    const weekDate = new Date(firstDayOfYear);
                                    weekDate.setDate(firstDayOfYear.getDate() + daysToAdd);
                                    
                                    // 월 및 월별 주차 계산
                                    const month = weekDate.getMonth() + 1;
                                    
                                    // 해당 월의 첫 날
                                    const firstDayOfMonth = new Date(year, weekDate.getMonth(), 1);
                                    
                                    // 첫 날의 요일 (0: 일요일, 1: 월요일, ..., 6: 토요일)
                                    const firstDayOfWeek = firstDayOfMonth.getDay();
                                    
                                    // 첫 주의 날짜 수 계산
                                    const daysInFirstWeek = 7 - firstDayOfWeek;
                                    
                                    // 현재 날짜가 월의 몇 번째 주인지 계산
                                    const dayOfMonth = weekDate.getDate();
                                    let weekOfMonth;
                                    
                                    if (dayOfMonth <= daysInFirstWeek) {
                                        weekOfMonth = 1;
                                    } else {
                                        weekOfMonth = Math.ceil((dayOfMonth - daysInFirstWeek) / 7) + 1;
                                    }
                                    
                                    return `${month}월 ${weekOfMonth}주차`;
                                }
                            }
                        }
                        
                        // 일반 날짜 형식 처리 (백업)
                        const date = new Date(dateString);
                        if (!isNaN(date.getTime())) {
                            const month = date.getMonth() + 1;
                            // 월별 주차 계산 (해당 월의 첫째 주부터 1주차)
                            const firstDayOfMonth = new Date(date.getFullYear(), date.getMonth(), 1);
                            const firstDayOfWeek = firstDayOfMonth.getDay();
                            const daysInFirstWeek = 7 - firstDayOfWeek;
                            const dayOfMonth = date.getDate();
                            
                            let weekOfMonth;
                            if (dayOfMonth <= daysInFirstWeek) {
                                weekOfMonth = 1;
                            } else {
                                weekOfMonth = Math.ceil((dayOfMonth - daysInFirstWeek) / 7) + 1;
                            }
                            
                            return `${month}월 ${weekOfMonth}주차`;
                        }
                        
                        return dateString; // 원본 반환
                    } catch (e) {
                        console.error('주간 날짜 변환 오류:', e, dateString);
                        return dateString; // 원본 반환
                    }
                };
                break;
            case 'monthly':
                labelFormatter = (dateString) => {
                    try {
                        const date = new Date(dateString);
                        // 유효한 날짜인지 검사
                        if (isNaN(date.getTime())) {
                            return dateString; 
                        }
                        return `${date.getMonth() + 1}월`;
                    } catch (e) {
                        console.error('월별 날짜 변환 오류:', e);
                        return dateString;
                    }
                };
                break;
            case 'yearly':
                labelFormatter = (dateString) => {
                    try {
                        const date = new Date(dateString);
                        // 유효한 날짜인지 검사
                        if (isNaN(date.getTime())) {
                            return dateString;
                        }
                        return `${date.getFullYear()}년`;
                    } catch (e) {
                        console.error('연간 날짜 변환 오류:', e);
                        return dateString;
                    }
                };
                break;
            default: // daily 또는 기타
                labelFormatter = (dateString) => {
                    try {
                        const date = new Date(dateString);
                        // 유효한 날짜인지 검사
                        if (isNaN(date.getTime())) {
                            return dateString;
                        }
                        return `${date.getMonth() + 1}/${date.getDate()}`; 
                    } catch (e) {
                        console.error('일별 날짜 변환 오류:', e);
                        return dateString;
                    }
                };
        }
        
        // 차트 데이터 준비
        const labels = sortedData.map(d => labelFormatter(d.visitDate));
        const visitCounts = sortedData.map(d => d.visitCount);
        
        const ctx = document.getElementById("dailyVisitChart").getContext('2d');
        new Chart(ctx, {
            type: "line",
            data: {
                labels: labels,
                datasets: [{
                    label: "방문자 수",
                    data: visitCounts,
                    borderColor: "#3b82f6",
                    backgroundColor: "rgba(59, 130, 246, 0.2)",
                    fill: true,
                    tension: 0.1 // 곡선 부드럽게
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                scales: {
                    x: {
                        display: true,
                        grid: {
                            display: false
                        },
                        ticks: {
                            maxRotation: 45, // 라벨 회전 각도 조정
                            autoSkip: true,
                            maxTicksLimit: 20, // 최대 표시 라벨 수 증가
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

        // 이름이 너무 긴 상품을 짧게 만드는 함수
        const shortenProductName = (name) => {
            if (!name) return '';
            // 특수 문자 및 괄호 제거
            let shortName = name.replace(/[\[\](){}]/g, '');
            // 이모지 제거
            shortName = shortName.replace(/[\uD800-\uDBFF][\uDC00-\uDFFF]/g, '');
            // 길이 제한
            if (shortName.length > 15) {
                return shortName.substring(0, 15) + '...';
            }
            return shortName;
        };

        // 차트 데이터 준비
        const chartLabels = data.popularProducts.map(p => shortenProductName(p.productName));
        const chartData = data.popularProducts.map(p => p.visitCount);
        const backgroundColor = [
            '#4e73df', '#1cc88a', '#36b9cc', '#f6c23e',
            '#e74a3b', '#5a5c69', '#858796', '#6f42c1'
        ];

        const ctx = document.getElementById("popularProductsChart").getContext('2d');
        new Chart(ctx, {
            type: "doughnut",
            data: {
                labels: chartLabels,
                datasets: [{
                    data: chartData,
                    backgroundColor: backgroundColor,
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'right',
                        labels: {
                            boxWidth: 12,
                            padding: 10,
                            font: {
                                size: 10
                            }
                        }
                    },
                    tooltip: {
                        callbacks: {
                            label: function(context) {
                                const product = data.popularProducts[context.dataIndex];
                                return `${product.productName}: ${product.visitCount}회`;
                            }
                        }
                    }
                },
                cutout: '60%'
            }
        });
    }

    // 테이블 업데이트 - 완전히 새로운 접근 방식
    function updateTable(data) {
        console.log("테이블 업데이트 시작 - 완전히 새로운 방식");
        console.log("데이터:", data);
        
        // 인기 상품과 방문 데이터 확인
        if (!data.dailyVisits || data.dailyVisits.length === 0) {
            $('#visitorTable tbody').html('<tr><td colspan="3" class="text-center">방문 데이터가 없습니다.</td></tr>');
            return;
        }

        // 데이터 로깅 - 디버깅 용도
        console.log("방문 데이터 수:", data.dailyVisits.length);
        console.log("인기 상품 데이터 수:", data.popularProducts ? data.popularProducts.length : 0);
        console.log("인기 상품 데이터:", data.popularProducts);
        
        // 기존 테이블 초기화
        $('#visitorTable tbody').empty();
        
        // 1. 인기 상품 섹션 만들기 (모든 인기 상품 표시)
        if (data.popularProducts && data.popularProducts.length > 0) {
            // 인기 상품 헤더 추가
            $('#visitorTable tbody').append(
                '<tr class="table-info"><td colspan="3" class="text-center font-weight-bold">인기 상품 (방문 횟수순)</td></tr>'
            );
            
            // 모든 인기 상품 추가 (데이터베이스에서 가져온 그대로)
            data.popularProducts.forEach(function(product, index) {
                $('#visitorTable tbody').append(`
                    <tr class="product-row">
                        <td colspan="2" class="font-weight-bold">
                            ${index + 1}. ${product.productName}
                        </td>
                        <td class="text-right">
                            ${product.visitCount}회 방문
                        </td>
                    </tr>
                `);
            });
            
            // 구분선 추가
            $('#visitorTable tbody').append(
                '<tr><td colspan="3" class="text-center text-muted">---</td></tr>'
            );
        }
        
        // 2. 날짜별 방문자 데이터 추가 (최신 날짜순)
        const sortedVisits = [...data.dailyVisits].sort((a, b) => {
            return new Date(b.visitDate) - new Date(a.visitDate);
        });
        
        // 방문 데이터 헤더 추가
        $('#visitorTable tbody').append(
            '<tr class="table-primary"><td colspan="3" class="text-center font-weight-bold">날짜별 방문자 수</td></tr>'
        );
        
        // 모든 방문 데이터 추가
        sortedVisits.forEach(function(visit) {
            const formattedDate = formatDate(visit.visitDate);
            $('#visitorTable tbody').append(`
                <tr>
                    <td>${formattedDate}</td>
                    <td colspan="2">${visit.visitCount}명 방문</td>
                </tr>
            `);
        });
        
        console.log("테이블 업데이트 완료");
    }

    // 요약 통계 업데이트
    function updateSummaryStats(data) {
        if (!data || !data.dailyVisits) {
            console.error('요약 통계 업데이트를 위한 데이터가 없습니다.');
            $('#totalVisits').text('0');
            $('#dailyVisits').text('0');
            $('#totalProducts').text('0');
            $('#conversionRate').text('0%');
            return;
        }

        // 총 방문자 수 계산 (dailyVisits 배열의 visitCount 합계)
        const totalVisits = data.dailyVisits.reduce((sum, visit) => sum + parseInt(visit.visitCount), 0);
        $('#totalVisits').text(totalVisits);
        
        // 오늘 날짜 (2025년 기준)
        const realToday = new Date();
        const todayFormatted = `2025-${String(realToday.getMonth() + 1).padStart(2, '0')}-${String(realToday.getDate()).padStart(2, '0')}`;
        console.log("오늘 날짜 (2025년 기준):", todayFormatted);
        
        // 데이터에서 오늘 방문자 수 찾기
        const todayVisit = data.dailyVisits.find(visit => {
            if (!visit.visitDate) return false;
            
            // 날짜에 시간이 포함된 경우 (YYYY-MM-DD HH:MM:SS)
            if (visit.visitDate.includes(' ')) {
                return visit.visitDate.startsWith(todayFormatted);
            }
            // 날짜만 있는 경우 (YYYY-MM-DD)
            return visit.visitDate === todayFormatted;
        });
        
        console.log("찾은 오늘 방문 데이터:", todayVisit);
        
        // 오늘 방문자 수 업데이트
        if (todayVisit) {
            $('#dailyVisits').text(todayVisit.visitCount);
        } else {
            // 오늘 데이터가 없으면 가장 최근 날짜의 데이터 사용
            const sortedVisits = [...data.dailyVisits].sort((a, b) => {
                return new Date(b.visitDate) - new Date(a.visitDate);
            });
            
            const latestVisit = sortedVisits.length > 0 ? sortedVisits[0] : null;
            console.log("최신 방문 데이터:", latestVisit);
            
            if (latestVisit) {
                $('#dailyVisits').text(latestVisit.visitCount);
            } else {
                console.warn("방문 데이터가 없습니다.");
                $('#dailyVisits').text('0');
            }
        }
        
        // 총 상품 수 (인기 상품의 고유 항목 수)
        const uniqueProducts = new Set(data.popularProducts.map(product => product.productName));
        $('#totalProducts').text(uniqueProducts.size);
        
        // 전환율 계산 (여기서는 더미 데이터 대신 API에서 받아온 값을 사용)
        // 전환율 = (구매 수 / 방문자 수) * 100 (예시 계산법)
        const conversionRate = totalVisits > 0 ? Math.round((uniqueProducts.size / totalVisits) * 100) : 0;
        $('#conversionRate').text(conversionRate + '%');
    }
});