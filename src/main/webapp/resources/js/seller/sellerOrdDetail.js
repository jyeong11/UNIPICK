$(function(){
	let query = window.location.search;
	let param = new URLSearchParams(query);
	let ord_id = param.get('ord_id');
	
	$(document).ready(function() {
		$.ajax({
			url: "sellerOrdDetail",
			method: "POST",
			data: JSON.stringify({ ord_id: ord_id }),
			contentType: "application/json",
			success: function(res){
				res.forEach(function(val) {
			        $('#prd_cd').val(val.prd_cd || '-');
			        $('#prd_nm').val(val.prd_nm || '-');
			        $('#siz_nm').val(val.cod_nm || '-');
			        $('#clr_nm').val(val.clr_nm || '-');
			        $('#odd_qt').val(val.odd_qt || '-');
			        $('#buy_em').val(val.buy_em || '-');
			        $('#buy_nm').val(val.buy_nm || '-');
			        $('#buy_ph').val(val.buy_ph || '-');
					$('#rec_nm').val(val.ord_nm || '-');
					$('#rec_ph').val(val.ord_ph || '-');
			        $('#address').val(val.ord_ad || '-');
			        $('#delivery_note').val(val.ord_dm || '-');
			        $('#odd_am').val(val.odd_am || '-');
			        $('#payment').val(val.ord_pm || '-');
		    	});
			},
			error: function(xhr, status, error) {
				alert("다시 시도해주세요.");
			}
		});
	});
});