$(function () {

		$.ajax({
		    type: 'POST',
		    url: 'sideMenu',
			data: {menu : "ADMCODE"},
		    success: function(menu) {
			
				generateSidebarMenu(menu);
		    },
		    error: function(xhr, status, error) {
		        console.error("AJAX error:", error);
		        alert("데이터를 불러오는데 실패했습니다.");
		    }
		});
		
		
		
		
	function generateSidebarMenu(menuData) {
	    let menuContainer = $("#menu");
	    menuContainer.empty();
	
	    menuData.forEach(menu => {
	        let menuItem = $('<li class="menu-item"></li>');
	        let menuTitle = $('<a href="#" class="menu-title"></a>').text(menu.name);
	
	        let subMenu = $('<ul class="submenu"></ul>');
	        if (menu.subCodes) {
	            menu.subCodes.forEach(sub => {
	                let subItem = $('<li></li>');
	                let subLink = $('<a></a>').attr("href", sub.url).text(sub.name);
	                subItem.append(subLink);
	                subMenu.append(subItem);
	            });
	        }
	
	        menuItem.append(menuTitle);
	        if (subMenu.children().length > 0) {
	            menuItem.append(subMenu);
	        }
	        menuContainer.append(menuItem);
	
	        menuTitle.on("click", function (e) {
	            e.preventDefault();
	            subMenu.slideToggle();
	        });
	    });
	}
	
	document.addEventListener("DOMContentLoaded", function () {
    const menuTitles = document.querySelectorAll(".menu-title");

    menuTitles.forEach(title => {
        title.addEventListener("click", function (event) {
            event.preventDefault(); // 링크 이동 방지
            const submenu = this.nextElementSibling;
            submenu.classList.toggle("open");
        });
    });
});

// 	console.log("현재 페이지 주소: " + window.location.pathname);

	document.addEventListener("DOMContentLoaded", function(){
		// 현재 페이지에 해당하는 메뉴 활성화
		let pathName = window.location.pathname.substring(1);
		let collapseItems = document.querySelectorAll(".collapse-item");
		
		collapseItems.forEach((item) => {
			item.classList.remove("active");
			
			if (pathName == item.getAttribute('href') || pathName == item.getAttribute('data-sub-page') || pathName == item.getAttribute('data-sub-page2')) {
				item.classList.add("active");
				item.parentElement.parentElement.classList.add("show");
				item.parentElement.parentElement.parentElement.classList.add("active");
			}
			
		});
	});
		
		
		
//	document.addEventListener("DOMContentLoaded", function () {
//    	const menuTitles = document.querySelectorAll(".menu-title");
//
//        menuTitles.forEach(title => {
//            title.addEventListener("click", function (event) {
//                event.preventDefault(); // 링크 이동 방지
//                const submenu = this.nextElementSibling;
//                submenu.classList.toggle("open");
//            });
//        });
//    });
});