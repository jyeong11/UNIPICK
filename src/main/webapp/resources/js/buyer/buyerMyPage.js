$(function() {
	
	$('.myPageIcon').on('click', 'li', function() {
		 window.location.href = $(this).data('value'); 
	});
	
	$('#modify').on('click', function() {
		 window.location.href = "modify";
	});
	
	$('#logout').on('click', function() {
		 window.location.href = "logout";
	});
	
	$.ajax({
			url: "myPageData",
			method: "GET",
			success: function(res) {
				const classMap = {
		            "MyPage01": "fa-truck",
		            "MyPage02": "fa-ticket",
		            "MyPage03": "fa-coins",
		            "MyPage04": "fa-comment-dots",
		            "MyPage05": "fa-box-open",
					"MyPage06": "fa-headset",
					"MyPage07": "fa-heart"
		        };
				
				let icon = res.myIcon.map(item => {
													let className = classMap[item.lev_cd];
										            return `<li data-value="${item.lev_ul}"><i class="fa-solid ${className}"></i>&nbsp;${item.lev_nm}</li>`;
										        })
									.join('');
								
				$('.myPageIcon').append(icon);
				$('.nickName').append("\"" + res.buyer.buy_nn + "\"님 유니픽에 오신걸 환영합니다.");
				
        	},
			error: function(xhr, status, error) {
	        	alert("서버 오류가 발생했습니다.");
	        }
		});
	
	
});