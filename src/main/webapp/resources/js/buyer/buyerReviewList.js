$(function() {
    search($(this).find('input'));

    $('.search-radio').on('change', function() {
        search($(this).find('input'));
    });

    function search(option) {
		let selectValue = option.val();
		let today = new Date(); // 현재 날짜
		let dateString = "";
		
		if(selectValue != 'option3'){
			let num = 12;
			if(selectValue == 'option1'){
				num = 3;
			}
			today.setMonth(today.getMonth() - num);
			
			let year = today.getFullYear();
			let month = ('0' + (today.getMonth() + 1)).slice(-2);
			let day = ('0' + today.getDate()).slice(-2);
			
			dateString = year + '-' + month  + '-' + day;
		}
		
		let data = {
			date : dateString,
		};


        $.ajax({
            url: "reviewData",
            method: "POST",
            data: JSON.stringify(data),
            contentType: "application/json",
            success: function(res) {
				$('#cards').empty();
                let card = res.data.map(item => { 
                    let starValue = item.rev_rt;
                    let star = '';
                    for (let i = 1; i <= 5; i++) {
                        if (i <= starValue) {
                            star += `<span class="star filled" data-value="${i}">★</span>`;
                        } else {
                            star += `<span class="star empty" data-value="${i}">★</span>`;
                        }
                    }
                    const date = new Date(item.rev_ca).toLocaleString();
                    return `<div class="card">
                        <div class="card-body">
                            <div class="top">
                                <div class="nick">${item.buy_nn}</div>
                                <div class="date">${date}</div>
                            </div>
                            <div class="stars">
                                <span>${star}</span>
                            </div>
                            <div class="prdName">${item.prd_nm}</div>
                            <div class="reviewImg" id="${item.rev_id}"></div>
                            <div class="options">${item.cod_nm} / ${item.clr_nm}</div>
                            <div class="bodySize">${item.buy_ht}cm / ${item.buy_wt}kg</div>
                            <div class="reivewCon">${item.rev_ct}</div>
                        </div>
                    </div>`;
                }).join('');
                
                $('#cards').append(card);
                
                const contextPath = window.location.pathname.substring(0, window.location.pathname.indexOf("/", 2));
                
                res.image.forEach(item => {
                    let img = `<img src="${contextPath}${item.rei_pt}" class="review-img">`;
                    $(`#${item.rev_id}`).append(img);
                });
            }
        });
    }
});