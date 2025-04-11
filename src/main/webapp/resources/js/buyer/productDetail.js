$(function() {
	// 리뷰
	loadReviews();
	// 추천상품
	RecommendPrd();
	
	// 찜 버튼
	$(document).on("click", ".wishlist-btn", function() {
		wish($(this).find("i"));
	});
	
	// 찜 버튼2
	$(document).on("click", ".prdImg-div .heart2", function(event) {
		event.stopPropagation();
		wish($(this));
	});

	// 다음 버튼
	let currentIndex = 0; // 현재 이미지의 인덱스

	$('#next-btn').on("click", function () {
	    if (prdImg.length === 0) return; // 이미지 배열이 비어있다면 실행하지 않음
	
	    // 다음 이미지로 인덱스 변경
	    currentIndex = (currentIndex + 1) % prdImg.length;
	
	    // 이미지 변경
	    $('#product-image').attr("src", contextPath + prdImg[currentIndex].slice(8,-1));
	});
	// 이전 버튼
	$('#prev-btn').on("click", function () {
	    if (prdImg.length === 0) return; // 이미지 배열이 비어있다면 실행하지 않음
	
	    // 이전 이미지로 인덱스 변경 (음수 방지)
	    currentIndex = (currentIndex - 1 + prdImg.length) % prdImg.length;
	
	    // 이미지 변경
	    $('#product-image').attr("src", contextPath + prdImg[currentIndex].slice(8, -1));
	});
	
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
	
	// 장바구니
	$('.cart-btn').on("click", function (e) {
		let color = $("#color").val();
		let sizenm = $("#size").val();
		let size = $("#size option:selected").text();
		let qty = $("#qty-input").val();
		
		if (!color || !size || size.trim() === "" || size === "[사이즈]를 선택하세요.") {
	        alert("색상과 사이즈를 모두 선택해주세요!");
	        e.preventDefault();
	        return;
    	}
		
		$.ajax({
			url: "cartInsert",
			method: "POST",
			data: JSON.stringify({
				prd_cd: prdCd,
				sel_nm: sel_nm,
				size: sizenm, 
				color: color,
				qty: qty
			}),
			contentType: "application/json",
			success: function(){
				let result = confirm("선택하신 상품들이 정상적으로 장바구니에 담겼습니다.\n 지금 장바구니로 이동하시겠습니까?");
				if (result) {
					window.location.href = "cart";
			    }
			},
			error: function() {
                alert("다시 시도해주세요.");
            }
		});
	});

    // 컬러 변경 시 사이즈 초기화 및 선택 이벤트 등록
    $("#color").change(function() {
        $("#selected-option").hide();
		$("#total-price").hide();
        loadSize();
    });
	
	// 사진 클릭시 해당 상품으로 이동
	$(document).on("click", ".prd-item", function() {
        let prdCd = $(this).data("id");
		let selNm = $(this).data("sel");
    	window.location.href = `productDetail?prd_cd=${prdCd}&sel_nm=${encodeURIComponent(selNm)}`;
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
		let sizenm = $("#size option:selected").text();
		let qty = $("#qty-input").val();
		debugger;
		if (!color || !size || size.trim() === "" || size === "[사이즈]를 선택하세요.") {
	        alert("색상과 사이즈를 모두 선택해주세요!");
	        event.preventDefault();
	        return;
    	}
    	window.location.href = `productOrder?prd_cd=${prdCd}&clr_nm=${encodeURIComponent(color)}&siz_nm=${encodeURIComponent(sizenm)}&ot=${encodeURIComponent(size)}&qty=${encodeURIComponent(qty)}`;
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
	        sizeSelect.append('<option value="' + size.cod_cd + '" disabled>' + size.cod_nm + ' (품절)</option>');
	    } else {
	        sizeSelect.append('<option value="' + size.cod_cd + '">' + size.cod_nm + '</option>');
	    }
    });
	// 옵션 전부 클릭시 이벤트 발생
	 sizeSelect.off("change").on("change", function () {
        showSelectedOption();
    });
}
 function showSelectedOption() {
    var selectedColor = $("#color").val();
    var selectedSize = $("#size option:selected").text();

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

// 리뷰
function loadReviews() {
	let query = window.location.search;
	let param = new URLSearchParams(query);
	let prd_cd = param.get('prd_cd');
	
    $.ajax({
        type: 'POST', 
        url: 'getReviews',
		contentType: "application/json",
		data: JSON.stringify({prd_cd: prd_cd}),
        success: function(res) {
			var reviewsHtml = '';
            if (res && res.length > 0) {
                res.forEach(function(review) {
					// 별 채우기
					var starHtml = '';
		            var rating = review.rev_rt;
		            for (var i = 1; i <= 5; i++) {
		                if (i <= rating) {
		                    starHtml += `<span class="star-filled">★</span>`;  // 채워진 별
						}
					}
                    reviewsHtml += `<div class="review">
										<div class="star-ema">
											<div class="rev-ema">${review.buy_nm}</div>
											<div class="st">${starHtml}</div>	
										</div> 
										<img src="${contextPath}${review.rei_pt}" class="review-img">
                                         <div class="rev">
											<div class="rev-opt">
												<div class="rev-optTitle">옵션</div>
												<p>${review.clr_nm}</p>
												<p>${review.cod_nm}</p>
											</div>
											<div class="info">
												<div class="buy-info">정보</div>
												<p>${review.buy_wt}kg</p>
												<p>${review.buy_ht}cm</p>
											</div>
										</div>
										<div class="rev-ct">${review.rev_ct}</div>
									</div>`;
                });
            } else {
                reviewsHtml = '<p>리뷰가 없습니다.</p>';
            }
            $('#rev').html(reviewsHtml); 
        },
        error: function(xhr, status, error) {
            console.error("리뷰 데이터를 불러오는 데 실패했습니다:", error);
      	}
	});
}
function RecommendPrd() {
	let query = window.location.search;
	let param = new URLSearchParams(query);
	let prd_cd = param.get('prd_cd');
	
    $.ajax({
        type: 'POST', 
        url: 'getRecommendPrd',
		contentType: "application/json",
		data: JSON.stringify({prd_cd: prd_cd}),
        success: function(res) {
			let pickPrd = $("#pickPrd");
            let productHtml = "";
            res.forEach(prd => {
				let heartClass = prd.buy_em ? 'fa-solid yellow' : 'fa-regular';
                productHtml += `
                    <div class="product">
						<div class="prd-item" data-id="${prd.prd_cd}" data-sel="${prd.sel_nm}" style="cursor: pointer;">
							<div class="prdImg-div">
	                        	<img src="${contextPath}${prd.fil_pt}" alt="${prd.prd_nm} class="pick-img">
								<i class="${heartClass} fa-heart heart2" data-value="${prd.prd_cd}"></i>
							</div>
	                        <p class="pick-nm">${prd.prd_nm}</p>
							<div class="pick-pc">
	                    		<p class="pick-dc">${prd.dc}</p>
	                        	<p class="pick-sp">${prd.prd_sp.toLocaleString()}원</p>
							</div>
						</div>
					</div>
                `;
            });
            pickPrd.html(productHtml);
        },
        error: function(xhr, status, error) {
            console.error("리뷰 데이터를 불러오는 데 실패했습니다:", error);
      	}
	});
}

// 찜 버튼
function wish(heart) {
	heartIcon = heart[0];
	let prd_cd = heart.attr('data-value');
	heartIcon.classList.toggle("fa-regular");
	heartIcon.classList.toggle("fa-solid");
	let action = "insert";
	debugger;
	if(heartIcon.classList.contains("fa-regular")) {
		 action = "delete";
	}
	
	data = {prd_cd : prd_cd, action : action};
	
	$.ajax({
		type: "POST",
        url: "wishList",
		data: JSON.stringify(data),
		contentType: "application/json",
        error: function(xhr, status, error) {
        	if(confirm("로그인 후 사용하실 수 있습니다.\n 로그인페이지로 이동하시겠습니까?")){
				window.location.href="buyerlogin";
			}
			heartIcon.classList.toggle("fa-regular");
			heartIcon.classList.toggle("fa-solid");
			return false;
        }
	});
	
}
