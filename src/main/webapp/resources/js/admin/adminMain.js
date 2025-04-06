$(function () {
	
		
	// 메인 출력
	$.ajax({
		type:"GET",
		url:"mainPrint",
		success: function(res){
//			 방문자 수 출력
			if (res.visCnt && res.visCnt.vis_ct !== undefined) {
			    visitCnt = res.visCnt.vis_ct;
			}
			
			$('#visit-date').append(new Date().toLocaleDateString('en-CA'));
			$('#visit-count').append(visitCnt + '명');
			//
			
			// 최근가입 출력
			let joinInfo = res.joinList.map(item => {const date = new Date(item.buy_at).toLocaleString();
										return `<tr>
													 <td>${item.buy_st}</td>
										 			 <td>${item.buy_nm}</td>
										  			 <td>${item.buy_em}</td>
										  			 <td>${date}</td>
												 </tr>`})
								   .join('');
			$('.join-tbody').append(joinInfo);
			//
			
			// 신고내역 출력
			
			let reportInfo = res.reportList.map(item =>{ const date = new Date(item.rpt_dt).toLocaleString();
												return `<tr>
											 			 	<td>${item.rpr_id}</td>
											  			 	<td>${item.rpd_id}</td>
															<td>${item.rpt_tg}</td>
														 	<td>${date}</td>
														 	<td>${item.cod_nm}</td>
												 		</tr>`})
								   		   .join('');
			$('.report-tbody').append(reportInfo);
			//
		},
		error : function(xhr, textStatus,errorThrown){
			alert("ajax구문 오류");
		}
	});
		
});