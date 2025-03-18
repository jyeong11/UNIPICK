$(function(){
  // 폼 유효성 검사 함수
  function validateForm() {
    if ($("#item-thumb-upload-btn1").val() === "") {
      alert("썸네일을 등록해주세요!");
      $("#item-thumb-preview1").focus();
      return false;
    }
    if ($("#item-regi-title-text").val() === "") {
      alert("제목을 입력해주세요!");
      $("#item-regi-title-text").focus();
      return false;
    }
    if ($("#item-regi-description-text").val() === "") {
      alert("내용을 입력해주세요!");
      $("#item-regi-description-text").focus();
      return false;
    }
    // 기타 유효성 검사 조건 생략
    return true;
  }

  //카테고리 드롭다운 초기화 및 이벤트 설정
  async function initDropdowns() {
    const apiUrl = contextPath + '/productCategory'; // GET 요청 URL
    //상위 코드에 따른 카테고리 데이터를 로드하는 함수
    async function fetchCategories(parentCode = '') {
      try {
        const response = await fetch(`${apiUrl}?parentCode=${parentCode}`);
        if (!response.ok) throw new Error('네트워크 오류');
        return await response.json();
      } catch (error) {
        console.error('카테고리 로딩 오류:', error);
        return [];
      }
    }

    // 드롭다운에 옵션 채우기
    function populateDropdown(dropdown, categories) {
      dropdown.innerHTML = '<option value="">선택하세요</option>';
      categories.forEach(({ lev_cd, lev_nm }) => {
        const option = document.createElement('option');
        option.value = lev_cd;
        option.textContent = lev_nm;
        dropdown.appendChild(option);
      });
    }

    const productCategory  = document.getElementById('product_category');
    const productCategory1 = document.getElementById('product_category1');
    const productCategory2 = document.getElementById('product_category2');

    // 첫 번째 드롭다운 초기화 (부모 코드가 없을 때)
    populateDropdown(productCategory, await fetchCategories());

    // 첫 번째 드롭다운 변경 시 중분류 및 소분류 업데이트
    productCategory.addEventListener('change', async function () {
      populateDropdown(productCategory1, await fetchCategories(this.value));
      populateDropdown(productCategory2, []);
    });

    // 중분류 변경 시 소분류 업데이트
    productCategory1.addEventListener('change', async function () {
      populateDropdown(productCategory2, await fetchCategories(this.value));
    });
  }

  // 썸네일 등록 (기존 기능)
  $('.item-thumb-upload').on('click', function(){
    let id = this.children[0].id;
    let idx = id.substr(id.length - 1);
    let myInput = document.getElementById("item-thumb-upload-btn" + idx);
    myInput.click();
    $("#item-thumb-upload-btn" + idx).on("change", function(event) {
      let file = event.target.files[0];
      let reader = new FileReader();
      reader.onload = function(e) {
        $("#item-thumb-preview" + idx).attr("src", e.target.result);
      }
      reader.readAsDataURL(file);
    });
  });

  // 글자수 체크 기능 (기존 기능)
  function updateByteCount(selector, byteSelector, maxLength, alertMessage) {
    $(selector).on('keydown change', function() {
      let content = $(this).val();
      $(byteSelector).text("(" + content.length + " / " + maxLength + ")");
      if (content.length > maxLength) {
        alert(alertMessage);
        $(this).val(content.substring(0, maxLength));
        $(byteSelector).text("(" + maxLength + " / " + maxLength + ")");
      }
    });
  }
  if ($("#item-regi-title-text").length) {
    updateByteCount("#item-regi-title-text", "#item-regi-name-byte", 50, "최대 50자까지 입력 가능합니다.");
  }
  if ($("#item-regi-description-text").length) {
    updateByteCount("#item-regi-description-text", "#item-regi-description-byte", 2000, "최대 2000자까지 입력 가능합니다.");
  }

  // 상품등록 폼 제출 이벤트 통합 처리
  $("#productRegist").on("submit", async function(event) {
    event.preventDefault();

    if (!validateForm()) return;

    // 상품 등록 폼 데이터 수집
    // 카테고리의 경우, 드롭다운 중 가장 하위 단계(값이 존재하는 마지막 항목)를 최종 카테고리로 판단합니다.
    let finalCategory = "";
    if ($("#product_category2").val()) {
      finalCategory = $("#product_category2").val();
    } else if ($("#product_category1").val()) {
      finalCategory = $("#product_category1").val();
    } else {
      finalCategory = $("#product_category").val();
    }
    
    // 기타 상품 데이터(예: 제목, 설명 등)는 폼의 다른 필드에서 가져와야 합니다.
    const productData = {
      prd_id: "", // 상품 ID는 UUID 생성 등으로 처리 (여기서는 생략)
      prd_nm: $("#item-regi-title-text").val(),
      sel_id: "TEST_SELLER_ID", // 세션 또는 폼에서 전달받아야 함
      prd_cd: finalCategory, // 최종 카테고리 코드 저장
      prd_ds: true,           // 노출여부 (예시)
      prd_op: $("#shipping-fee-price").val(),  // 정가 예시
      prd_sp: $("#product_price").val(),         // 판매가 예시
      prd_bd: ""              // 뱃지 (필요 시 처리)
    };

    // POST 요청: 상품 등록 API 호출
    try {
      const response = await fetch(contextPath + '/api/insertProduct', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(productData)
      });
      if (!response.ok) throw new Error('저장 실패');
      const result = await response.json();
      console.log('상품 등록 완료:', result);
      window.location.href = contextPath + '/productList';
    } catch (error) {
      console.error('저장 오류:', error);
    }
  });

  // 드롭다운 초기화 실행
  initDropdowns();

  // 배송비 입력박스, 기타 설정 (생략)
  $("#shipping-fee-enable, #shipping-fee-disable").change(function() {
    if ($("#shipping-fee-enable").is(":checked")) {
      $("#shipping-fee-price").show();
    } else {
      $("#shipping-fee-price").hide();
      $("#shipping-fee-price").val(0);
    }
  });
});