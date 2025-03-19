$(function () {
	
		
	// 방문자 수 출력
	$.ajax({
			type:"GET",
			url:"visitCount",
			success: function(res){
				visitCnt = res.vis_ct == null ? 0 : res.vis_ct
				
				$('#visit-date').append(new Date().toLocaleDateString('en-CA'));
				$('#visit-count').append(visitCnt + '명');
			},
			error : function(xhr, textStatus,errorThrown){
				alert("ajax구문 오류");
			}
		});
});