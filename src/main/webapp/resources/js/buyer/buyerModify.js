$(function() {
	
	let gen = "";
	
	$('.female').on('click', function(){
		$(this).removeClass("gray");
    	$('.male').addClass("gray");
		gen = "여";
	});
	$('.male').on('click', function(){
		$(this).removeClass("gray");
    	$('.female').addClass("gray");
		gen = "남";
	});
	$('#DeleteAccount').on('click', function(){
		alert("탈퇴할꺼얌");
	});
	
	$('#modify').on('click', function() {
		modify();
	})
	
	$.ajax({
			url: "buyerInfo",
			method: "GET",
			success: function(res) {
				gen = res.buy_gn
				gender = gen === "남" ? '.female' : '.male';
				$('#email').append(res.buy_em);
				$('#name').val(res.buy_nm);
				$('#nickname').val(res.buy_nn);
				$('#phoneNumber').val(res.buy_ph);
				$('#birthDate').val(res.buy_bd);
				$(gender).addClass('gray');
				
				if(res.buy_ht){
					$('#heightSize').val(res.buy_ht);
				}
				if(res.buy_wt){
					$('#weightSize').val(res.buy_wt);
				}
				
				
        	},
			error: function(xhr, status, error) {
	        	alert("서버 오류가 발생했습니다.");
	        }
		});
		
	
	function modify() { 
		
		data = {
			buy_em : $('#email').text(),
			buy_nm : $('#name').val(),
			buy_nn : $('#nickname').val(),
			buy_pw : $('#password').val(),
			buy_ph : $('#phoneNumber').val(),
			buy_bd : $('#birthDate').val(),
			buy_gn : gen,
			buy_ht : $('#heightSize').val(),
			buy_wt : $('#weightSize').val(),
			acc_pa : $('#agreement').prop('checked')
		};
		debugger;
		
		$.ajax({
			type: "POST",
	        url: "buyermodify",
			data: JSON.stringify(data),
			contentType: "application/json",
	        success: function() {
				alert('회원정보가 수정되었습니다.');
				window.location.href="main";
			},
			error: function(xhr, status, error) {
	        	alert("서버 오류가 발생했습니다.");
	        }
			
		})
		
		
	}
	
	
	
});