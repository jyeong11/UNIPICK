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
        // cht_id가 유효한지 검사
        if (!cht_id || cht_id === undefined || cht_id === 'undefined' || cht_id === 'null' || cht_id === null) {
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
    
    // 새 채팅 시작 함수
    function startNewChat(sel_id) {
        // 팝업 창 옵션
        var popupWidth = 400;
        var popupHeight = 600;
        var left = (window.innerWidth - popupWidth) / 2;
        var top = (window.innerHeight - popupHeight) / 2;
        var popupOptions = "width=" + popupWidth + ",height=" + popupHeight + 
                           ",left=" + left + ",top=" + top + 
                           ",resizable=yes,scrollbars=yes,toolbar=no,menubar=no,location=no";
        
        // 팝업 창 열기
        window.open("${pageContext.request.contextPath}/chat/popup/start?sel_id=" + sel_id, "chatPopup_new", popupOptions);
        
        // 검색창 초기화
        $("#sellerSearchInput").val("");
        $("#searchResults").empty().hide();
        
        return false;
    }
    
    $(document).ready(function() {
        // 검색창 이벤트
        $("#sellerSearchInput").on("input", function() {
            var searchTerm = $(this).val().trim();
            
            // 입력값이 2글자 이상일 때만 검색
            if (searchTerm.length >= 2) {
                $.ajax({
                    url: "${pageContext.request.contextPath}/chat/search/sellers",
                    type: "GET",
                    data: { term: searchTerm },
                    dataType: "json",
                    success: function(response) {
                        if (response.success) {
                            displaySearchResults(response.sellers);
                        }
                    },
                    error: function() {
                        console.error("판매자 검색 중 오류가 발생했습니다.");
                    }
                });
            } else {
                $("#searchResults").empty().hide();
            }
        });
        
        // 검색 결과 표시 함수
        function displaySearchResults(sellers) {
            var $results = $("#searchResults");
            $results.empty();
            
            if (sellers.length === 0) {
                $results.append("<div class='no-results'>검색 결과가 없습니다.</div>");
            } else {
                sellers.forEach(function(seller) {
                    var $sellerItem = $("<div class='seller-item'></div>");
                    
                    // 판매자 프로필 및 정보
                    var $sellerInfo = $("<div class='seller-info'>" +
                                        "<div class='seller-details'>" +
                                        "<h4>" + seller.sel_nm + "</h4>" +
                                        "<span>" + seller.sel_id + "</span>" +
                                        "</div>" +
                                        "</div>");
                    
                    // 채팅 시작 버튼
                    var $startChatBtn = $("<button class='start-chat-btn'>채팅 시작</button>");
                    $startChatBtn.on("click", function() {
                        startNewChat(seller.sel_id);
                    });
                    
                    $sellerItem.append($sellerInfo).append($startChatBtn);
                    $results.append($sellerItem);
                });
            }
            
            $results.show();
        }
        
        // 검색창 외부 클릭 시 결과 숨기기
        $(document).on("click", function(e) {
            if (!$(e.target).closest(".search-container").length) {
                $("#searchResults").hide();
            }
        });
    });
</script>
</head>
<body>
    <div class="container">
        <h2>채팅 목록</h2>
        
        <!-- 판매자 검색 -->
        <div class="search-container">
            <input type="text" id="sellerSearchInput" placeholder="판매자 이름 또는 ID로 검색">
            <div id="searchResults" class="search-results"></div>
        </div>
        
        <div class="chat-list">
            <c:if test="${empty chatList}">
                <div class="empty-chat">
                    <p>채팅 내역이 없습니다.</p>
                </div>
            </c:if>
            
            <c:forEach var="chat" items="${chatList}">
                <c:choose>
                    <c:when test="${not empty chat.cht_id}">
                        <a href="javascript:void(0);" onclick="openChatPopup(${chat.cht_id}); return false;" class="chat-item">
<!--                             <div class="chat-profile"> -->
<%--                                 <img src="${pageContext.request.contextPath}/resources/images/profile.png" alt="판매자 프로필"> --%>
<!--                             </div> -->
                            <div class="chat-info">
                                <div class="chat-header">
                                    <h3>${chat.sel_nm}</h3>
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
                        </a>
                    </c:when>
                    <c:otherwise>
                        <!-- 채팅방 ID가 없는 경우 -->
                        <div class="chat-item">
<!--                             <div class="chat-profile"> -->
<%--                                 <img src="${pageContext.request.contextPath}/resources/images/profile.png" alt="판매자 프로필"> --%>
<!--                             </div> -->
                            <div class="chat-info">
                                <div class="chat-header">
                                    <h3>${chat.sel_nm}</h3>
                                    <span class="chat-time">신규 채팅</span>
                                </div>
                                <div class="chat-preview">
                                    <p>채팅방이 아직 생성되지 않았습니다. 판매자를 검색하여 새 채팅을 시작하세요.</p>
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