$(function() {
	let query = window.location.search;
    let param = new URLSearchParams(query);
	let data = {prd_cd : param.get('prd_cd'),
				odd_id : param.get('odd_id')};
				
	let opt_id = '';
	let rev_rt = '';

	// 평점
	$(document).on('click', '.star', function() {
        rev_rt = $(this).data('value');
        const stars = $('.star');

        stars.removeClass('selected');

        for (let i = 0; i < rev_rt; i++) {
            $(stars[i]).addClass('selected');
        }
    });

	// 글자수
	$('#reviewDetail').on('input', function() {

		if ($('#reviewDetail').val().length >= 500) {
            $('#reviewDetail').val($('#reviewDetail').val().substring(0, 500));
        }

		$('#charCount').text($('#reviewDetail').val().length);
		 
	});
	
	
	$(".item-thumb-upload").on("click", function() {
        var index = $(this).data("index");
        $("#item-thumb-upload-btn" + index).click();
    });
    
    // 파일 업로드 후, 미리보기 이미지 표시
    $("input[type='file']").on("change", function() {
        var index = $(this).attr("id").replace("item-thumb-upload-btn", "");
        var file = this.files[0];
        if (file) {
            var reader = new FileReader();
            reader.onload = function(e) {
                $("#item-thumb-preview" + index).attr("src", e.target.result);
            }
            reader.readAsDataURL(file);
        }
    });

	$('#registerReview').on("click", function() {
		registerReview();
	});
	
	
	$.ajax({
			url: "prdInfo",
			method: "POST",
			data: JSON.stringify(data),
			contentType: "application/json",
			success: function(res) {
				opt_id = res.opt_id;
				const contextPath = window.location.pathname.substring(0, window.location.pathname.indexOf("/", 2));
				let prdData = `
							       <img src="${contextPath}${res.fil_pt}" id="prdImg">
								   <div>
									   <div id="options">
								           <p id="prdNm">${res.prd_nm}</p>
									       <p>${res.clr_nm} / ${res.cod_nm} / ${res.odd_qt}개</p>
									   </div>
									   <div class="stars">
								           <span class="star" data-value="1">★</span>
								           <span class="star" data-value="2">★</span>
								           <span class="star" data-value="3">★</span>
								           <span class="star" data-value="4">★</span>
								           <span class="star" data-value="5">★</span>
								       </div>
								   </div>
							   `;
				
				$('#content-top').prepend(prdData);
        	},
			error: function(xhr, status, error) {
	        	alert("서버 오류가 발생했습니다.");
	        }
		});

		function registerReview() {
			let formData = new FormData();
			
			formData.append("opt_id", opt_id);
			formData.append("rev_rt", rev_rt);
			formData.append("rev_ct", $('#reviewDetail').val());
			
			$(".item-thumb-upload-btn").each(function(index, input) {
				if(input.files.length > 0) {
					formData.append("imageFiles", input.files[0]);
				}
			});
			$.ajax({
				url: "registerReview",
				method: "POST",
				data: formData,
				processData: false,
				contentType: false,
				success: function(res) {
					alert("리뷰가 성공적으로 등록되었습니다.");
					window.location.href="myReviewList";
				},
				error: function(xhr, status, error) {
					alert("서버 오류가 발생했습니다.");
				}
				
				
			});
			
			
			
			
			
			
			
			
			
		}
});