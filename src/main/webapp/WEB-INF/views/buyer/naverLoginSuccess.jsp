<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>네이버 로그인 성공</title>
</head>
<body>
<script>
    // 오류 처리 추가
    try {
        // 부모 창을 메인 페이지로 이동시키고 팝업 창 닫기
        if (window.opener && !window.opener.closed) {
            window.opener.location.href = "${pageContext.request.contextPath}/main";
            console.log("부모 창을 메인 페이지로 이동합니다.");
        } else {
            console.log("부모 창을 찾을 수 없습니다.");
        }
    } catch (e) {
        console.error("오류 발생: " + e.message);
    } finally {
        // 항상 창 닫기 실행
        window.close();
    }
</script>
</body>
</html> 