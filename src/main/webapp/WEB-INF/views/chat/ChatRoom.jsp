<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>채팅</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/chat/chat.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    
    <div class="container">
        <div class="chat-room">
            <div class="chat-header">
                <div class="back-btn">
                    <a href="javascript:history.back();">
                        <i class="fas fa-arrow-left"></i>
                    </a>
                </div>
                <div class="chat-title">
                    <h3>
                        <c:choose>
                            <c:when test="${userType eq 'buyer'}">${chatRoom.sel_name}</c:when>
                            <c:otherwise>${chatRoom.buy_name}</c:otherwise>
                        </c:choose>
                    </h3>
                </div>
            </div>
            
            <div class="chat-messages" id="messages">
                <!-- 메시지 내용은 JavaScript로 동적으로 로드됨 -->
            </div>
            
            <div class="chat-input">
                <input type="text" id="messageInput" placeholder="메시지를 입력하세요..." />
                <button id="sendBtn">전송</button>
            </div>
        </div>
    </div>
    <script>
        $(document).ready(function() {
            const cht_id = ${chatRoom.cht_id};
            const userType = "${userType}";
            
            // 메시지 불러오기
            function loadMessages() {
                $.ajax({
                    url: "${pageContext.request.contextPath}/chat/messages/" + cht_id,
                    type: "GET",
                    dataType: "json",
                    success: function(response) {
                        if (response.success) {
                            displayMessages(response.messages);
                        } else {
                            alert(response.message);
                        }
                    },
                    error: function() {
                        alert("메시지 로딩 중 오류가 발생했습니다.");
                    }
                });
            }
            
            // 메시지 화면에 표시
            function displayMessages(messages) {
                const $messages = $("#messages");
                $messages.empty();
                
                messages.forEach(function(message) {
                    // 메시지 발신자 타입 판단
                    let isMine = false;
                    
                    if (userType === 'buyer' && message.sender_type === 'buyer') {
                        isMine = true;
                    } else if (userType === 'seller' && message.sender_type === 'seller') {
                        isMine = true;
                    }
                    
                    // 메시지 HTML 구성
                    const $messageDiv = $("<div>").addClass(isMine ? "message mine" : "message other");
                    
                    const $messageContent = $("<div>").addClass("message-content");
                    $messageContent.text(message.chd_ms);
                    
                    const $messageTime = $("<div>").addClass("message-time");
                    const messageDate = new Date(message.chd_st);
                    $messageTime.text(formatTime(messageDate));
                    
                    $messageDiv.append($messageContent, $messageTime);
                    $messages.append($messageDiv);
                });
                
                // 스크롤을 맨 아래로 이동
                $messages.scrollTop($messages[0].scrollHeight);
            }
            
            // 시간 포맷팅 함수
            function formatTime(date) {
                const hours = date.getHours().toString().padStart(2, '0');
                const minutes = date.getMinutes().toString().padStart(2, '0');
                return hours + ":" + minutes;
            }
            
            // 메시지 전송
            $("#sendBtn").click(sendMessage);
            
            $("#messageInput").keypress(function(e) {
                if (e.which === 13) {  // Enter 키
                    sendMessage();
                    return false;  // 기본 동작 방지
                }
            });
            
            function sendMessage() {
                const message = $("#messageInput").val().trim();
                
                if (message === "") {
                    return;
                }
                
                $.ajax({
                    url: "${pageContext.request.contextPath}/chat/send",
                    type: "POST",
                    data: {
                        cht_id: cht_id,
                        message: message
                    },
                    dataType: "json",
                    success: function(response) {
                        if (response.success) {
                            $("#messageInput").val("");
                            loadMessages();  // 메시지 다시 로드
                        } else {
                            alert(response.message);
                        }
                    },
                    error: function() {
                        alert("메시지 전송 중 오류가 발생했습니다.");
                    }
                });
            }
            
            // 페이지 로드 시 메시지 로드
            loadMessages();
            
            // 주기적으로 메시지 갱신 (5초마다)
            setInterval(loadMessages, 5000);
        });
    </script>
</body>
</html> 