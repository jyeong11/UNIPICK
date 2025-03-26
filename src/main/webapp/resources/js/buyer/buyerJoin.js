$(document).ready(function () {
    //---------------------------------------------------------------------
    // "전체동의하기(terms_all)" 체크박스 클릭 시 전체 항목 선택/해제 이벤트
    const checkAll = document.querySelector('#terms_all');
    if (checkAll) {
        const checkboxes = document.querySelectorAll('.terms');
        
        // 1. 초기 동기화
        checkboxes.forEach(checkbox => checkbox.checked = checkAll.checked);
        
        // 2. 전체선택 클릭시 이벤트
        checkAll.addEventListener('click', function() {
            let isChecked = checkAll.checked;
            checkboxes.forEach(checkbox => checkbox.checked = isChecked);
        });
        
        // 3. 개별 체크박스 클릭 시, 전체선택 상태 업데이트
        checkboxes.forEach(checkbox => {
            checkbox.addEventListener('click', function() {
                let totalCnt = checkboxes.length;
                let checkedCnt = document.querySelectorAll('.terms:checked').length;
                checkAll.checked = (totalCnt === checkedCnt);
            });
        });
    }
    
    // '다음' 버튼 클릭 시
    $("#completeBtn").on("click", function() {
        
        // 필수 약관 항목 체크
        let acc_ta = $("#terms_ta").is(":checked"); // 이용약관 동의
        let acc_pa = $("#terms_pa").is(":checked"); // 개인정보 처리 방침
        let acc_ma = $("#terms_ma").is(":checked"); // 마케팅 동의

        // 모든 필수 항목 동의 여부 확인
        if (!acc_ta || !acc_pa || !acc_ma) {
            alert("모든 필수 항목에 동의해야 가입이 가능합니다.");
            return false; // 폼 제출을 막음
        }



        // 서버로 데이터 전송
        $.ajax({
            type: "POST",
            url: "/UNIPICK/buyerJoin", // 서버의 등록 API URL
            data: { 
                acc_ta: acc_ta,
                acc_pa: acc_pa,
                acc_ma: acc_ma
            },
            success: function(response) {
                if (response.success) {
                    // 등록 성공 시 홈으로 이동
                    window.location.href = "/UNIPICK/buyerAuthentication";
                } else {
                    alert("가입에 실패했습니다. 다시 시도해주세요.");
                }
            },
            error: function() {
                alert("오류가 발생했습니다.");
            }
        });
    });
});
