$(function() {
	window.loadSize = function() {
        var selectedColor = $("#color").val();
		var sizeSelect = $("#size")

        if (!selectedColor) {
            sizeSelect.prop("disabled", true);
			return;
        }
		sizeSelect.prop("disabled", false);
        $.ajax({
            url: 'getSizeByColor',
            method: 'POST',
            data: JSON.stringify({prd_cd: prdCd,color: selectedColor}),
            contentType: 'application/json',
			success: function(res) {
                updateSize(res);
            },
            error: function() {
                alert("사이즈 정보를 불러오는 데 실패했습니다.");
            }
        });
	}

    // 컬러 변경 시 사이즈 초기화 및 선택 이벤트 등록
    $("#color").change(function() {
        $("#selected-option").hide();
        loadSize();
    });
	document.getElementById("loadMoreBtn").addEventListener("click", function() {
	    var moreItems = document.getElementById("moreItems");
	    moreItems.style.display = "block";  // 상품 더보기 정보를 표시
	    this.style.display = "none";  // 더보기 버튼 숨기기
	});
	// 맨 위로 스크롤
	document.getElementById('scrollToTop').addEventListener('click', function () {
	    window.scrollTo({
	        top: 0,
	        behavior: 'smooth'
		});
	});
	// 맨 밑으로 스크롤
	document.getElementById('scrollToBottom').addEventListener('click', function () {
	    window.scrollTo({
	        top: document.documentElement.scrollHeight,
	        behavior: 'smooth'
		});
	});
//	document.querySelector(".npay").addEventListener("click", function () {
//        window.location.href = `productOrder?prd_cd=${prdCd}`;
//    });
	
});
function updateSize(sizes) {
    var sizeSelect = $('#size');
    
	sizeSelect.empty();

    sizeSelect.append('<option>[사이즈]를 선택하세요.</option>');

    $.each(sizes, function(index, size) {
        sizeSelect.append('<option value="' + size.cod_nm + '">' + size.cod_nm);
    });
	// 옵션 전부 클릭시 이벤트 발생
	 sizeSelect.off("change").on("change", function () {
        showSelectedOption();
    });
}
 function showSelectedOption() {
    var selectedColor = $("#color").val();
    var selectedSize = $("#size").val();

    if (!selectedColor || !selectedSize) {
        $("#selected-option").hide();
        return;
    }

    $.ajax({
        url: "getSizeByColor",
        method: "POST",
        data: JSON.stringify({prd_cd: prdCd, color: selectedColor, size: selectedSize}),
        contentType: "application/json",
        success: function (res) {

            $("#option-text").text(selectedColor + " / " + selectedSize);
            $("#option-price").text(res[0].prd_sp + "원");
			$('#price-text').text(res[0].prd_sp + '원');

			$("#selected-option").fadeIn();
			$("#total-price").fadeIn();
        },
        error: function () {
            alert("가격 정보를 불러오는 데 실패했습니다.");
        }
    });
}
function requestKakaoPay(amount, prdCd) {
    fetch("pay/ready", {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify({ amount: amount, prdCd: prdCd }) // 결제 금액을 서버로 전달
    })
    .then(response => response.json()) 
    .then(data => {
		 if (data.next_redirect_pc_url) {
			const redirectUrl = data.next_redirect_pc_url;
            window.open(redirectUrl, "유니픽 카카오페이 결제창", "width=800px,height=700px;");
       debugger;
        } else {
            alert("결제 요청에 실패했습니다.");
        }
    })
    .catch(error => {
        console.error("결제 요청 오류:", error);
        alert("결제 요청 중 오류가 발생했습니다.");
    });
}