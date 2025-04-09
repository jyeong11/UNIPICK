$(function() {
	firstCategory();
	
	$('.second-info').on('click', '.second-cate, .all-cate', function() {
	    let cateName = $(this).text();
    	let cateCode = $(this).data('value');
	    window.location.href = "productList?lev_cd=" + encodeURIComponent(cateCode) 
							   + "&category=" + encodeURIComponent(cateName);
	});

	$('.first-info').on('click', 'li', function() {
    let categoryName = $(this).text();  // 클릭된 첫 번째 카테고리 이름
    let clickedItem = $(this); // 클릭된 li 항목

    // 클릭된 항목의 배경색 변경
    $('.first-info li').css('background-color', ''); // 모든 항목의 배경색 초기화
    clickedItem.css('background-color', '#f2a900'); // 클릭된 항목에 배경색 변경

    let targetItem = $('.second-info li').filter(function() {
        return $(this).text() === categoryName;  // 이름이 일치하는 li 찾기
    });

    // 해당 항목이 있을 경우 해당 항목으로 스크롤 이동
    if (targetItem.length) {
        var targetTop = targetItem.offset().top; // 목표 항목의 top 위치
        var windowHeight = $(window).height();
        var windowCenter = $(window).scrollTop() + windowHeight / 2; // 화면 중앙의 위치

        // 목표 항목이 중앙보다 살짝 위로 오면 그 위치로 스크롤 이동
        if (targetTop <= windowCenter) {
            $('html, body').animate({
                scrollTop: targetTop - windowHeight / 3  // 살짝 위로 올라가도록 이동
            }, 500); // 500ms 동안 부드럽게 스크롤 이동
        } else {
            $('html, body').animate({
                scrollTop: targetTop - windowHeight / 3  // 살짝 위로 올라가도록 이동
            }, 500); // 500ms 동안 부드럽게 스크롤 이동
        }
    }
})

$(window).on('scroll', function() {
    // 화면 중앙보다 살짝 위로 올라왔을 때 체크
    var windowHeight = $(window).height();
    var windowCenter = $(window).scrollTop() + windowHeight / 2; // 화면 중앙의 위치

    $('.first-cate').each(function() {
      var elementTop = $(this).offset().top; // 현재 .first-cate 요소의 top 위치

      // 화면 중앙보다 살짝 위로 올라왔을 때
      if (elementTop <= windowCenter) {
        var categoryText = $(this).text().trim(); // 해당 .first-cate의 텍스트 값

        // .first-info 안의 li를 찾아 텍스트 값이 일치하면 배경색 변경
        $('.first-info li').each(function() {
          if ($(this).text().trim() === categoryText) {
            $(this).css('background-color', '#f2a900'); // 배경색을 검은색으로 변경
          } else {
            $(this).css('background-color', ''); // 배경색 초기화
          }
        });
      }
    });
  });

	function firstCategory() {
		$.ajax({
			type: "GET",
	        url: "firstCategory",
	        success: function(res) {
				
				let firstCate = res.filter(item => item.lev_cd.length === 10) // CATEGORYXX 형식만 필터링
		            			   .map(item => `<li>${item.lev_nm}</li>`)
								   .join('');

        		$('.first-info').append(firstCate); // 한 번에 추가
								
				let secondCate = res.map(item => {
					if (item.lev_cd.length === 10) {
						return `<li data-value="${item.lev_cd}" class="first-cate">${item.lev_nm}</li>`;
					} else {
						return `<li><div class="second-cate" data-value="${item.lev_cd}">${item.lev_nm}</div></li>`;
					}
					}).join('');
								
				$('.second-info').append(secondCate); // 한 번에 추가
			},
	        error: function(xhr, status, error) {
            	alert("서버 오류가 발생했습니다.");
	        }
		});
	}
});