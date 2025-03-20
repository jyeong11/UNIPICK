$(function(){
	
	let query = window.location.search;
	let param = new URLSearchParams(query);
	let prd_cd = param.get('prd_cd');
	
	$(document).ready(function() {
		$.ajax({
			type: "POST",
			url: "productDetail",
			data: JSON.stringify({prd_cd : prd_cd}),
			contentType: "application/json",
			success: function(res) {
				$('#item-regi-title-text').val(res.prdData.prd_nm);
				$('#item-regi-code-text').val(res.prdData.prd_cd);
				$('#list_price').val(res.prdData.prd_op);
				$('#sale_price').val(res.prdData.prd_sp);
				
				// 카테고리
				let firstCate = res.cate.filter(item => item.lev_cd.length === 10) // CATEGORYXX 형식만 필터링
		            			   .map(item => {
													let selected = item.lev_cd === res.prdData.prd_ca.substring(0, 10) ? 'selected' : '';
													return `<option value="${item.lev_cd}" ${selected}>${item.lev_nm}</option>`})
								   .join('');
				$('#product_category').append(firstCate);
				
				let secondCate = res.cate.filter(item => item.lev_cd.length === 12)
										 .map(item => {
														let view = item.lev_cd.substring(0,10) === $('#product_category').val() ? 'show' : 'hide';
														return `<option value="${item.lev_cd}" class="${view}">${item.lev_nm}</option>`})
										 .join('');
				$('#product_category_sub').append(secondCate);
				$('#product_category_sub option.hide').hide();
				$('#product_category_sub').val(res.prdData.prd_ca);
				
			},
			error: function(xhr, status, error) {
				alert("서버 오류가 발생했습니다.");
			}
			
		});
	});
	
	$('#product_category').on('change',function(){changeCate()});
	
	function changeCate() {
		let selectedValue = $('#product_category').val(); // 선택된 1번 카테고리 값 가져오기

	    $('#product_category_sub option').each(function() {
	        // 2번 카테고리의 value 앞 10자리가 1번 카테고리 값과 같은지 비교
	        if ($(this).val().substring(0, 10) === selectedValue) {
	            $(this).removeClass('hide').addClass('show').show(); // 보이게 처리
	        } else {
	            $(this).removeClass('show').addClass('hide').hide(); // 숨기기
	        }
	    });
		$('#product_category_sub').val($('#product_category_sub option.show:first').val());
	}
	
	// 토스트 UI
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