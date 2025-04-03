$(function() {
	let query = window.location.search;
	let param = new URLSearchParams(query);
	let sel_nm = param.get('sel_nm');
	
	$.ajax({
		url: "getSellerInfoDeatil",
		method: "POST",
		data: {sel_nm: sel_nm}, 
		success: function (res) {
			let data = res[0];

	        $("#sel_id").val(data.sel_id);
	        $("#sel_nm").val(data.sel_nm);
	        $("#sel_rn").val(data.sel_rn);
	        $("#sel_mn").val(data.sel_mn);
	        $("#sel_mp").val(data.sel_mp);
	        $("#sel_cs").val(data.sel_cs);
	        $("#sel_br").val(data.sel_br);
	        $("#sel_ad").val(data.sel_ad);
	        $("#sel_st").val(data.cod_nm).prop("selected", true);
			
		},
		error: function () {
                alert("상품을 불러오는 데 실패했습니다.");
        }
	});
	$("#updateBtn").click(function () {
    	let targetId = $(this).data("id");
	
	});
});
