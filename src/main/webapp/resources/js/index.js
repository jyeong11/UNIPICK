window.onload = function () {
    const urlParams = new URLSearchParams(window.location.search);
    const code = urlParams.get("code");

    if (code) {
        console.log("받은 인증 코드:", code);

        // Access Token 요청
        fetch("/getToken", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({ code: code })
        })
        .then(res => res.json())
        .then(data => {
            console.log("Access Token:", data.access_token);

            // Access Token을 부모 창(메인 페이지)으로 전달
            if (window.opener) {
                window.opener.postMessage({ accessToken: data.access_token }, "*");
            }

            window.close();
        })
        .catch(err => console.error("Access Token 요청 실패:", err));
    } else {
        console.error("code 값이 없습니다.");
    }
};
