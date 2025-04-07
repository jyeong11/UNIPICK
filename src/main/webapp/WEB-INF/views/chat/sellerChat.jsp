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
<script>
    // 채팅방 팝업 열기 함수
    function openChatPopup(cht_id) {
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
                <a href="javascript:void(0);" onclick="return openChatPopup(${chat.cht_id});" class="chat-item">
<!--                     <div class="chat-profile"> -->
<%--                         <img src="${pageContext.request.contextPath}/resources/images/profile.png" alt="구매자 프로필"> --%>
<!--                     </div> -->
                    <div class="chat-info">
                        <div class="chat-header">
                            <h3>${chat.buy_name}</h3>
                            <span class="chat-time">
                                <fmt:formatDate value="${chat.last_date}" pattern="MM/dd HH:mm" />
                            </span>
                        </div>
                        <div class="chat-preview">
                            <p>${chat.last_message}</p>
                        </div>
                    </div>
                </a>
            </c:forEach>
        </div>
    </div>
</body>
</html> 