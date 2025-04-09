document.addEventListener("DOMContentLoaded", function () {
  // 1. 전역 사이즈 옵션 데이터 변수 (초기값은 빈 배열)
  let globalSizeOptions = [];
	let globalBadgeOptions = [];

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

  // 3. 뱃지 옵션 select 요소를 채우는 공통 함수
  function BadgeSelect(selectElement, options) {
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
    })
    .catch(error => {
      console.error("사이즈 옵션 로딩 오류:", error);
      alert("사이즈 옵션 데이터를 불러오지 못했습니다.");
    });


	 fetch(contextPath + '/seller/badgeOptions')
    .then(response => {
      if (!response.ok) throw new Error("네트워크 오류");
      return response.json();
    })
    .then(data => {
      globalBadgeOptions = data;
      console.log("뱃지 옵션 로딩 완료:", globalBadgeOptions);
    const badgeContainer = document.querySelector('.item-regi-price-box');
    const initialSelect = document.getElementById("product_badge");
    if (initialSelect) {
      BadgeSelect(initialSelect, globalBadgeOptions);
		}
    })
    .catch(error => {
      console.error("뱃지 옵션 로딩 오류:", error);
      alert("뱃지 옵션 데이터를 불러오지 못했습니다.");
    });

// 뱃지 select 요소 변경 시 처리 함수
//function handleBadgeChange(event) {
//  const select = event.target;
//  // 선택 값이 있을 때만 처리
//  if (select.value.trim() !== "") {
//    const badgeContainer = document.querySelector('.item-regi-badge-box');
//    // 컨테이너 내부의 모든 select 요소 선택
//    const selects = badgeContainer.querySelectorAll("select[name='product_badge[]']");
//    // 현재 변경된 요소가 마지막 select 요소일 경우에만 새 select 추가
//    if (select === selects[selects.length - 1]) {
//      const newSelect = document.createElement("select");
//      newSelect.name = "product_badge[]";
//	 newSelect.id = "product_badge";
//      // 기존 select와 동일한 클래스를 부여
//      newSelect.className = "item-regi-badge-box";
//      BadgeSelect(newSelect, globalSizeOptions);
//      newSelect.addEventListener("change", handleBadgeChange);
//      badgeContainer.appendChild(newSelect);
//    }
//  }
//}

  // 4. 유효성 검사 함수
  function validateForm() {
    if (!$("#item-thumb-upload-btn1").val()) {
      alert("썸네일을 등록해주세요!");
      $("#item-thumb-preview1").focus();
      return false;
    }
    if (!$("#item-regi-title-text").val()) {
      alert("상품명을 입력해주세요!");
      $("#item-regi-title-text").focus();
      return false;
    }
    if (!prdeditor.getMarkdown().trim()) {
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
      });

    }

    await initCategory();
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
  updateByteCount("#item-regi-title-text", "#item-regi-name-byte", 100, "최대 100자까지 입력 가능합니다.");
  updateByteCount("#item-regi-code-text", "#item-regi-code-byte", 20, "최대 20자까지 입력 가능합니다.");

  // 8. TOAST UI Editor 초기화
  const { colorSyntax } = toastui.Editor.plugin;
  const prdeditor = new toastui.Editor({
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
        formData.append('file', blob);
        try {
			const response = await fetch(contextPath + '/upload', {
				method: 'POST',
				body: formData
			});
			const result = await response.json();
			console.log('이미지 업로드 응답:', result); 
			if(result.url){
	        	callback(contextPath + result.url, '이미지 설명');
				console.log(contextPath + result.url);
			} else {
				console.error('이미지 URL이 없음:', result);
		        alert('이미지 업로드 중 문제가 발생했습니다.');
			}
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

	let content = prdeditor.getHTML();
    document.getElementById("prd_ct").value = content;

    let formData = new FormData();
    // 상품 데이터 객체 생성
    let productData = {
	
      prd_nm: $("#item-regi-title-text").val(),
      prd_cd: $("#item-regi-code-text").val(),
      prd_op: $("#list_price").val(),
      prd_sp: $("#sale_price").val(),
      sel_id: $("").val(),
      prd_ca: $("#product_category_detail").val() || $("#product_category_sub").val() || $("#product_category").val(),
      prd_qt: $("#stock_number").val() || 0,  // null 처리 (기본값 0)
      prd_ds: $("#prd_ds_checkbox").is(":checked") ? 1 : 0,
      prd_bd: $("#product_badge").val(),
	  prd_sf: $("#delivery_price").val()|| 0,
	  prd_ct: content,
	  sizes: [],   // 사이즈 배열
      colors: [], // 색상 배열
	  stocks: [],
	  colorsnm: []
    };

    console.log("사이즈 배열:", productData.sizes);  // 사이즈 배열 출력
    console.log("색상 배열:", productData.colors);  // 색상 배열 출력
	console.log("재고 배열:", productData.stocks);  // 색상 배열 출력


    document.querySelectorAll("select[name='product_badge[]']").forEach(select => {
      if (select.value.trim() !== "") {
       // productData.prd_bd.push(select.value);
      }
    });

    // 색상 추가 (빈 값 제외)
    document.querySelectorAll("#option-container input[name='color_number[]']").forEach(input => {
      if (input.value.trim() !== "") {
        productData.colors.push(input.value); // 각 색상 값을 개별적으로 처리
      }
    });

    document.querySelectorAll("#option-container input[name='color_name[]']").forEach(input => {
      if (input.value.trim() !== "") {
        productData.colorsnm.push(input.value); // 각 색상 값을 개별적으로 처리
      }
    });

    // 사이즈 추가 (빈 값 제외)
    document.querySelectorAll("#option-container select[name='size_option[]']").forEach(select => {
      if (select.value.trim() !== "") {
        productData.sizes.push(select.value); // 각 사이즈를 개별적으로 처리
      }
    });

	// 재고 추가 (빈 값 제외)
    document.querySelectorAll("#option-container input[name='stock_number[]']").forEach(input => {
      if (input.value.trim() !== "") {
        productData.stocks.push(input.value); // 각 사이즈를 개별적으로 처리
      }
    });

    // 상품 데이터 JSON 변환 후 FormData에 추가
    console.log("상품 데이터:", productData);  // 이 부분을 통해 전송되는 데이터 확인
    formData.append("productData", new Blob([JSON.stringify(productData)], { type: "application/json" }));

    // 이미지 파일 추가
    document.querySelectorAll(".item-thumb-upload-btn").forEach(input => {
	  if (input.files.length > 0) {
	    let index = input.closest(".item-thumb").querySelector(".item-thumb-upload").getAttribute("data-index");  
	    for (let i = 0; i < input.files.length; i++) {
	      formData.append("imageFiles", input.files[i]);
	      formData.append("imageIndexs", index);  // 해당 인덱스도 추가
	    }
	  }
	});
    try {
      const response = await fetch(contextPath + "/seller/registerProduct", {
        method: "POST",
        body: formData,
//        headers: {
//          "Accept": "application/json" // JSON 응답을 받기 위해 추가
//        }
//		contentType:"application/json" 
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

//  // 배송비 노출 토글
//  $("#shipping-fee-enable, #shipping-fee-disable").change(function () {
//    if ($("#shipping-fee-enable").is(":checked")) {
//      $("#list_price").show();
//    } else {
//      $("#list_price").hide().val(0);
//    }
//  });

document.getElementById("add-option").addEventListener("click", function () {
    const container = document.getElementById("option-container");

    // 새로운 옵션을 감싸는 div 생성
    const optionRow = document.createElement("div");
    optionRow.className = "option-row";
    optionRow.style.display = "flex";
    optionRow.style.alignItems = "center";
    optionRow.style.gap = "10px"; // 요소 간격 추가
    optionRow.style.marginBottom = "10px"; // 아래 여백 추가

    // 색상 입력 (color)
    const newColorInput = document.createElement("input");
    newColorInput.type = "color";
    newColorInput.name = "color_number[]";
    newColorInput.className = "color-picker";

	  // 색상 입력 (color)
    const newColorText = document.createElement("input");
    newColorText.type = "text";
    newColorText.name = "color_name[]";
    newColorText.className = "color-name";

    // 사이즈 선택 (select)
    const newSizeSelect = document.createElement("select");
    newSizeSelect.name = "size_option[]";
    newSizeSelect.className = "size-select";
    populateSizeSelect(newSizeSelect, globalSizeOptions); // 옵션 채우기

    // 재고 수량 입력 (number)
    const newStockInput = document.createElement("input");
    newStockInput.type = "number";
    newStockInput.name = "stock_number[]";
    newStockInput.className = "stock-number";
    newStockInput.placeholder = "재고 수량 입력";

    // 삭제 버튼
    const removeBtn = document.createElement("button");
    removeBtn.type = "button";
    removeBtn.textContent = "삭제";
    removeBtn.className = "btn btn-sm btn-outline-danger";
    removeBtn.addEventListener("click", function () {
        optionRow.remove();
    });

    // 요소들을 optionRow에 추가
    optionRow.appendChild(newColorInput);
	optionRow.appendChild(newColorText);
    optionRow.appendChild(newSizeSelect);
    optionRow.appendChild(newStockInput);
    optionRow.appendChild(removeBtn);

    // 컨테이너에 optionRow 추가
    container.appendChild(optionRow);
});

  initDropdowns();
});