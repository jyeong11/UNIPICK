<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>채팅</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/chat/chat.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/chat/chat-popup.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
    /* 팝업창 스타일 */
    body {
        margin: 0;
        padding: 0;
        overflow: hidden;
        background-color: #f5f5f5;
    }
    
    .popup-container {
        width: 100%;
        height: 100vh;
        display: flex;
        flex-direction: column;
    }
    
    .chat-room {
        width: 100%;
        height: 100%;
        margin: 0;
        border-radius: 0;
        box-shadow: none;
    }
    
    .chat-header {
        position: sticky;
        top: 0;
        z-index: 10;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    
    .chat-title {
        flex: 1;
    }
    
    .chat-controls {
        display: flex;
        gap: 10px;
    }
    
    .chat-messages {
        flex: 1;
        display: flex;
        flex-direction: column;
    }
    
    .chat-input {
        position: sticky;
        bottom: 0;
        z-index: 10;
    }
    
    /* 메시지 정렬 스타일 추가 */
    .message {
        margin-bottom: 15px;
        max-width: 80%;
        display: flex;
        flex-direction: column;
    }
    
    .message.left {
        align-self: flex-start;
        margin-right: auto;
        margin-left: 0;
    }
    
    .message.right {
        align-self: flex-end;
        margin-left: auto;
        margin-right: 0;
    }
    
    .message.center {
        align-self: center;
        margin: 5px auto;
    }
    
    .message.left .message-content {
        background-color: #e0e0e0;
        color: #333;
        border-top-left-radius: 0;
    }
    
    .message.right .message-content {
        background-color: #ffa726;
        color: #fff;
        border-top-right-radius: 0;
    }
    
    .message.center .message-content {
        background-color: #e0e0e0;
        color: #333;
        font-size: 12px;
        padding: 5px 10px;
        border-radius: 12px;
    }
    
    /* 상품 문의 메시지 스타일 */
    .message .message-content[data-product-inquiry="true"] {
        background-color: #e8f5e9;
        border: 1px solid #c8e6c9;
        font-weight: bold;
    }
    
    /* 신고 모달 스타일 */
    .modal {
        display: none;
        position: fixed;
        z-index: 100;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        overflow: auto;
        background-color: rgba(0,0,0,0.4);
    }
    
    .modal-content {
        background-color: #fefefe;
        margin: 15% auto;
        padding: 20px;
        border: 1px solid #888;
        width: 80%;
        max-width: 500px;
        border-radius: 10px;
    }
    
    .close {
        color: #aaa;
        float: right;
        font-size: 28px;
        font-weight: bold;
        cursor: pointer;
    }
    
    .close:hover,
    .close:focus {
        color: black;
        text-decoration: none;
    }
    
    .form-group {
        margin-bottom: 15px;
    }
    
    .form-group label {
        display: block;
        margin-bottom: 5px;
        font-weight: bold;
    }
    
    .form-group textarea {
        width: 100%;
        height: 100px;
        padding: 10px;
        box-sizing: border-box;
        border: 1px solid #ddd;
        border-radius: 5px;
        resize: vertical;
    }
    
    .form-group button {
        background-color: #ff6f00;
        color: white;
        border: none;
        padding: 10px 15px;
        border-radius: 5px;
        cursor: pointer;
    }
    
    .form-group button:hover {
        background-color: #ff8f00;
    }
    
    .report-btn {
        background-color: #f44336;
        color: white;
        border: none;
        padding: 5px 10px;
        border-radius: 5px;
        cursor: pointer;
        font-size: 12px;
    }
    
    .report-btn:hover {
        background-color: #d32f2f;
    }
</style>
</head>
<body>
    <div class="popup-container">
        <div class="chat-room">
            <div class="chat-header">
                <div class="chat-title">
                    <h3>
                        <c:choose>
                            <c:when test="${userType eq 'buyer'}">${chatRoom.sel_nm}</c:when>
                            <c:otherwise>${chatRoom.buy_nm}</c:otherwise>
                        </c:choose>
                    </h3>
                </div>
                <div class="chat-controls">
                    <c:if test="${userType eq 'buyer'}">
                        <button id="reportBtn" class="report-btn">신고하기</button>
                    </c:if>
                    <c:if test="${userType eq 'seller'}">
                        <button id="reportBuyerBtn" class="report-btn">구매자 신고</button>
                    </c:if>
                    <button id="closeBtn" onclick="window.close();">닫기</button>
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
    
    <!-- 신고 모달 -->
    <div id="reportModal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <h2>판매자 신고하기</h2>
            <div class="form-group">
                <label for="reportReason">신고 사유</label>
                <textarea id="reportReason" placeholder="신고 사유를 작성해 주세요."></textarea>
            </div>
            <div class="form-group">
                <button id="submitReport">신고 접수</button>
            </div>
        </div>
    </div>
    
    <!-- 구매자 신고 모달 -->
    <div id="reportBuyerModal" class="modal">
        <div class="modal-content">
            <span class="close buyer-close">&times;</span>
            <h2>구매자 신고하기</h2>
            <div class="form-group">
                <label for="reportBuyerReason">신고 사유</label>
                <textarea id="reportBuyerReason" placeholder="신고 사유를 작성해 주세요."></textarea>
            </div>
            <div class="form-group">
                <button id="submitBuyerReport">신고 접수</button>
            </div>
        </div>
    </div>
    
    <script>
        $(document).ready(function() {
            var cht_id = parseInt("${chatRoom.cht_id}");
            var userType = "${userType}";
            var currentUserId = "${userId}";
            var sel_id = "${chatRoom.sel_id}";
            
            // 로그인 상태 확인
            if (!currentUserId) {
                console.error("사용자 ID가 없습니다. 세션에서 다른 ID 키로 확인을 시도합니다.");
                // 이 부분은 서버에서 이미 처리되었지만, 클라이언트 측에서 추가 확인
                if (userType === "seller" && "${chatRoom.sel_id}") {
                    currentUserId = "${chatRoom.sel_id}";
                    console.log("채팅방 정보에서 판매자 ID를 가져왔습니다:", currentUserId);
                } else if (userType === "buyer" && "${chatRoom.buy_em}") {
                    currentUserId = "${chatRoom.buy_em}";
                    console.log("채팅방 정보에서 구매자 이메일을 가져왔습니다:", currentUserId);
                }
            }
            
            console.log("현재 사용자 유형:", userType);
            console.log("현재 사용자 ID:", currentUserId);
            
            // 자바스크립트 WebSocket 객체를 저장할 변수 선언
            var ws;
            
            // 채팅 메세지 타입을 구분하기 위한 상수 설정
            const TYPE_ENTER = "ENTER"; // 입장
            const TYPE_LEAVE = "LEAVE"; // 퇴장
            const TYPE_TALK = "TALK";   // 대화메세지
            
            // 채팅 메시지 정렬 위치 상수
            const ALIGN_RIGHT = "right";
            const ALIGN_LEFT = "left";
            const ALIGN_CENTER = "center";
            
            // 최초 메시지 로드 (이전 대화 내역)
            loadMessages();
            
            // 웹소켓 연결
            connectWebSocket();
            
            // 신고 버튼 클릭 이벤트
            $("#reportBtn").click(function() {
                $("#reportModal").css("display", "block");
            });
            
            // 구매자 신고 버튼 클릭 이벤트
            $("#reportBuyerBtn").click(function() {
                $("#reportBuyerModal").css("display", "block");
            });
            
            // 신고 모달 닫기 버튼
            $(".close").click(function() {
                $("#reportModal").css("display", "none");
                $("#reportBuyerModal").css("display", "none");
            });
            
            // 모달 외부 클릭 시 닫기
            $(window).click(function(event) {
                if ($(event.target).is("#reportModal")) {
                    $("#reportModal").css("display", "none");
                }
                if ($(event.target).is("#reportBuyerModal")) {
                    $("#reportBuyerModal").css("display", "none");
                }
            });
            
            // 신고 제출 버튼 클릭 이벤트
            $("#submitReport").click(function() {
                var reportReason = $("#reportReason").val().trim();
                
                if (reportReason === "") {
                    alert("신고 사유를 입력해 주세요.");
                    return;
                }
                
                $.ajax({
                    url: "${pageContext.request.contextPath}/chat/report",
                    type: "POST",
                    data: {
                        cht_id: cht_id,
                        rpt_rs: reportReason
                    },
                    dataType: "json",
                    success: function(response) {
                        if (response.success) {
                            alert(response.message);
                            $("#reportModal").css("display", "none");
                            $("#reportReason").val("");
                        } else {
                            alert(response.message);
                        }
                    },
                    error: function() {
                        alert("신고 처리 중 오류가 발생했습니다.");
                    }
                });
            });
            
            // 구매자 신고 제출 버튼 클릭 이벤트
            $("#submitBuyerReport").click(function() {
                var reportReason = $("#reportBuyerReason").val().trim();
                
                if (reportReason === "") {
                    alert("신고 사유를 입력해 주세요.");
                    return;
                }
                
                $.ajax({
                    url: "${pageContext.request.contextPath}/chat/report-buyer",
                    type: "POST",
                    data: {
                        cht_id: cht_id,
                        rpt_rs: reportReason
                    },
                    dataType: "json",
                    success: function(response) {
                        if (response.success) {
                            alert(response.message);
                            $("#reportBuyerModal").css("display", "none");
                            $("#reportBuyerReason").val("");
                        } else {
                            alert(response.message);
                        }
                    },
                    error: function() {
                        alert("신고 처리 중 오류가 발생했습니다.");
                    }
                });
            });
            
            // 메시지 불러오기 (이전 대화 내역)
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
                
                console.log("현재 사용자 유형:", userType);
                console.log("현재 사용자 ID:", currentUserId);
                
                messages.forEach(function(message) {
                    // 메시지 발신자와 현재 사용자 ID를 문자열로 변환하고 공백 제거
                    const sender = String(message.chd_sd || message.sender || '').trim();
                    const userId = String(currentUserId || '').trim();
                    
                    console.log("메시지 발신자(chd_sd):", message.chd_sd);
                    console.log("메시지 발신자(sender):", message.sender);
                    console.log("변환된 발신자:", sender);
                    console.log("변환된 사용자 ID:", userId);
                    
                    // 사용자 유형에 따라 메시지 발신자 식별
                    let isMine = false;
                    
                    if (userType === "buyer") {
                        // 구매자인 경우, 발신자가 구매자 이메일과 일치하는지 확인
                        isMine = sender.toLowerCase() === userId.toLowerCase();
                    } else if (userType === "seller") {
                        // 판매자인 경우, 발신자가 판매자 ID와 일치하는지 확인
                        isMine = sender.toLowerCase() === userId.toLowerCase();
                    } else {
                        // 사용자 유형이 명확하지 않은 경우 기본 비교
                        isMine = sender.toLowerCase() === userId.toLowerCase();
                    }
                    
                    console.log("내 메시지 여부:", isMine);
                    
                    // 메시지 HTML 구성
                    const $messageDiv = $("<div>").addClass("message " + (isMine ? "right" : "left"));
                    
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
            
            // 웹소켓 연결 함수
            function connectWebSocket() {
                // 요청 주소 생성(웹소켓 기본 프로토콜은 ws, 보안 프로토콜은 wss)
               //let ws_base_url = "ws://localhost:8080/UNIPICK";
                let ws_base_url = "ws://c2d2410t2p2.itwillbs.com/UNIPICK";
                
                ws = new WebSocket(ws_base_url + "/echo");
                
                ws.onopen = onOpen;
                ws.onclose = onClose;
                ws.onmessage = onMessage;
                ws.onerror = onError;
            }
            
            // 웹소켓 이벤트 핸들러
            function onOpen() {
                console.log("웹소켓 연결됨");
                // 채팅방 입장 메시지는 표시하지 않고 서버에만 알림
                sendSocketMessage(TYPE_ENTER, "");
            }
            
            function onClose() {
                console.log("웹소켓 연결 종료");
            }
            
            function onError() {
                console.log("웹소켓 오류 발생");
            }
            
            function onMessage(event) {
                console.log("메시지 수신: ", event.data);
                
                const data = JSON.parse(event.data);
                
                if (data.type === TYPE_ENTER || data.type === TYPE_LEAVE) {
                    // 입장/퇴장 메시지 (중앙 정렬)
                    appendMessage(data.message, ALIGN_CENTER);
                } else if (data.type === TYPE_TALK) {
                    // 메시지 데이터 전체 출력 (디버깅)
                    console.log("수신된 메시지 데이터:", data);
                    
                    // 발신자 ID와 현재 사용자 ID를 문자열로 변환하고 공백 제거
                    const sender = String(data.sender_id || data.chd_sd || '').trim();
                    const userId = String(currentUserId || '').trim();
                    
                    console.log("메시지 발신자(sender_id):", data.sender_id);
                    console.log("메시지 발신자(chd_sd):", data.chd_sd);
                    console.log("변환된 발신자:", sender);
                    console.log("변환된 사용자 ID:", userId);
                    
                    // 사용자 유형에 따라 메시지 발신자 식별
                    let isMine = false;
                    
                    if (userType === "buyer") {
                        // 구매자인 경우, 발신자가 구매자 이메일과 일치하는지 확인
                        isMine = sender.toLowerCase() === userId.toLowerCase();
                    } else if (userType === "seller") {
                        // 판매자인 경우, 발신자가 판매자 ID와 일치하는지 확인
                        isMine = sender.toLowerCase() === userId.toLowerCase();
                    } else {
                        // 사용자 유형이 명확하지 않은 경우 기본 비교
                        isMine = sender.toLowerCase() === userId.toLowerCase();
                    }
                    
                    console.log("내 메시지 여부:", isMine);
                    
                    if (isMine) {
                        // 내가 보낸 메시지는 표시하지 않음 (이미 즉시 표시됨)
                        console.log("내가 보낸 메시지로 판단하여 표시하지 않음");
                        return;
                    }
                    
                    // 대화 메시지 (좌측 정렬 - 다른 사람의 메시지)
                    console.log("상대방 메시지 표시:", data.message);
                    const messageContent = data.message;
                    appendMessage(messageContent, ALIGN_LEFT);
                }
            }
            
            // 메시지 추가 함수
            function appendMessage(message, align) {
                const $messageDiv = $("<div>").addClass("message " + align);
                const $messageContent = $("<div>").addClass("message-content").text(message);
                
                $messageDiv.append($messageContent);
                $("#messages").append($messageDiv);
                
                // 스크롤을 맨 아래로 이동
                $("#messages").scrollTop($("#messages")[0].scrollHeight);
            }
            
            // 시간 포맷팅 함수
            function formatTime(date) {
                const hours = date.getHours().toString().padStart(2, '0');
                const minutes = date.getMinutes().toString().padStart(2, '0');
                return hours + ":" + minutes;
            }
            
            // 웹소켓으로 메시지 전송
            function sendSocketMessage(type, message) {
                if (ws.readyState === WebSocket.OPEN) {
                    let param = {type, message};
                    ws.send(JSON.stringify(param));
                } else {
                    console.log("웹소켓이 연결되지 않았습니다.");
                }
            }
            
            // 메시지 전송 (버튼 클릭)
            $("#sendBtn").click(sendMessage);
            
            // 메시지 전송 (엔터키)
            $("#messageInput").keypress(function(e) {
                if (e.which === 13) {  // Enter 키
                    sendMessage();
                    return false;  // 기본 동작 방지
                }
            });
            
            // 메시지 전송 함수
            function sendMessage() {
                const message = $("#messageInput").val().trim();
                
                if (message === "") {
                    return;
                }
                
                // DB에 메시지 저장 (기존 AJAX 방식)
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
                            // 메시지 입력창 초기화
                            $("#messageInput").val("");
                            
                            // 내 메시지는 오른쪽에 즉시 표시
                            appendMessage(message, ALIGN_RIGHT);
                            
                            // 웹소켓으로 다른 사용자에게 메시지 전송
                            sendSocketMessage(TYPE_TALK, message);
                        } else {
                            alert(response.message);
                        }
                    },
                    error: function() {
                        alert("메시지 전송 중 오류가 발생했습니다.");
                    }
                });
            }
            
            // 포커스 설정
            $("#messageInput").focus();
            
            // 창 닫기 전 이벤트
            window.addEventListener('beforeunload', function() {
                if (ws && ws.readyState === WebSocket.OPEN) {
                    sendSocketMessage(TYPE_LEAVE, "");
                    ws.close();
                }
            });
        });
    </script>
</body>
</html>