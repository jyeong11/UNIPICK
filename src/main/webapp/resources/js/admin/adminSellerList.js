$(function() {
	sellerList();
	
	$('#noticeSearch').on('click',function(){
		sellerList();
	}); 
	$('#noticeSearchWord').on('keydown', function(event){	
		if (event.key === "Enter"){
			$('#noticeSearch').click();

		}
	});
	
	function sellerList() {
		let data = {};
		
		let kindElement = document.getElementById('noticeSearchKind');
		let wordElement = document.getElementById('noticeSearchWord');
		
		let kind = kindElement ? kindElement.value : null;
		let word = wordElement ? wordElement.value : null;
		
		data[kind] = word;
		
		$.ajax({
		url: "getSellerInfo",
		method: "POST",
		data: data,
		success: function (res) {
			let tableBody = $("#sellerListTable");
            tableBody.empty();
			
			let totalCount = res.length;
			
            res.forEach((sel, index) => {
				let rowNumber = totalCount - index;
                let row = `
                    <tr>
						<td>
                        	<a href="adminSellerDetail?sel_nm=${sel.sel_nm}">${rowNumber}</a>
                        </td>
						<td>${sel.sel_id}</td>
                        <td>${sel.sel_nm}</td>
                        <td>${sel.sel_mn}</td>
                        <td>${sel.sel_cs}</td>
                    </tr>
                `;
                tableBody.append(row);
            });
		},
		error: function () {
                alert("상품을 불러오는 데 실패했습니다.");
        }
		
	});
	}
});
