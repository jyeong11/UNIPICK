document.addEventListener("DOMContentLoaded", function () {
  // 1. 전역 사이즈 옵션 데이터 변수 (초기값은 빈 배열)
  let globalSizeOptions = [];

  // 2. 사이즈 옵션 select 요소를 채우는 공통 함수
  function populateSizeSelect(selectElement, options) {
    selectElement.innerHTML = '<option value="">선택하세요</option>';
    options.forEach(option => {
      const opt = document.createElement('option');
      opt.value = option.cod_cd;      
      opt.textContent = option.cod_nm;  
      selectElement.appendChild(opt);
    });
  }

  // 3. 서버에서 사이즈 옵션 데이터를 가져와 전역 변수에 할당 후 메인 드롭다운에 옵션 채우기
  fetch(contextPath + '/seller/sizeOptions')
    .then(response => {
      if (!response.ok) throw new Error("네트워크 오류");
      return response.json();
    })
    .then(data => {
      globalSizeOptions = data;
      console.log("사이즈 옵션 로딩 완료:", globalSizeOptions);
      const mainSizeSelect = document.getElementById("product_size");
      if (mainSizeSelect) {
        populateSizeSelect(mainSizeSelect, globalSizeOptions);
      }
      document.getElementById("add-size").disabled = false;  // "사이즈 추가" 버튼 활성화
    })
    .catch(error => {
      console.error("사이즈 옵션 로딩 오류:", error);
      alert("사이즈 옵션 데이터를 불러오지 못했습니다.");
    });

  // 4. 유효성 검사 함수
  function validateForm() {
    if (!$("#item-thumb-upload-btn1").val()) {
      alert("썸네일을 등록해주세요!");
      $("#item-thumb-preview1").focus();
      return false;
    }
    if (!$("#item-regi-title-text").val()) {
      alert("제목을 입력해주세요!");
      $("#item-regi-title-text").focus();
      return false;
    }
    if (!noteditor.getMarkdown().trim()) {
      alert("내용을 입력해주세요!");
      return false;
    }
    return true;
  }

  // 5. 드롭다운 초기화 (카테고리, 배송, 재고 옵션 등)
  async function initDropdowns() {
    function populateDropdown(dropdown, items) {
      dropdown.innerHTML = '<option value="">선택하세요</option>';
      items.forEach(({ lev_cd, lev_nm }) => {
        const option = document.createElement('option');
        option.value = lev_cd;
        option.textContent = lev_nm;
        dropdown.appendChild(option);
      });
    }

    const cat1 = document.getElementById('product_category');
    const cat2 = document.getElementById('product_category_sub');
    const cat3 = document.getElementById('product_category_detail');
    async function fetchCategories(parentCode = '') {
      try {
        const response = await fetch(`${contextPath}/seller/productCategory?parentCode=${parentCode}`);
        if (!response.ok) throw new Error('네트워크 오류');
        return await response.json();
      } catch (error) {
        console.error('카테고리 로딩 오류:', error);
        return [];
      }
    }
    async function initCategory() {
      populateDropdown(cat1, await fetchCategories());
      cat1.addEventListener('change', async function () {
        populateDropdown(cat2, await fetchCategories(this.value));
        populateDropdown(cat3, []);
      });
      cat2.addEventListener('change', async function () {
        populateDropdown(cat3, await fetchCategories(this.value));
      });
    }

    const deliverySelect = document.getElementById('product_delivery');
    async function initDelivery() {
      deliverySelect.innerHTML = '<option value="">선택하세요</option>';
      try {
        const response = await fetch(contextPath + '/seller/deliveryOptions');
        if (!response.ok) throw new Error('네트워크 오류');
        const options = await response.json();
        options.forEach(option => {
          const opt = document.createElement('option');
          opt.value = option.cod_cd;
          opt.textContent = option.cod_nm;
          deliverySelect.appendChild(opt);
        });
      } catch (error) {
        console.error('배송 옵션 로딩 오류:', error);
      }
    }

    const stockSelect = document.getElementById('stock_management');
    async function initStockOptions() {
      stockSelect.innerHTML = '<option value="">선택하세요</option>';
      try {
        const response = await fetch(contextPath + '/seller/stockOptions');
        if (!response.ok) throw new Error('네트워크 오류');
        const options = await response.json();
        options.forEach(option => {
          const opt = document.createElement('option');
          opt.value = option.cod_cd;
          opt.textContent = option.cod_nm;
          stockSelect.appendChild(opt);
        });
      } catch (error) {
        console.error('재고 옵션 로딩 오류:', error);
      }
    }

    await initCategory();
    await initDelivery();
    await initStockOptions();
  }

  // 6. 썸네일 미리보기 (이벤트 위임)
  document.querySelector('.item-thumb-group').addEventListener('click', function (e) {
    const btn = e.target.closest('.item-thumb-upload');
    if (!btn) return;
    const index = btn.getAttribute('data-index');
    const input = document.getElementById(`item-thumb-upload-btn${index}`);
    input.click();
    if (!input.dataset.bound) {
      input.addEventListener("change", function (event) {
        const file = event.target.files[0];
        const reader = new FileReader();
        reader.onload = function (e) {
          document.getElementById(`item-thumb-preview${index}`).src = e.target.result;
        };
        reader.readAsDataURL(file);
      });
      input.dataset.bound = "true";
    }
  });

  // 7. 글자 수 체크 (제목)
  function updateByteCount(inputSelector, countSelector, maxLength, alertMsg) {
    $(inputSelector).on('keydown change', function () {
      const content = $(this).val();
      $(countSelector).text(`(${content.length} / ${maxLength})`);
      if (content.length > maxLength) {
        alert(alertMsg);
        $(this).val(content.substring(0, maxLength));
        $(countSelector).text(`(${maxLength} / ${maxLength})`);
      }
    });
  }
  updateByteCount("#item-regi-title-text", "#item-regi-name-byte", 50, "최대 50자까지 입력 가능합니다.");

  // 8. TOAST UI Editor 초기화
  const { colorSyntax } = toastui.Editor.plugin;
  const noteditor = new toastui.Editor({
    el: document.querySelector('#editor'),
    height: '300px',
    initialEditType: 'wysiwyg',
    initialValue: '',
    previewStyle: 'tab',
    plugins: [colorSyntax],
    toolbarItems: [
      ['heading', 'bold', 'italic', 'strike'],
      ['hr', 'quote'],
      ['ul', 'ol', 'task'],
      ['code', 'codeblock'],
      ['image'],
    ],
    hooks: {
      addImageBlobHook: async (blob, callback) => {
        const formData = new FormData();
        formData.append('image', blob);
        try {
          const response = await fetch(contextPath + '/upload', {
            method: 'POST',
            body: formData
          });
          const result = await response.json();
          callback(result.url, '이미지 설명');
        } catch (error) {
          console.error('이미지 업로드 실패:', error);
          alert('이미지 업로드 중 오류가 발생했습니다.');
        }
      }
    }
  });
  document.querySelector('.toastui-editor-defaultUI').style.width = '950px';

  // 9. 폼 제출 이벤트 처리
  $("#productRegist").on("submit", async function (event) {
    event.preventDefault();
    if (!validateForm()) return;

    let formData = new FormData();

    // 상품 데이터 객체 생성
    let productData = {
      prd_nm: $("#item-regi-title-text").val(),
      prd_cd: $("#item-regi-code-text").val(),
      prd_op: $("#list_price").val(),
      prd_sp: $("#sale_price").val(),
      sel_id: "TEST_SELLER_ID", // 실제 로그인한 사용자의 ID 사용
      prd_ca: $("#product_category_detail").val() || $("#product_category_sub").val() || $("#product_category").val(),
      prd_qt: $("#stock_number").val() || 0,  // null 처리 (기본값 0)
      prd_ds: $("#prd_ds_checkbox").is(":checked") ? 1 : 0,
      prd_bd: $("#some_element").val(),
      colors: [], // 색상 배열
      sizes: []   // 사이즈 배열
    };

    console.log("사이즈 배열:", productData.sizes);  // 사이즈 배열 출력
    console.log("색상 배열:", productData.colors);  // 색상 배열 출력

    // 색상 추가 (빈 값 제외)
    document.querySelectorAll("input[name='color_number']").forEach(input => {
      if (input.value.trim() !== "") {
        productData.colors.push(input.value); // 각 색상 값을 개별적으로 처리
      }
    });

    // 사이즈 추가 (빈 값 제외)
    document.querySelectorAll("select[name='size_option']").forEach(select => {
      if (select.value.trim() !== "") {
        productData.sizes.push(select.value); // 각 사이즈를 개별적으로 처리
      }
    });

    // 상품 데이터 JSON 변환 후 FormData에 추가
    console.log("상품 데이터:", productData);  // 이 부분을 통해 전송되는 데이터 확인
    formData.append("productData", new Blob([JSON.stringify(productData)], { type: "application/json" }));

    // 이미지 파일 추가
    document.querySelectorAll(".item-thumb-upload-btn").forEach(input => {
      if (input.files.length > 0) {
        for (let i = 0; i < input.files.length; i++) {
          formData.append("imageFiles", input.files[i]);
        }
      }
    });

    try {
      const response = await fetch(contextPath + "/seller/registerProduct", {
        method: "POST",
        body: formData,
        headers: {
          "Accept": "application/json" // JSON 응답을 받기 위해 추가
        }
      });

      if (!response.ok) {
        const errorText = await response.text();
        throw new Error("저장 실패");
      }
      const result = await response.json();
      window.location.href = contextPath + "/selProductList";
    } catch (error) {
      console.error("저장 오류:", error);
    }
  });

  // 배송비 노출 토글
  $("#shipping-fee-enable, #shipping-fee-disable").change(function () {
    if ($("#shipping-fee-enable").is(":checked")) {
      $("#list_price").show();
    } else {
      $("#list_price").hide().val(0);
    }
  });

  // 색상 다중 선택 기능 추가
  document.getElementById("add-color").addEventListener("click", function () {
    const container = document.getElementById("color-container");
    const newColorInput = document.createElement("input");
    newColorInput.type = "color";
    newColorInput.name = "color_number";
    newColorInput.className = "color-picker";
    newColorInput.style.marginRight = "5px";

    const removeBtn = document.createElement("button");
    removeBtn.type = "button";
    removeBtn.textContent = "삭제";
    removeBtn.className = "btn btn-sm btn-outline-danger";
    removeBtn.addEventListener("click", function () {
      newColorInput.remove();
      removeBtn.remove();
    });
    container.appendChild(newColorInput);
    container.appendChild(removeBtn);
  });

  // "사이즈 추가" 버튼 클릭 시 동적으로 사이즈 select 요소 추가
  document.getElementById("add-size").addEventListener("click", function () {
    if (globalSizeOptions.length === 0) {
      alert("사이즈 옵션 데이터가 아직 로딩되지 않았습니다. 잠시 후 다시 시도해주세요.");
      return;
    }
    const container = document.getElementById("size-container");
    const newSelect = document.createElement("select");
    newSelect.name = "size_option";
    newSelect.className = "size-select";
    newSelect.style.marginRight = "5px";
    populateSizeSelect(newSelect, globalSizeOptions);

    const removeBtn = document.createElement("button");
    removeBtn.type = "button";
    removeBtn.textContent = "삭제";
    removeBtn.className = "btn btn-sm btn-outline-danger";
    removeBtn.addEventListener("click", function () {
      newSelect.remove();
      removeBtn.remove();
    });
    container.appendChild(newSelect);
    container.appendChild(removeBtn);
  });

  initDropdowns();
});