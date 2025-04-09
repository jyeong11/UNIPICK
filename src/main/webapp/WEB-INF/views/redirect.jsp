<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리다이렉트</title>
</head>
<body>
<script>
    var msg = "${msg}";
    var url = "${url}";
    
    console.log("메시지: " + msg);
    console.log("URL: " + url);
    
    if(msg && msg.length > 0) {
        alert(msg);
    }
    
    if(url && url.length > 0) {
        location.href = "${pageContext.request.contextPath}" + url;
    } else {
        history.back();
    }
</script>
</body>
</html> 