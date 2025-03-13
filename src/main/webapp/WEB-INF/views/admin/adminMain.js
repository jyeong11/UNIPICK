$(function () {
	
	$('#admin_id').on('click',function(){
		let id = document.querySelector('#admin_id').text
		adminMyPage(id);
	}); // att 검색 이벤트
	
	
	function adminMyPage(id) {
		
		let data = {};
		
		data.admId = id;
		
		$.ajax({
			type:"GET",
			url:"admin/adminInfo",
			data: data,
			success: function(res){
				$(".main_container").empty();
			},
			error : function(xhr, textStatus,errorThrown){
				alert("ajax구문 오류");
			}
		});
	}
	
});