<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<nav>
<a href="chat/buyer/list" class="chat-link">
    <img class="chat" src="${pageContext.request.contextPath}/resources/images/chat.png" alt="실시간 상담">
    <span id="chatNotificationBadge" class="notification-badge" style="display: none;">0</span>
</a>
</nav>
<div class="ft-nav">
	<ul class="ft-navinner">
		<li><a href="#"><i class="fa-solid fa-house"></i><span class="gray-footer">홈</span></a></li>
		<li><a href="category"><i class="fa-solid fa-bars"></i><span class="gray-footer">카테고리</span></a></li>
		<li><a href="#"><i class="fa-solid fa-heart"></i><span class="gray-footer">찜</span></a></li>
		<li><a href="memberJoin"><i class="fa-solid fa-user"></i><span class="gray-footer">마이페이지</span></a></li>
	</ul>
</div>

<footer>
<div class="ft-wrap">
	<div class="ft-inner">
		<div class="top">
			<h3>유니픽</h3>
			<dl>
			<dt>대표자</dt>
			<dd>배지영</dd>
			<dt>사업자등록번호</dt>
			<dd>123-45-67890</dd>
			<dt>통신판매업신고</dt>
			<dd>2025-부산진구-1739</dd>
			<dt>대표번호</dt>
			<dd>051-803-0909</dd>
			<dt>문의</dt>
			<dd>help@unipick.com</dd>
			</dl>
		</div>
		<div class="bottom line">
			<ul>
			<li><a href="policy">이용약관</a></li>
			<li><a href="privacy">개인정보처리방침</a></li>
			</ul>
		</div>
	</div>
</div>
</footer>

<style>
.chat-link {
    position: relative;
    display: inline-block;
}

.notification-badge {
    position: fixed;
    top: 740px;
    right: 43px;
    background-color: #7422bd;
    color: white;
    border-radius: 50%;
    width: 26px;
    height: 26px;
    text-align: center;
    line-height: 20px;
    font-size: 15px;
    font-weight: bold;
    z-index: 9999;
}
</style>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function() {
    // 새 메시지 개수 확인 함수
    function checkNewMessages() {
        $.ajax({
            url: "${pageContext.request.contextPath}/chat/new-messages/count",
            type: "GET",
            dataType: "json",
            success: function(response) {
                if (response.success && response.count > 0) {
                    // 새 메시지가 있으면 배지 표시
                    $("#chatNotificationBadge").text(response.count).show();
                } else {
                    // 새 메시지가 없으면 배지 숨김
                    $("#chatNotificationBadge").hide();
                }
            },
            error: function() {
                console.error("메시지 알림 확인 중 오류가 발생했습니다.");
            }
        });
    }
    
    // 채팅 링크 클릭 시 확인 시간 업데이트
    $(".chat-link").click(function() {
        $.ajax({
            url: "${pageContext.request.contextPath}/chat/update-last-checked",
            type: "POST",
            dataType: "json"
        });
    });
    
    // 페이지 로드 시 최초 확인
    checkNewMessages();
    
    // 30초마다 새 메시지 확인
    setInterval(checkNewMessages, 30000);
});
</script>