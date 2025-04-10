let prdeditor;		// 토스트 에디터
let deletedOptions = [];	// 삭제할 옵션id

$(function(){
	
	// 상품 수정
	$('#update').on('click', function(e) {
		 e.preventDefault();
		productUpdate();
	});
	
	// 상품 삭제
	$('#delete').on('click', function() {
		productDelete();
	});
	
	///////
	// 상품 정보
	
    let query = window.location.search;
    let param = new URLSearchParams(query);
    let prd_cd = param.get('prd_cd');
    let globalSizeOptions = [];

    $(document).ready(function() {
        $.ajax({
            type: "POST",
            url: "selproductDetail",
            data: JSON.stringify({prd_cd : prd_cd}),
            contentType: "application/json",
            success: function(res) {
                // 상품이미지
				const contextPath = window.location.pathname.substring(0, window.location.pathname.indexOf("/", 2));
                let img = $(".item-thumb-group");
                img.empty(); // 기존 이미지 박스 초기화

                // productImages가 존재하는지 확인
                if (res.prdImg && Array.isArray(res.prdImg)) {
                    // 받은 이미지를 처리
                    for (let i = 0; i < 10; i++) {
                        let imgUrl = res.prdImg[i] || '/resources/img/product-thumb-no.jpg'; // 이미지가 없으면 기본 이미지 사용
                        let thumbHtml = `
                            <div class="item-thumb">
                                <button type="button" class="item-thumb-upload" data-index="${i}">
                                    <img src="${contextPath}${imgUrl.fil_pt}" id="item-thumb-preview${i}">
                                </button>
                                <input type="file" class="item-thumb-upload-btn" id="item-thumb-upload-btn${i}" name="productData">
                            </div>
                        `;
                        img.append(thumbHtml); // 새로운 이미지 요소 추가
                    }
                } else {
                    // productImages가 없다면 기본 이미지를 채워넣음
                    for (let i = 0; i < 10; i++) {
                        let thumbHtml = `
                            <div class="item-thumb">
                                <button type="button" class="item-thumb-upload" data-index="${i}">
                                    <img src="/resources/img/product-thumb-no.jpg" id="item-thumb-preview${i}">
                                </button>
                                <input type="file" class="item-thumb-upload-btn" id="item-thumb-upload-btn${i}" name="productData">
                            </div>
                        `;
                        img.append(thumbHtml); // 새로운 이미지 요소 추가
                    }
                }

                // 상품
                let title = res.prdData.prd_nm;
				$('#item-regi-title-text').val(title);
				$('#item-regi-name-byte').text("(" + title.length + " / 100)");
                let code = res.prdData.prd_cd
				$('#item-regi-code-text').val(code);
				$('#item-regi-code-byte').text("(" + code.length + " / 50)");
                $('#list_price').val(res.prdData.prd_op);
                $('#sale_price').val(res.prdData.prd_sp);
                $('#delivery_price').val(res.prdData.prd_sf);
				prdeditor.setHTML(res.prdData.prd_ct);

				// 상품 옵션
				let option = res.prdOpt.map(item =>
				`<div class="option-row" data-value="${item.opt_id}" style="display: flex; align-items: center; gap: 10px; margin-bottom: 10px;">
					<input type="color" name="color_number[]" class="color-picker" value="${item.clr_cd}" required>
					<input type="text" name="color_name[]" class="color-name" id="color_name" value="${item.clr_nm}" required>
					 <select name="size_option[]" class="size-select">
			            ${res.size.map(s => 
			                `<option value="${s.cod_cd}" ${s.cod_nm === item.cod_nm ? 'selected' : ''}>${s.cod_nm}</option>`
			            ).join("")}
			        </select>
                    <input type="number" name="stock_number[]" class="stock-number" id="stock_number" value="${item.prd_qt}" placeholder="재고 수량을 입력해주세요." required>
					<button type="button" class="btn btn-sm btn-outline-danger remove-option">삭제</button>
				<div>
				`)

				$('#option-container').prepend(option);
				
				// 카테고리
				let firstCate = res.cate.filter(item => item.lev_cd.length === 10)
				                        .map(item => {
				                            let selected = item.lev_cd === res.prdData.prd_ca.substring(0, 10) ? 'selected' : '';
				                            return `<option value="${item.lev_cd}" ${selected}>${item.lev_nm}</option>`;
				                        }).join('');
				$('#product_category').append(firstCate);
				
				let secondCate = res.cate.filter(item => item.lev_cd.length === 12)
				                         .map(item => {
				                             let view = item.lev_cd.substring(0, 10) === $('#product_category').val() ? 'show' : 'hide';
				                             return `<option value="${item.lev_cd}" class="${view}">${item.lev_nm}</option>`;
				                         }).join('');
				$('#product_category_sub').append(secondCate);
				$('#product_category_sub option.hide').hide();
				$('#product_category_sub').val(res.prdData.prd_ca);

                loadSizeOptions();
				loadBadgeOptions(res.prdData.prd_bd);

            },
            error: function(xhr, status, error) {
                alert("서버 오류가 발생했습니다.");
            }
        });
    });

	$('#option-container').on('click', '.remove-option', function() {
    	let optionRow = $(this).closest('.option-row');
	    let optionId = optionRow.data('value');
	    if (optionId) {
	        deletedOptions.push(optionId);
	    }
	    optionRow.remove();
	});

    // 카테고리 선택
    $('#product_category').on('change', function(){ changeCate(); });

    function changeCate() {
        let selectedValue = $('#product_category').val();
        $('#product_category_sub option').each(function() {
            if ($(this).val().substring(0, 10) === selectedValue) {
                $(this).removeClass('hide').addClass('show').show();
            } else {
                $(this).removeClass('show').addClass('hide').hide();
            }
        });
        $('#product_category_sub').val($('#product_category_sub option.show:first').val());
    }

    function loadSizeOptions() {
        return fetch(contextPath + "/seller/sizeOptions")
            .then(response => response.json())
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
    }

	function loadBadgeOptions(selectBadge) {
    return fetch(contextPath + "/seller/badgeOptions")  // 서버에서 뱃지 옵션을 불러오는 API URL
        .then(response => response.json())
        .then(data => {
            globalBadgeOptions = data;
            console.log("뱃지 옵션 로딩 완료:", globalBadgeOptions);

            const badgeContainer = document.querySelector('.item-regi-price-box');  // 뱃지 옵션을 넣을 컨테이너
            const initialSelect = document.getElementById("product_badge");  // 뱃지 선택을 위한 <select> 요소
            if (initialSelect) {
                populateSizeSelect(initialSelect, globalBadgeOptions);
            }
			$('#product_badge').val(selectBadge);
        })
        .catch(error => {
            console.error("뱃지 옵션 로딩 오류:", error);
            alert("뱃지 옵션 데이터를 불러오지 못했습니다.");
        });
	}

    function populateSizeSelect(selectElement, options) {
        selectElement.innerHTML = '<option value="">선택하세요</option>';
        options.forEach(option => {
            const opt = document.createElement('option');
            opt.value = option.cod_cd;
            opt.textContent = option.cod_nm;
            selectElement.appendChild(opt);
        });
    }

    // 썸네일 미리보기 (이벤트 위임)
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

    // "추가 옵션" 버튼 클릭 시 옵션 추가
    $(document).on('click', '#add-option', function() {
        const container = $('#option-container');
        const optionRow = $('<div>', { class: 'option-row', style: 'display: flex; align-items: center; gap: 10px; margin-bottom: 10px;' });

        const newColorInput = $('<input>', { type: 'color', name: 'color_number[]', class: 'color-picker' });
        const newColorText = $('<input>', { type: 'text', name: 'color_name[]', class: 'color-name' });
        const newSizeSelect = $('<select>', { name: 'size_option[]', class: 'size-select' }).append(globalSizeOptions.map(option => 
            `<option value="${option.cod_cd}">${option.cod_nm}</option>`).join(""));
        const newStockInput = $('<input>', { type: 'number', name: 'stock_number[]', class: 'stock-number', placeholder: '재고 수량 입력' });
        const removeBtn = $('<button>', { type: 'button', class: 'btn btn-sm btn-outline-danger' }).text('삭제').on('click', function() {
		    optionRow.remove();
        });




        optionRow.append(newColorInput, newColorText, newSizeSelect, newStockInput, removeBtn);
        container.append(optionRow);
    });

    // 8. TOAST UI Editor 초기화
  const { colorSyntax } = toastui.Editor.plugin;
  prdeditor = new toastui.Editor({
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



	// 글자 수(제목)
	function updateByteCount(inputSelector, countSelector, maxLength, alertMsg) {
	    // 페이지 로드 시 초기 값에 대한 글자 수 업데이트
	    const initialContent = $(inputSelector).val();
	    $(countSelector).text(`(${initialContent.length} / ${maxLength})`);
	
	    $(inputSelector).on('input', function () {  // 'input' 이벤트로 변경
	        const content = $(this).val();
	        $(countSelector).text(`(${content.length} / ${maxLength})`);
	        
	        if (content.length > maxLength) {
	            alert(alertMsg);
	            $(this).val(content.substring(0, maxLength));
	            $(countSelector).text(`(${maxLength} / ${maxLength})`);
	        }
	    });
	}
	
	// 제목과 코드 입력 필드의 글자 수 처리
	updateByteCount("#item-regi-title-text", "#item-regi-name-byte", 100, "최대 100자까지 입력 가능합니다.");
	updateByteCount("#item-regi-code-text", "#item-regi-code-byte", 50, "최대 50자까지 입력 가능합니다.");



	
});

// 상품 수정
function productUpdate() {
	
	let formData = new FormData();
	
	// 상품명, 코드, 카테1, 카테2, 배송비, 옵션 가격, 판매 가격, 상품설명, 뱃지
	formData.append('prd_nm', $('#item-regi-title-text').val());
	formData.append('prd_cd', $('#item-regi-code-text').val());
	formData.append('prd_ct', prdeditor.getHTML());
	formData.append('prd_ca', $('#product_category_sub').val());
	formData.append('prd_sf', $('#delivery_price').val());
	formData.append('prd_op', $('#list_price').val());
	formData.append('prd_sp', $('#sale_price').val());
	formData.append('prd_bd', $('#product_badge').val());
	formData.append('opt_id_del', deletedOptions);
	
	// 이미지
    $('.item-thumb-upload-btn').each(function(index) {
        let input = $(this)[0];
        let file = input.files[0];

        if (file) {  // 파일이 존재하면 무조건 추가
            formData.append('updateFiles', file);
            formData.append('imageIndexes', index + 1);
        }
    });

	// 옵션
	$('.option-row').each(function() {
		let optionId = $(this).data('value');	// 옵션 아이디
	    let colorNumber = $(this).find('.color-picker').val(); // 색상 코드
	    let colorName = $(this).find('.color-name').val(); // 색상 이름
	    let sizeOption = $(this).find('.size-select').val(); // 사이즈 선택
	    let stockNumber = $(this).find('.stock-number').val(); // 재고 수량

	    // FormData에 옵션 추가
		formData.append('opt_id', optionId);
	    formData.append('color_number', colorNumber);
	    formData.append('color_name', colorName);
	    formData.append('size_option', sizeOption);
	    formData.append('stock_number', stockNumber);
	});

    $.ajax({
        url: 'productUpdate',
        type: 'POST',
        data: formData,
        contentType: false,
        processData: false,
        success: function(response) {
            alert('상품 정보가 업데이트되었습니다.');
			window.location.href="selProductList";
        },
        error: function(xhr, status, error) {
            alert('상품 정보 업데이트 중 오류가 발생했습니다.');
        }
    });
	
}

// 상품 삭제
function productDelete() {
	let data = { prd_cd : $('#item-regi-code-text').val()}
	
	if(confirm('상품을 삭제하시겠습니까?')){
		$.ajax({
			url: 'productDelete',
			type: 'POST',
			data: JSON.stringify(data),
			contentType: "application/json",
			success: function() {
				alert('상품 삭제가 완료되었습니다.');
				window.location.href = "selProductList";
			},
			error: function(xhr, status, error) {
	            alert('상품 삭제중 오류가 발생했습니다.');
	        }
			
		});
	}
}



