$(function () {
	$("#selMypage").click(function() {
	    $.ajax({
	        url: 'selMypage',
	        type: 'GET',
	        success: function(res) {
//				let row = $(`<div class="seller-mypage">
//                        <h2>판매자 정보 수정</h2>
//
//                        <div class="profile-section">
//                            <label for="profile-img">프로필 사진</label>
//                            <input type="file" id="profile-img" accept="image/*">
//                            <img id="preview-img" src="default-profile.png" alt="프로필 사진">
//                        </div>
//
//                        <div class="form-group">
//                            <label for="contact">연락처</label>
//                            <input type="text" id="contact" name="contact" placeholder="연락처 입력">
//                        </div>
//
//                        <div class="form-group">
//                            <label for="store-name">스토어 이름</label>
//                            <input type="text" id="store-name" name="store-name" placeholder="스토어 이름 입력">
//                        </div>
//
//                        <div class="form-group">
//                            <label for="store-tag">스토어 태그명</label>
//                            <input type="text" id="store-tag" name="store-tag" placeholder="스토어 태그 입력">
//                        </div>
//
//                        <button id="save-btn">저장</button>
//
//                        <button id="delete-account">회원 탈퇴</button>
//                    </div>
//                `);
		        row.append(res);
		        $(".containers").html(row);
				
	        },
	        error: function(xhr, status, error) {
	            console.log("AJAX 요청 실패: " + error);
	        }
		});
	});
});
