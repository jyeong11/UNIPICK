$(function() {
    let query = window.location.search;
    let param = new URLSearchParams(query);
    let prd_cd = param.get('prd_cd');
    $.ajax({
        url: "productOrder",
        method: "POST",
        data: JSON.stringify({ prd_cd: prd_cd }),
        contentType: 'application/json',
        success: function(res){
            let sum = 0;
            let totalSf = 0;
    
            if (res.length > 0) {
                res.forEach(function(item) {
                    let formatPrdSf = new Intl.NumberFormat().format(item.prd_sf);
                    $("#order-container").append(`
                        <div class="ord-title">
                            <div class="order-selnm">${item.sel_nm}</div>
                            <div class="pr"> 주문 금액 </div>
                        </div>
                        <div class="order-info">
                            <div class="order-img">
                                <img src="${contextPath}/resources${item.fil_pt}">
                            </div>
                            <div>
                                <div class="prd">
                                    <div class="prd-nm">${item.prd_nm}</div>
                                    <div class="prd-sp">${item.prd_sp}원</div>
                                </div>
                                <div class="prd-1">
                                    <div class="prd-sf">배송비</div>
                                    <div class="prd-sf-wrap">${formatPrdSf}원</div>
                                </div>
                            </div>
                        </div>
                    `);
                    sum += parseInt(item.prd_sp.replace(',', ''));
                    totalSf += item.prd_sf;
                });
                $("#orderInfo-container").html(`
                    <div class="ttpr">총 주문금액:  ${sum.toLocaleString()}원</div>
                `);
                $("#deliInfo-container").html(`
                    <form id="delivery-form">
                        <div id="del"><h2>배송지 정보</h2></div>
                        <div class="del-nm"><span>수령인</span><input type="text" id="shipping_name"></div>
                        <div class="del-nm"><span>휴대폰</span><input type="text" id="shipping_telephone"></div>
                        <div class="del-nm"><span>배송주소</span><input type="text" id="shipping_zip"></div>
                        <div class="del-nm"><span>배송메모</span><input type="text" id="shipping_memo" placeholder="최대 100자까지 가능합니다"></div>
                    </form>
                `);
                $("#delprice-container").html(`
                    <div id="total"><h2>최종 결제금액</h2></div>
                    <div class="price">
                        <div id="total-pr"><span>총 상품금액</span><span>${sum.toLocaleString()}원</span></div>
                        <div id="total-dp"><span>총 배송비</span><span>${totalSf.toLocaleString()}원</span></div>
                    </div>
                    <div id="prpr"><span>결제 예상 금액</span><span id="sum">${sum.toLocaleString()}원</span>            	
                    </div>
                `);
                $("#payment-container").html(`
                    <div id="payment"><h2>결제수단</h2></div>
                    <div class="price">
                        <div id="payment"><span>빠른페이</span></div>
                    </div>
                    <div class="card-fisst"></div>
                    <div class="card-first">
                        <div class="tie">
                            <div id="pmregister"><span>유니페이</span></div>
                            <button  id ="openButton" class="add_btn"> + 결제 수단 등록</button>
                        </div>
                    </div> 	
                `);
                $("#term-container").html(`
                    <div id="total"><h2>주문내용 확인 및 결제 동의</h2></div>
                    <div class="price">
                        <label><input type="checkbox" id="agree_all"> 전체 동의하기</label>
                        <label><input type="checkbox" class="agree_chk"> 유니픽 약관 동의 (필수)</label>
                        <label><input type="checkbox" class="agree_chk"> 개인정보수집 및 이용에 대한 안내 (필수)</label>
                        <label><input type="checkbox" class="agree_chk"> 구매조건 및 개인정보 제3자 제공 (필수)</label>
                    </div>
                `);
    
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
        }
    });

    function ButtonState() {
        if ($("#agree_all").prop("checked")) {
            $("#submit-btn").prop("disabled", false).addClass("active");
        } else {
            $("#submit-btn").prop("disabled", true).removeClass("active");
        }
    }

    // 버튼 클릭시 금융원인증
    $(document).on("click", "#openButton", function () {
        let url = "https://testapi.openbanking.or.kr/oauth/2.0/authorize?response_type=code&client_id=8bb0ac90-e493-4346-9f78-c97710692e4b&redirect_uri=http://localhost:8080/UNIPICK/close&state=1a5b3w2s5x9q7w8e4a5h6n2j1k8u6yfc&auth_type=0&scope=login inquiry transfer";
        const popup = window.open(url, "_blank", "width=380,height=670");

        const popupClosed = setInterval(() => {
            if (popup.closed) { // 팝업 닫혔는지 확인
                clearInterval(popupClosed); // 팝업 닫힘 확인 후 반복 중지
                const urlParams = new URLSearchParams(popup.location.search);
                const code = urlParams.get("code");
                if (code) {
	debugger;
                    getAccessToken(code); // 인증 코드로 액세스 토큰 요청
                } else {
                    alert('인증에 실패했습니다.'); // 인증 실패 시 알림
                }
            }
        }, 100);
    });

    // 서버에 인증 코드를 보내 Access Token을 요청
    function getAccessToken(code) {
        fetch('/UNIPICK/getToken', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ code: code }),  // 인증 받은 code를 서버로 전달
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

    // 계좌 정보 요청
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
	debugger;
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
                    <div class="card-fisst"></div> <!-- 여기서 계좌 정보를 삽입 -->
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
});
