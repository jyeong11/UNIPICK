$(function(){
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
                let imgContainer = $(".item-thumb-group");
                imgContainer.empty(); // 기존 이미지 박스 초기화

                // productImages가 존재하는지 확인
                if (res.productImages && Array.isArray(res.productImages)) {
                    // 받은 이미지를 처리
                    for (let i = 0; i < 10; i++) {
                        let imgUrl = res.productImages[i] || '/resources/img/product-thumb-no.jpg'; // 이미지가 없으면 기본 이미지 사용
                        let thumbHtml = `
                            <div class="item-thumb">
                                <button type="button" class="item-thumb-upload" data-index="${i}">
                                    <img src="${imgUrl}" id="item-thumb-preview${i}">
                                </button>
                                <input type="file" class="item-thumb-upload-btn" id="item-thumb-upload-btn${i}" name="productData">
                            </div>
                        `;
                        imgContainer.append(thumbHtml); // 새로운 이미지 요소 추가
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
                        imgContainer.append(thumbHtml);
                    }
                }

                // 상품
                $('#item-regi-title-text').val(res.prdData.prd_nm);
                $('#item-regi-code-text').val(res.prdData.prd_cd);
                $('#list_price').val(res.prdData.prd_op);
                $('#sale_price').val(res.prdData.prd_sp);
                $('#delivery_price').val(res.prdData.prd_sf);
                
                let firstCate = res.cate.filter(item => item.lev_cd.length === 10)
                                        .map(item => {
                                            let selected = item.lev_cd === res.prdData.prd_ca.substring(0, 10) ? 'selected' : '';
                                            return `<option value="${item.lev_cd}" ${selected}>${item.lev_nm}</option>`;
                                        }).join('');
                $('#product_category').append(firstCate);
                
                let secondCate = res.cate.filter(item => item.lev_cd.length === 12)
                                         .map(item => {
                                             let view = item.lev_cd.substring(0,10) === $('#product_category').val() ? 'show' : 'hide';
                                             return `<option value="${item.lev_cd}" class="${view}">${item.lev_nm}</option>`;
                                         }).join('');
                $('#product_category_sub').append(secondCate);
                $('#product_category_sub option.hide').hide();
                $('#product_category_sub').val(res.prdData.prd_ca);
            },
            error: function(xhr, status, error) {
                alert("서버 오류가 발생했습니다.");
            }
        });
        loadSizeOptions();
    });

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

    function populateSizeSelect(selectElement, options) {
        selectElement.innerHTML = '<option value="">선택하세요</option>';
        options.forEach(option => {
            const opt = document.createElement('option');
            opt.value = option.cod_cd;
            opt.textContent = option.cod_nm;
            selectElement.appendChild(opt);
        });
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

    document.addEventListener("DOMContentLoaded", function () {
        document.getElementById("add-option").addEventListener("click", function () {
            const container = document.getElementById("option-container");
            const optionRow = document.createElement("div");
            optionRow.className = "option-row";
            optionRow.style.display = "flex";
            optionRow.style.alignItems = "center";
            optionRow.style.gap = "10px";
            optionRow.style.marginBottom = "10px";

            const newColorInput = document.createElement("input");
            newColorInput.type = "color";
            newColorInput.name = "color_number[]";
            newColorInput.className = "color-picker";

            const newColorText = document.createElement("input");
            newColorText.type = "text";
            newColorText.name = "color_name[]";
            newColorText.className = "color-name";

            const newSizeSelect = document.createElement("select");
            newSizeSelect.name = "size_option[]";
            newSizeSelect.className = "size-select";
            populateSizeSelect(newSizeSelect, globalSizeOptions);

            const newStockInput = document.createElement("input");
            newStockInput.type = "number";
            newStockInput.name = "stock_number[]";
            newStockInput.className = "stock-number";
            newStockInput.placeholder = "재고 수량 입력";

            const removeBtn = document.createElement("button");
            removeBtn.type = "button";
            removeBtn.textContent = "삭제";
            removeBtn.className = "btn btn-sm btn-outline-danger";
            removeBtn.addEventListener("click", function () {
                optionRow.remove();
            });

            optionRow.appendChild(newColorInput);
            optionRow.appendChild(newColorText);
            optionRow.appendChild(newSizeSelect);
            optionRow.appendChild(newStockInput);
            optionRow.appendChild(removeBtn);
            container.appendChild(optionRow);
        });
    });

    // 토스트 UI 추가
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
});
