$(function () {
	
		
	// 방문자 수 출력
	$.ajax({
		type:"GET",
		url:"mainPrint",
		success: function(res){
			// 방문자 수 출력
			visitCnt = res.visCnt.vis_ct == null ? 0 : res.visCnt.vis_ct
			
			$('#visit-date').append(new Date().toLocaleDateString('en-CA'));
			$('#visit-count').append(visitCnt + '명');
			//
			
			// 최근가입 출력
			
			let info = res.joinList.map(item => `<tr>
													 <td>${item.buy_em}</td>
										 			 <td>${item.buy_nm}</td>
										  			 <td>${item.buy_st}</td>
										  			 <td>${item.buy_at}</td>
												 </tr>`)
								   .join('');
			$('.tbody').append(info);
		},
		error : function(xhr, textStatus,errorThrown){
			alert("ajax구문 오류");
		}
	});
		
});





//<th class="sorting_disabled dt-center" rowspan="1" colspan="1">판매자</th>