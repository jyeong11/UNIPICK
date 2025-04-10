$(function () {
	// 신규 주문
	newOrdCount();
	// 이번달 월 매출액
	revenue();	
});

// 신규 주문
function newOrdCount() {
	$.ajax({
		url: "newOrdCount",
		method: "POST",
		success: function(res){
			$("#totalProduct").text(res);
		},	
		error: function (xhr, textStatus, errorThrown) {
            alert("다시 접속해주세요.");
        }
	});	
}
// 이번달 매출액
function revenue() {
	$.ajax({
		url: "Revenue",
		method: "POST",
		success: function(res){
			$("#totalUsers").text(res.acc + "원");
		},	
		error: function (xhr, textStatus, errorThrown) {
            alert("다시 접속해주세요.");
        }
	});	
}