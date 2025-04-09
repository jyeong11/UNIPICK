$(function() {
	$.ajax({
		url: "buyerSellerStore",
		method: "POST",
		success: function(res){
			let content = '';

			    res.forEach(function(item) {
			        let profile = item.sel_pp ? item.sel_pp : '/resources/sellerStore/default_profile.png';
			
			        content += `
						<a href="sellerShopDetail?sel_nm=${item.sel_nm}" class="seller-link">
						    <div class="seller-card">
						        <img src="${contextPath}${profile}" alt="${item.sel_nm} 프로필 이미지" class="profile">
						        <div class="info">
						            <h3 class="shop-name">${item.sel_nm}</h3>
						            <p class="shop-info">${item.sel_if}</p>
						        </div>
						    </div>
						</a>
					`;
			    });
			
			    $('#content').html(content);
		},
		error: function(xhr, status, error) {
        	alert("서버 오류가 발생했습니다.");
        }
	});
});
