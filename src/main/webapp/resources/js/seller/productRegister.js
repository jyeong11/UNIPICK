document.addEventListener("DOMContentLoaded", function () {

  // 1. 유효성 검사 함수
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

  // 2. 카테고리 드롭다운 초기화
  async function initDropdowns() {
    const apiUrl = contextPath + '/productCategory';
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
    function populateDropdown(dropdown, categories) {
      dropdown.innerHTML = '<option value="">선택하세요</option>';
      categories.forEach(({ lev_cd, lev_nm }) => {
        const option = document.createElement('option');
        option.value = lev_cd;
        option.textContent = lev_nm;
        dropdown.appendChild(option);
      });
    }
    const cat1 = document.getElementById('product_category');
    const cat2 = document.getElementById('product_category_sub');
    const cat3 = document.getElementById('product_category_detail');

    populateDropdown(cat1, await fetchCategories());
    cat1.addEventListener('change', async function () {
      populateDropdown(cat2, await fetchCategories(this.value));
      populateDropdown(cat3, []);
    });
    cat2.addEventListener('change', async function () {
      populateDropdown(cat3, await fetchCategories(this.value));
    });
  }

  // 3. 썸네일 미리보기 (이벤트 위임)
  document.querySelector('.item-thumb-group').addEventListener('click', function (e) {
    const btn = e.target.closest('.item-thumb-upload');
    if (!btn) return;
    const index = btn.getAttribute('data-index');
    const input = document.getElementById(`item-thumb-upload-btn${index}`);
    input.click();
    input.addEventListener("change", function (event) {
      const file = event.target.files[0];
      const reader = new FileReader();
      reader.onload = function (e) {
        document.getElementById(`item-thumb-preview${index}`).src = e.target.result;
      };
      reader.readAsDataURL(file);
    });
  });

  // 4. 글자 수 체크 (제목)
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

  // 5. TOAST UI Editor 초기화
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

  // 6. 배송 옵션 드롭다운 초기화
  async function initDeliveryDropdown() {
    const deliverySelect = document.getElementById('product_delivery');
    deliverySelect.innerHTML = '<option value="">선택하세요</option>';
    try {
      const response = await fetch(contextPath + '/deliveryOptions');
      if (!response.ok) throw new Error('네트워크 오류');
      const options = await response.json();
      options.forEach(option => {
        const opt = document.createElement('option');
        opt.value = option.cod_cd;   // 상세코드 ID
        opt.textContent = option.cod_nm;  // 상세코드 이름
        deliverySelect.appendChild(opt);
      });
    } catch (error) {
      console.error('배송 옵션 로딩 오류:', error);
    }
  }

  // 7. 상품 등록 폼 제출 이벤트
  $("#productRegist").on("submit", async function (event) {
    event.preventDefault();
    if (!validateForm()) return;
    let finalCategory = $("#product_category_detail").val() || $("#product_category_sub").val() || $("#product_category").val();
    const productData = {
      prd_id: "", // UUID는 서버에서 생성
      prd_nm: $("#item-regi-title-text").val(),
      sel_id: "TEST_SELLER_ID", // 실제 세션 값 사용
      prd_cd: finalCategory,
      prd_ds: true,
      prd_op: $("#list_price").val(),
      prd_sp: $("#sale_price").val(),
      prd_bd: ""
    };
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

  // 8. 기타 초기화 (카테고리, 배송 옵션, 배송비 표시 등)
  initDropdowns();
  initDeliveryDropdown();
  $("#shipping-fee-enable, #shipping-fee-disable").change(function () {
    if ($("#shipping-fee-enable").is(":checked")) {
      $("#list_price").show();
    } else {
      $("#list_price").hide().val(0);
    }
  });
});
