$(function() {
	// 최근 본 상품 저장
	// recentlyProduct();

    // 상품 더보기 버튼
	var prdCt = document.getElementById("prdCt");
	var loadMoreBtn = document.getElementById("loadMoreBtn");
	var moreItems = document.getElementById("moreItems");
	var prdCtContent = prdCt.innerHTML.trim();
	
	if (prdCtContent.length > 1000) {
	    prdCt.innerHTML = prdCtContent.substring(0, 1000) + "...";
	    moreItems.innerHTML = prdCtContent.substring(1000);
	    moreItems.style.display = "none";
	    loadMoreBtn.style.display = "block";
	    
	    loadMoreBtn.addEventListener("click", function() {
	        prdCt.innerHTML += moreItems.innerHTML;
	        moreItems.style.display = "none";
	        this.style.display = "none";
	    });
	}
 	
	// 사이즈 로드
	window.loadSize = function() {
        var selectedColor = $("#color").val();
		var sizeSelect = $("#size");

        if (!selectedColor) {
            sizeSelect.prop("disabled", true);
			return;
        }

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
		$("#total-price").hide();
        loadSize();
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
	// 구매하기 버튼 
	document.getElementById('buyButton').addEventListener('click', function(event) {
		let color= $("#color").val();
		let size = $("#size").val();
		let qty = $("#qty-input").val();
		
		if (!color || !size || size.trim() === "" || size === "[사이즈]를 선택하세요.") {
	        alert("색상과 사이즈를 모두 선택해주세요!");
	        event.preventDefault();
	        return;
    	}
    	window.location.href = `productOrder?prd_cd=${prdCd}&clr_nm=${encodeURIComponent(color)}&siz_nm=${encodeURIComponent(size)}&qty=${encodeURIComponent(qty)}`;
    });
	
});
function updateSize(sizes) {
    var sizeSelect = $('#size');
    
	sizeSelect.empty();
    sizeSelect.append('<option>[사이즈]를 선택하세요.</option>');
	
	if (sizes.length === 0) {
        sizeSelect.prop("disabled", true);
        return;
    }
	sizeSelect.prop("disabled", false);
	
 	$.each(sizes, function(index, size) {
	    if (size.prd_qt == 0) {
	        sizeSelect.append('<option value="' + size.cod_nm + '" disabled>' + size.cod_nm + ' (품절)</option>');
	    } else {
	        sizeSelect.append('<option value="' + size.cod_nm + '">' + size.cod_nm + '</option>');
	    }
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
 			let price = res[0].prd_sp.toString().replace(/,/g, ""); // 쉼표 제거
            price = parseInt(price) || 0;
            
            // 기존 내용 초기화
            $("#selected-option").empty();

            // 옵션 텍스트 및 가격 추가
            let optionText = `<span id="option-text">${selectedColor} / ${selectedSize}</span>`;

            // 수량 조절 버튼 추가
            let quantityControl = `
                <div class="quantity-box">
                    <button type="button" class="qty-btn" id="decrease-qty">-</button>
                    <input type="text" id="qty-input" value="1" min="1">
                    <button type="button" class="qty-btn" id="increase-qty">+</button>
                </div>
            `;

            // HTML 추가
            $("#selected-option").append(optionText + quantityControl);
			$("#price-text").text(price.toLocaleString() + "원");
            $("#total-price").fadeIn();

            // 수량 버튼 이벤트 추가
            $("#decrease-qty").click(function () {
                let qty = parseInt($("#qty-input").val());
                if (qty > 1) {
                    $("#qty-input").val(qty - 1);
                    updateTotalPrice(price);
                }
            });

            $("#increase-qty").click(function () {
                let qty = parseInt($("#qty-input").val());
                $("#qty-input").val(qty + 1);
                updateTotalPrice(price);
            });

            $("#qty-input").on("input", function () {
                let qty = parseInt($(this).val());
                if (isNaN(qty) || qty < 1) {
                    $(this).val(1);
                }
                updateTotalPrice(price);
            });

            $("#selected-option").fadeIn();
            $("#total-price").fadeIn();
        },
        error: function () {
            alert("가격 정보를 불러오는 데 실패했습니다.");
        }
    });
}
// 총 가격 업데이트 함수
function updateTotalPrice(price) {
    let qty = parseInt($("#qty-input").val()) || 1;
	$("#price-text").text((price * qty).toLocaleString() + "원");
}

//function recentlyProduct() {
//	
//	let data = {prd_cd : prdCd};
//	
//	$.ajax({
//		url: "registerRecentlyPrd",
//		method: "POST",
//		data: JSON.stringify(data),
//		contentType: "application/json",
//		error: function(xhr, status, error) {
//			alert("서버 오류가 발생했습니다.");
//		}
//	});
//}