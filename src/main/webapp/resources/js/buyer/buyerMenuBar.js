$(function() {
	$(document).ready(function(){
		$.ajax({
			url: "menu",
			method: "GET",
			dataType: "json",
			success: function(menudata) {
	            const menuContainer = $("#top_menu .menu-nav");
	
	            menudata.forEach(data => {
	                const menuItem = $("<li></li>").addClass("menu-inner");
	                const link = $("<a></a>")
	                    .attr("href", data.lev_ul)
	                    .attr("data-code", data.lev_cd)
	                    .append($("<span>").text(data.lev_nm));
	
	                menuItem.append(link);
	                menuContainer.append(menuItem);
	            });
        	},
		});
	});
});