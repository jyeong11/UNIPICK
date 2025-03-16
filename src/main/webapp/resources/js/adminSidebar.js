$(function () {

		$.ajax({
		    type: 'POST',
		    url: 'sideMenu',
			data: {menu : "ADMCODE"},
		    success: function(menu) {
			
				$(".menu").empty();
				
				menu.main.forEach(function(m){
				
				let row = 
				`<li class="menu-item">
		            <a href="#" class="menu-title">${m.lev_nm}</a>
		            <ul class="submenu">
		                <li><a href="commonCode">${res.lev_nm}</a></li>
		                <li><a href="commonCodeDetail">상세공통코드</a></li>
		                <li><a href="commonCodeLevel">계층공통코드</a></li>
		            </ul>
	        	</li>`
	
				$(".menu").append(row);
				});
		    },
		    error: function(xhr, status, error) {
		        console.error("AJAX error:", error);
		        alert("데이터를 불러오는데 실패했습니다.");
		    }
		});
});