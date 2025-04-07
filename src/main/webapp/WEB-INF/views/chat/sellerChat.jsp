<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>채팅 목록</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/chat/chat.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
    .chat-item {
        cursor: pointer;
        padding: 15px;
        border-bottom: 1px solid #eee;
        display: flex;
        align-items: center;
    }
    .chat-item:hover {
        background-color: #f5f5f5;
    }
</style>
<script>
    // 채팅방 팝업 열기 함수
    function openChatPopup(cht_id) {
        // cht_id가 유효한지 검사
        if (!cht_id || cht_id === undefined || cht_id === 'undefined' || cht_id === 'null' || cht_id === null || cht_id <= 0) {
            console.error("유효하지 않은 채팅방 ID입니다: " + cht_id);
            alert("유효하지 않은 채팅방입니다.");
            return false;
        }
        
        // 채팅방 ID가 숫자인지 확인
        if (isNaN(parseInt(cht_id))) {
            console.error("채팅방 ID가 숫자가 아닙니다: " + cht_id);
            alert("유효하지 않은 채팅방입니다.");
            return false;
        }
        
        // 팝업 창 옵션
        var popupWidth = 400;
        var popupHeight = 600;
        var left = (window.innerWidth - popupWidth) / 2;
        var top = (window.innerHeight - popupHeight) / 2;
        var popupOptions = "width=" + popupWidth + ",height=" + popupHeight + 
                           ",left=" + left + ",top=" + top + 
                           ",resizable=yes,scrollbars=yes,toolbar=no,menubar=no,location=no";
        
        // 팝업 창 열기
        window.open("${pageContext.request.contextPath}/chat/popup/" + cht_id, "chatPopup_" + cht_id, popupOptions);
        
        // 기본 링크 동작 방지
        return false;
    }
</script>
</head>
<body>
    <div class="container">
        <h2>채팅 목록</h2>
        
        <div class="chat-list">
            <c:if test="${empty chatList}">
                <div class="empty-chat">
                    <p>채팅 내역이 없습니다.</p>
                </div>
            </c:if>
            
            <c:forEach var="chat" items="${chatList}">
                <c:choose>
                    <c:when test="${not empty chat.cht_id and chat.cht_id > 0}">
                        <div class="chat-item" onclick="openChatPopup(${chat.cht_id})">
<!--                             <div class="chat-profile"> -->
<%--                                 <img src="${pageContext.request.contextPath}/resources/images/profile.png" alt="구매자 프로필"> --%>
<!--                             </div> -->
                            <div class="chat-info">
                                <div class="chat-header">
                                    <h3>
                                    <c:choose>
                                        <c:when test="${not empty chat.buy_nm}">
                                            ${chat.buy_nm}
                                        </c:when>
                                        <c:otherwise>
                                            구매자 [이름없음]
                                        </c:otherwise>
                                    </c:choose>
                                    </h3>
                                    <span class="chat-time">
                                        <c:if test="${not empty chat.last_date}">
                                            <fmt:formatDate value="${chat.last_date}" pattern="MM/dd HH:mm" />
                                        </c:if>
                                        <c:if test="${empty chat.last_date}">
                                            신규 채팅
                                        </c:if>
                                    </span>
                                </div>
                                <div class="chat-preview">
                                    <p>${not empty chat.last_message ? chat.last_message : '아직 메시지가 없습니다.'}</p>
                                </div>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <!-- 채팅방 ID가 없는 경우 -->
                        <div class="chat-item">
<!--                             <div class="chat-profile"> -->
<%--                                 <img src="${pageContext.request.contextPath}/resources/images/profile.png" alt="구매자 프로필"> --%>
<!--                             </div> -->
                            <div class="chat-info">
                                <div class="chat-header">
                                    <h3>
                                    <c:choose>
                                        <c:when test="${not empty chat.buy_nm}">
                                            ${chat.buy_nm}
                                        </c:when>
                                        <c:otherwise>
                                            구매자 [이름없음]
                                        </c:otherwise>
                                    </c:choose>
                                    </h3>
                                    <span class="chat-time">신규 채팅</span>
                                </div>
                                <div class="chat-preview">
                                    <p>채팅방이 아직 생성되지 않았습니다. 관리자에게 문의하세요.</p>
                                </div>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </div>
    </div>
</body>
</html> 