$(function () {
	
		
	// 메인 출력
	$.ajax({
		type:"GET",
		url:"mainPrint",
		success: function(res){
//			 방문자 수 출력
//			visitCnt = res.visCnt?.vis_ct ?? 0;
			if (res.visCnt && res.visCnt.vis_ct !== undefined) {
			    visitCnt = res.visCnt.vis_ct;
			}
			
			$('#visit-date').append(new Date().toLocaleDateString('en-CA'));
			$('#visit-count').append(visitCnt + '명');
			//
			
			// 최근가입 출력
			let joinInfo = res.joinList.map(item => `<tr>
													 <td>${item.buy_st}</td>
										 			 <td>${item.buy_nm}</td>
										  			 <td>${item.buy_em}</td>
										  			 <td>${item.buy_at}</td>
												 </tr>`)
								   .join('');
			$('.join-tbody').append(joinInfo);
			//
			
			// 신고내역 출력
			
			let reportInfo = res.reportList.map(item =>`<tr>
													 	<td>${item.rpt_tg}</td>
										 			 	<td>${item.rpt_tg === '구매자' ? '❗' : ''}${item.buy_em}</td>
										  			 	<td>${item.rpt_tg === '판매자' ? '❗' : ''}${item.sel_id}</td>
													 	<td>${item.rpt_dt}</td>
													 	<td>${item.rpt_st}</td>
												 		</tr>`)
								   		   .join('');
			$('.report-tbody').append(reportInfo);
			//
		},
		error : function(xhr, textStatus,errorThrown){
			alert("ajax구문 오류");
		}
	});
		
});