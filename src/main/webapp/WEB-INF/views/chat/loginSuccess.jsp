<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 성공</title>
<script>
    // 로그인 성공 후 처리
    window.onload = function() {
        var urlParams = new URLSearchParams(window.location.search);
        var redirect = urlParams.get('redirect');
        var prd_cd = urlParams.get('prd_cd');
        var prd_nm = urlParams.get('prd_nm');
        
        if (redirect === 'product-inquiry' && prd_cd && prd_nm) {
            // 부모 창에서 상품 문의 창 열기
            if (window.opener) {
                var popupUrl = "${pageContext.request.contextPath}/chat/product-inquiry?prd_cd=" + prd_cd + "&prd_nm=" + encodeURIComponent(prd_nm);
                window.opener.open(popupUrl, "상품문의", "width=500,height=700");
                // 로그인 창 닫기
                window.close();
            }
        } else {
            // 일반 로그인인 경우 메인 페이지로 이동
            location.href = "${pageContext.request.contextPath}/";
        }
    };
</script>
</head>
<body>
    <p>로그인 성공! 잠시 후 이동합니다...</p>
</body>
</html>