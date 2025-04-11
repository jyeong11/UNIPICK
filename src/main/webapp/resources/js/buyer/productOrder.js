$(function() {
    let query = window.location.search;
    let param = new URLSearchParams(query);

    let prd_cdArr = param.getAll("prd_cd");
    let colorArr = param.getAll("clr_nm");
    let sizeArr = param.getAll("siz_nm");
	let sizeotArr = param.getAll("ot");
    let qtyArr = param.getAll("qty");

    let sum = 0;
    let totalSf = 0;
    let ajaxCount = 0;

    prd_cdArr.forEach((prd_cd, idx) => {
        let color = colorArr[idx];
        let size = sizeArr[idx];
        let qty = qtyArr[idx];
		let ot = sizeotArr[idx];

        sessionStorage.setItem(`color_${prd_cd}`, color);
        sessionStorage.setItem(`size_${prd_cd}`, size);
        sessionStorage.setItem(`qty_${prd_cd}`, qty);
		sessionStorage.setItem(`ot_${prd_cd}`, ot);

        $.ajax({
            url: "productOrder",
            method: "POST",
            data: JSON.stringify({ prd_cd: prd_cd }),
            contentType: 'application/json',
            success: function(res) {
                if (res.length > 0) {
                    res.forEach(function(item) {
                        let totalPrdPrice = parseInt(item.prd_sp.replace(/,/g, '')) * parseInt(qty);
                        sum += totalPrdPrice + item.prd_sf;
                        totalSf += item.prd_sf;

                        $("#order-container").append(`
                            <div class="ord-title">
                                <div class="order-selnm">${item.sel_nm}</div>
                                <div class="pr"> 주문 금액 </div>
                            </div>
                            <div class="order-info">
								<div class="prd-item" data-id="${item.prd_cd}" data-sel="${item.sel_nm}" style="cursor: pointer;">
	                            	<div class="order-img">
	                                	<img src="${contextPath}${item.fil_pt}">
	                            	</div>
								</div>
                                <div class="info">
                                    <div class="prd">
                                        <div class="prd-nm">${item.prd_nm}</div>
                                        <div class="prd-sp">${totalPrdPrice.toLocaleString()}원</div>
                                    </div>
                                    <div class="prd-2">
                                        <span>${color}</span> / <span>${size}</span>
                                    </div>
                                    <div class="prd-1">
                                        <div class="prd-sf">배송비</div>
                                        <div class="prd-sf-wrap">${item.prd_sf.toLocaleString()}원</div>
                                    </div>
                                </div>
                            </div>
                        `);
                    });
                }

                ajaxCount++;
                if (ajaxCount === prd_cdArr.length) {
                    $("#orderInfo-container").html(`
                        <div class="ttpr">총 주문금액: ${sum.toLocaleString()}원</div>
                    `);

                    renderDeliveryForm();
                    renderPriceInfo(sum, totalSf);
                    renderPaymentOptions();
                    renderTerms();

                    $("#agree_all").change(function() {
                        $(".agree_chk").prop("checked", $(this).prop("checked"));
                        ButtonState();
                    });

                    $(".agree_chk").change(function() {
                        $("#agree_all").prop("checked", $(".agree_chk:checked").length === $(".agree_chk").length);
                        ButtonState();
                    });
                }
            },
            error: function() {
                alert("주문 정보를 불러오는 데 실패했습니다.");
                ajaxCount++;
            }
        });
    });
	// 사진 클릭시 해당 상품으로 이동
	$(document).on("click", ".prd-item", function() {
        let prdCd = $(this).data("id");
		let selNm = $(this).data("sel");
    	window.location.href = `productDetail?prd_cd=${prdCd}&sel_nm=${encodeURIComponent(selNm)}`;
    });
	// 카카오 주소창 띄우기 
	$(document).on("click", "#search-address", function(e) {
		e.preventDefault();
	    new daum.Postcode({
	        oncomplete: function(data) {
	            $("#shipping_zipcode").val(data.zonecode);
	            $("#shipping_address").val(data.address);
	        }
	    }).open();
	});	
	
	// 결제하기 버튼 클릭시 카카오페이
	$(document).on("click", "#submit-btn", function(e) {
		let productList = prd_cdArr.map(prd_cd => {
		    return {
		        prd_cd: prd_cd,
		        siz_nm: sessionStorage.getItem(`ot_${prd_cd}`),
		        clr_nm: sessionStorage.getItem(`color_${prd_cd}`),
		        qty: sessionStorage.getItem(`qty_${prd_cd}`)
		    };
		});
		
debugger;
	    if (!checkShippingInfo()) {
	        e.preventDefault();
	    } else {
			saveShippingInfo();
	        requestKakaoPay(sum, productList);
	    }
	});

	// 배송지 유효성 
	function checkShippingInfo() {
	    const shippingName = $("#shipping_name").val().trim();
	    const shippingTelephone = $("#shipping_telephone").val().trim();
	    const shippingZipcode = $("#shipping_zipcode").val().trim();
		const shippingadd = $("#shipping_address").val().trim();
		const shippingaddDetail = $("#shipping_addDetail").val().trim();
		
	    if (!shippingName || !shippingTelephone || !shippingZipcode || !shippingadd ||!shippingaddDetail) {
	        alert("모든 배송지 정보를 입력해주세요.");
	        return false;
	    }
	    return true;
	}
	
	// 배송지 입력된 값을 session에 저장
	function saveShippingInfo() {
	    const shippingInfo = {
	        shipping_name: $("#shipping_name").val(),
	        shipping_telephone: $("#shipping_telephone").val(),
	        shipping_zipcode: $("#shipping_zipcode").val(),
	        shipping_address: $("#shipping_address").val(),
			shipping_addDetail: $("#shipping_addDetail").val(),
	        shipping_memo: $("#shipping_memo").val()
	    };
	
	    for (const key in shippingInfo) {
	        if (shippingInfo.hasOwnProperty(key)) {
	            sessionStorage.setItem(key, shippingInfo[key]);
	        }
	    }
	}
	
	//이용약관 동의 유효성
	function ButtonState() {
		if ($("#agree_all").prop("checked")) {
			$("#submit-btn").prop("disabled", false).addClass("active");
		} else {
			$("#submit-btn").prop("disabled", true).removeClass("active");
		}
	}
	
	// 카카오페이 api
	function requestKakaoPay(amount, productList) {
	    fetch("pay/ready", {
	        method: "POST",
	        headers: {
	            "Content-Type": "application/json"
	        },
	        body: JSON.stringify({ 
				amount: amount,
				productList: productList,
				shipping_name: sessionStorage.getItem("shipping_name"),
	            shipping_telephone: sessionStorage.getItem("shipping_telephone"),
	            shipping_zipcode: sessionStorage.getItem("shipping_zipcode"),
	            shipping_address: sessionStorage.getItem("shipping_address"),
				shipping_addDetail: sessionStorage.getItem("shipping_addDetail"),
	            shipping_memo: sessionStorage.getItem("shipping_memo")
			})
	    })
	    .then(response => response.json()) 
	    .then(data => {
			 if (data.next_redirect_pc_url) {
				const redirectUrl = data.next_redirect_pc_url;
	            window.open(redirectUrl, "유니픽 카카오페이 결제창", "width=800px,height=700px;");
	        }else {
		        alert("결제 요청에 실패했습니다.");
			}
	        
	    })
	    .catch(error => {
	        console.error("결제 요청 오류:", error);
	        alert("결제 요청 중 오류가 발생했습니다.");
	    });
	}
	
    // 금융 결제원 api 
    $(document).on("click", "#openButton", function () {
        let url = "https://testapi.openbanking.or.kr/oauth/2.0/authorize?response_type=code&client_id=8bb0ac90-e493-4346-9f78-c97710692e4b&redirect_uri=http://localhost:8080/UNIPICK/close&state=1a5b3w2s5x9q7w8e4a5h6n2j1k8u6yfc&auth_type=0&scope=login inquiry transfer";
        const popup = window.open(url, "_blank", "width=380,height=670");

        const popupClosed = setInterval(() => {
            if (popup.closed) {
                clearInterval(popupClosed);
                const urlParams = new URLSearchParams(popup.location.search);
                const code = urlParams.get("code");
                if (code) {
                    getAccessToken(code);
                } else {
                    alert('인증에 실패했습니다.');
                }
            }
        }, 100);
    });

    // 금융 결제원 api Access Token을 요청
    function getAccessToken(code) {
        fetch('/UNIPICK/getToken', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ code: code }),
        })
        .then(res => res.json())
        .then(data => {
            if (data.access_token) { 
                accountInfo(data.access_token);
            } else {
                alert('Access Token을 가져오는 데 실패했습니다.');
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('서버 통신 오류가 발생했습니다.');
        });
    }

    // 금융 결제원 api 계좌 정보 요청
    function accountInfo(accessToken) {
        fetch('https://testapi.openbanking.or.kr/v2.0/transfer/withdraw/fin_num', {
            method: 'POST',
            headers: {
                'Authorization': 'Bearer ' + accessToken,  // Bearer Token을 Authorization 헤더에 추가
                'Content-Type': 'application/json',
            },
			body: {
				bank_tran_id: "F123456789U4BC34239Z",
				cntr_account_type: "N",
				cntr_account_num: "1101230000678",
				dps_print_content: "유니픽",
				fintech_use_num: "123456789012345678901234",
				tran_amt: "50000",
				tran_dtime: "20250326101921",
				req_client_name: "유니픽",
				req_client_account_num: "1101230000678",
				req_client_num: "HONGGILDONG1234",
				transfer_purpose: "TR"
			}
        })
        .then(res => res.json())
        .then(data => {
            if (data.success) {
                const accInfoHTML = `
                    <div id="acc-info">
                        <h3>${data.bank_nm}</h3>
                        <p>계좌번호: ${data.acc_num}</p>
                    </div>
                `;
                $("#payment-container").html(`
                    <div id="payment"><h2>결제수단</h2></div>
                    ${accInfoHTML}
                    <div class="price">
                        <div id="payment"><span>빠른페이</span></div>
                    </div>
                    <div class="card-first">
                        <div class="tie">
                            <div id="pmregister"><span>유니페이</span></div>
                            <button id="openButton" class="add_btn"> + 결제 수단 등록</button>
                        </div>
                    </div>
                `);
            } else {
                alert('계좌번호를 불러오는데 실패');
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('계좌 정보를 가져오는 데 오류가 발생했습니다.');
        });
    }

	// 배송지 정보
	function renderDeliveryForm() {
	    $("#deliInfo-container").html(`
	       <form id="delivery-form">
                <div id="del"><h2>배송지 정보</h2></div>
                <div class="del-nm"><span>수령인</span><input type="text" id="shipping_name"></div>
                <div class="del-nm">
					<span>휴대폰</span>
					<input type="text" id="shipping_telephone">
				</div>
                <div class="del-nm"><span>우편번호</span><input type="text" id="shipping_zipcode" readonly></div>
				<div class="del-nm">
					<span>배송주소</span>
					<input type="text" id="shipping_address" readonly> 
					<button id="search-address">주소찾기</button>
				</div>
				<div class="del-nm"><span>상세주소</span><input type="text" id="shipping_addDetail"></div>
                <div class="del-nm"><span>배송메모</span><input type="text" id="shipping_memo" placeholder="최대 100자까지 가능합니다"></div>
            </form>
	    `);
	}
	
	// 최종 결제금액
	function renderPriceInfo(sum, totalSf) {
	    $("#delprice-container").html(`
	        <div id="total"><h2>최종 결제금액</h2></div>
	        <div class="price">
	            <div id="total-pr"><span>총 상품금액</span><span>${sum.toLocaleString()}원</span></div>
	            <div id="total-dp"><span>총 배송비</span><span>${totalSf.toLocaleString()}원</span></div>
	        </div>
	        <div id="prpr"><span>결제 예상 금액</span><span id="sum">${sum.toLocaleString()}원</span>            
	        </div>
	    `);
	}
	
	// 결제수단
	function renderPaymentOptions() {
	    $("#payment-container").html(`
	        <div id="payment"><h2>결제수단</h2></div>
	        <div id="ty" class="price">
	            <input type="checkbox" id="pay8">
	            <div id="payment"><span>빠른페이</span></div>
	        </div>
	        <div class="card-first">
	            <div class="tie">
	                <div id="pmregister"><span>유니페이</span></div>
	                <button  id ="openButton" class="add_btn"> + 결제 수단 등록</button>
	            </div>
	        </div>
	        <div id ="io" class="anthor">
	            <input type="checkbox" id="pay9">
	            <div id="pay"><span>다른 결제 수단</span></div>
	        </div>
	        <div class="Other-Payment">
	            <img src="${contextPath}/resources/images/icon_pay_kakao.svg">
	        </div>
	    `);
		// 체크박스 하나만 선택가능
	  	$("#pay8, #pay9").change(function() {
	        if (this.id === "pay8" && this.checked) {
	            $("#pay9").prop("checked", false);
	        } else if (this.id === "pay9" && this.checked) {
	            $("#pay8").prop("checked", false);
	        }
	    });
	}
	
	// 약관동의
	function renderTerms() {
	    $("#term-container").html(`
	        <div id="total"><h2>주문내용 확인 및 결제 동의</h2></div>
	        <div class="price">
	            <label><input type="checkbox" id="agree_all"> 전체 동의하기 </label>
	            <label><input type="checkbox" class="agree_chk"> 유니픽 약관 동의 (필수)</label>
	            <label><input type="checkbox" class="agree_chk"> 개인정보수집 및 이용에 대한 안내 (필수)</label>
	            <label><input type="checkbox" class="agree_chk"> 구매조건 및 개인정보 제3자 제공 (필수)</label>
	        </div>
	    `);;
	}
});
