$(function() {
	$.ajax({
		url:"cartSelect",
		method: "POST",
		success: function(res) {
			debugger;
			const container = document.querySelector(".product_posting");
			container.innerHTML = "";

			res.forEach(prd => {
				const html = `
					<a href="#">
						<img src="${contextPath}${prd.fil_pt}" alt="${prd.prd_nm}">
						<div>
							<div>${prd.prd_nm}</div>
							<div>${prd.sel_nm}</div>
							<div>${prd.prd_op}</div>
							<div>${prd.prd_sf}</div>
							<div>${prd.clr_nm}</div>
							<div>${prd.cod_nm}</div>
							<div>${prd.crt_qt}</div>
						</div>
					</a>
				`;
				container.insertAdjacentHTML("beforeend", html);
            });
		},
		error: function(xhr, status, error) {
            console.error("리뷰 데이터를 불러오는 데 실패했습니다:", error);
      	}
	});
});